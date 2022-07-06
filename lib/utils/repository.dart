import 'package:dio/dio.dart';
import 'package:now_apps_task/models/products_model.dart';
import 'package:now_apps_task/models/retailer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

late Database retailerDatabase;
late Database productsDatabase;
late Database cartDatabase;
late SharedPreferences sharedPreferences;

class Repository {
  final Dio _dio = Dio();

  Future<void> initializeDatabase() async {
    retailerDatabase = await openDatabase('now.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE retailer (id INTEGER PRIMARY KEY ,shopName TEXT, ownerName TEXT, address TEXT, number INTEGER, city TEXT, state TEXT, image TEXT)');
    });
    productsDatabase = await openDatabase('products.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE products (id INTEGER PRIMARY KEY,prodImage TEXT ,prodCode TEXT,prodName TEXT,UOM TEXT,unit_id TEXT,prodShortName TEXT,prodPrice TEXT,prodMrp TEXT)');
    });
    cartDatabase = await openDatabase('cart.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE cart ( id INTEGER PRIMARY KEY, productId INTEGER, productCount INTEGER)');
    });
  }

  Future<void> addRetailer(RetailerModel retailerModel) async {
    await retailerDatabase.rawInsert(
        'INSERT INTO retailer(shopName,ownerName,address,number,city,state,image) VALUES(?,?,?,?,?,?,?)',
        [
          retailerModel.shopName,
          retailerModel.ownerName,
          retailerModel.address,
          retailerModel.number,
          retailerModel.city,
          retailerModel.state,
          retailerModel.image
        ]);
  }

  Future<List<RetailerModel>> getAllRetailers() async {
    final listOfRetailers =
        await retailerDatabase.rawQuery('SELECT * FROM retailer');
    List<RetailerModel> list = [];
    for (var element in listOfRetailers) {
      list.add(RetailerModel.fromJson(element));
    }
    return list;
  }

  Future<void> clearRetailers() async {
    await deleteDatabase('now.db');
  }

  Future<List<Product>> allProducts() async {
    final isAdded = await productsDatabase.rawQuery('SELECT * FROM products');
    if (isAdded.isNotEmpty) {
      List<Product> list = [];
      for (int i = 0; i < isAdded.length; i++) {
        list.add(Product.fromJson(isAdded[i], i+1));
      }
      return list;
    } else {
      try {
        final response = await _dio.get("https://jsonkeeper.com/b/YIDG");
        List<Product> list = [];
        for (int i = 0; i < response.data["data"]["products"].length; i++) {
          final productModel =
              Product.fromJson(response.data["data"]["products"][i], i+1);
          list.add(productModel);
          await productsDatabase.rawInsert(
              'INSERT INTO products (prodImage,prodCode,prodName,UOM,unit_id,prodShortName,prodPrice,prodMrp) VALUES (?,?,?,?,?,?,?,?)',
              [
                productModel.prodImage,
                productModel.prodCode,
                productModel.prodName,
                productModel.uom,
                productModel.unitId,
                productModel.prodShortName,
                productModel.prodPrice,
                productModel.prodMrp
              ]);
        }
        return list;
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<List<int>> checkInCart(List<Product> productList) async{
    List<int> countList = [];
    final cartProducts = await getCartProducts();
    for(int i=0;i<productList.length;i++){
      bool isFound = false;
      for(int j=0;j<cartProducts.length;j++){
        if(productList[i].id==cartProducts[j]["productId"]){
          isFound = true;
          countList.add(cartProducts[j]["productCount"] as int);
          break;
        }
      }
      if(!isFound){
        countList.add(0);
      }
    }
    return countList;
  }

  Future<void> addToCart(
      {required int productId, required int productCount}) async {
    final isThere = await cartDatabase.rawQuery(
        'SELECT id FROM cart WHERE productId=$productId');
    if (isThere.isNotEmpty) {
      await cartDatabase.rawUpdate('UPDATE cart SET productCount = ? WHERE productId =?',[productCount,productId]);
    } else {
      await cartDatabase.rawInsert(
          'INSERT INTO cart (productId,productCount) VALUES (?,?)',
          [productId, productCount]);
    }
  }

  Future<void> removeFromCart({required int productId})async{
    await cartDatabase.rawDelete('DELETE FROM cart WHERE productId = ?',[productId]);
  }

  Future<List<Map<String, Object?>>> getCartProducts()async{
    final list = await cartDatabase.rawQuery('SELECT * FROM cart');
    return list;
  }

  Future<List<Product>> cartProductsList() async{
    List<Product> cartList = [];
    final productList = await allProducts();
    final cartProducts = await getCartProducts();
    // for(int i=0;i<cartProducts.length;i++){
    //   for(int j=0;j<productList.length;j++){
    //
    //   }
    // }
    for(int i=0;i<productList.length;i++){
      for(int j=0;j<cartProducts.length;j++){
        if(productList[i].id==cartProducts[j]["productId"]){
          cartList.add(productList[i]);
          break;
        }
      }
    }
    return cartList;
  }
}
