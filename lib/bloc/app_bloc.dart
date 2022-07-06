import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:now_apps_task/models/products_model.dart';
import 'package:now_apps_task/models/retailer_model.dart';
import 'package:now_apps_task/utils/repository.dart';
import 'package:sqflite/sqflite.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final Repository repository;

  AppBloc({required this.repository}) : super(AppInitial()) {
    on<InitializeDatabases>((event, emit) async {
      try {
        await repository.initializeDatabase();
      } catch (e) {
        print(e);
      }
    });

    on<RefreshRetailersEvent>((event, emit) async {
      try {
        final list = await repository.getAllRetailers();
        emit(RetailersListRefreshed(list: list));
      } catch (e) {
        print(e);
      }
    });

    on<LoadProductsListEvent>((event, emit) async {
      try {
        final productList = await repository.allProducts();
        final cartCountList = await repository.checkInCart(productList);
        emit(ProductsListLoaded(
            productList: productList, cartCountList: cartCountList));
      } catch (e) {
        print(e);
      }
    });

    on<CheckInEvent>((event, emit) async {
      await sharedPreferences.setInt('checkedIn', event.id);
      emit(CheckInSuccess());
    });

    on<CheckOutEvent>((event, emit) async{
      await cartDatabase.rawDelete('DELETE FROM cart');
      await productsDatabase.rawDelete('DELETE FROM products');
      await sharedPreferences.remove('checkedIn');
      emit(CheckOutSuccess());
    });

    on<AddToCartEvent>((event, emit) async {
      await repository.addToCart(
          productId: event.productId, productCount: event.productCount);
      if (event.isHome) {
        add(LoadProductsListEvent());
      } else {
        add(LoadCartProducts());
      }
    });

    on<RemoveFromCartEvent>((event, emit) async {
      await repository.removeFromCart(productId: event.productId);
      add(LoadProductsListEvent());
    });

    on<LoadCartProducts>((event, emit) async {
      final productList = await repository.cartProductsList();
      final cartCountList = await repository.checkInCart(productList);
      emit(CartProductsLoaded(
          productList: productList, cartCountList: cartCountList));
    });

    on<StayHereEvent>((event, emit) async{
      await cartDatabase.rawDelete('DELETE FROM cart');
      await productsDatabase.rawDelete('DELETE FROM products');
      emit(StayHereState());
    });

   on<LogInEvent>((event, emit)async{
     final retailers = await repository.getAllRetailers();
     if(retailers.isEmpty) {
       final sample1 = RetailerModel(
           id: 1,
           state: "Rajasthan",
           image: 'assets/avatars/four.png',
           number: 9567387758,
           address: "Eratat",
           city: "Palakkad",
           ownerName: "Raja",
           shopName: "Birla");
       final sample2 = RetailerModel(
           id: 1,
           state: "Rajasthan",
           image: 'assets/avatars/three.png',
           number: 9567387758,
           address: "Eratat",
           city: "Noida",
           ownerName: "Ambani",
           shopName: "Reliance");
       await repository.addRetailer(sample1);
       await repository.addRetailer(sample2);
     }
     await sharedPreferences.setBool('isLoggedIn', true);
     emit(LogInSuccess());
   });
  }
}
