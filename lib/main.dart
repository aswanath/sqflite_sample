import 'package:flutter/material.dart';
import 'package:now_apps_task/models/retailer_model.dart';
import 'package:now_apps_task/utils/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Repository().initializeDatabase();
  // final verthe = RetailerModel(
  //   id: 1,
  //     state: "Rajasthan",
  //     image: 'assets/avatars/four.png',
  //     number: 9567387758,
  //     address: "Eratat",
  //     city: "Palakkad",
  //     ownerName: "Raja",
  //     shopName: "Birla");
  // await Repository().addRetailer(verthe);
  // await deleteDatabase('cart.db');
  // final verht = await Repository().allProducts();
  final check = await cartDatabase.rawQuery("SELECT * FROM cart");
  print(check);
  runApp(const MyApp());
}
