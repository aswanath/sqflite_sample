

class RetailerModel {
  final int? id;
  final String shopName;
  final String ownerName;
  final String address;
  final int number;
  final String state;
  final String city;
  final String image;

  RetailerModel(
      {required this.state,
         this.id,
      required this.image,
      required this.number,
      required this.address,
      required this.city,
      required this.ownerName,
      required this.shopName});

  factory RetailerModel.fromJson(Map<String, dynamic> element) {
    return RetailerModel(
      id: element["id"] as int,
        state: element["state"] as String,
        image: element["image"] as String,
        number: element["number"] as int,
        address: element["address"] as String,
        city: element["city"] as String,
        ownerName: element["ownerName"] as String,
        shopName: element["shopName"] as String);
  }

  static Map<String,dynamic> toJson(RetailerModel retailer){
    return {
      "state" : retailer.state,
      "image" : retailer.image,
      "number" : retailer.number,
      "address" : retailer.address,
      "city" : retailer.city,
      "ownerName" :retailer.ownerName,
      "shopName" : retailer.shopName
    };
  }
}
