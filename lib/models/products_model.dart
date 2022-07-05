class Product {
  Product({
    required this.id,
    required this.prodImage,
    required this.prodCode,
    required this.prodName,
    required this.uom,
    required this.unitId,
    required this.prodShortName,
    required this.prodPrice,
    required this.prodMrp,
  });

  int id;
  String prodImage;
  String prodCode;
  String prodName;
  String uom;
  String unitId;
  String prodShortName;
  String prodPrice;
  String prodMrp;

  factory Product.fromJson(Map<String, dynamic> json,int id) => Product(
    id: json["id"]??id,
    prodImage: json["prodImage"],
    prodCode: json["prodCode"],
    prodName: json["prodName"],
    uom: json["UOM"],
    unitId: json["unit_id"],
    prodShortName: json["prodShortName"],
    prodPrice: json["prodPrice"],
    prodMrp: json["prodMrp"],
  );
}
