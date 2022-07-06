part of 'app_bloc.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class RetailersListRefreshed extends AppState{
  final List<RetailerModel> list;
  RetailersListRefreshed({required this.list});
}

class ProductsListLoaded extends AppState{
  final List<Product> productList;
  final List<int> cartCountList;
  ProductsListLoaded({required this.productList,required this.cartCountList});
}

class CheckInSuccess extends AppState{}

class CartProductsLoaded extends AppState{
  final List<Product> productList;
  final List<int> cartCountList;
  CartProductsLoaded({required this.productList,required this.cartCountList});
}

class CheckOutSuccess extends AppState{}

class StayHereState extends AppState{}

class LogInSuccess extends AppState{}