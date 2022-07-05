part of 'app_bloc.dart';

@immutable
abstract class AppEvent {}

class InitializeDatabases extends AppEvent {}

class RefreshRetailersEvent extends AppEvent {}

class LoadProductsListEvent extends AppEvent {}

class CheckInEvent extends AppEvent {
  final int id;
  CheckInEvent({required this.id});
}

class CheckOutEvent extends AppEvent{}

class StayHereEvent extends AppEvent{}

class LogOutEvent extends AppEvent{}

class AddToCartEvent extends AppEvent{
  final bool isHome;
  final int productId;
  final int productCount;
  AddToCartEvent({required this.productId,required this.productCount,required this.isHome});
}

class RemoveFromCartEvent extends AppEvent{
  final int productId;
  RemoveFromCartEvent({required this.productId});
}

class LoadCartProducts extends AppEvent{}
