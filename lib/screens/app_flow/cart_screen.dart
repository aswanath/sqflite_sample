import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:now_apps_task/bloc/app_bloc.dart';
import 'package:now_apps_task/screens/app_flow/home_page.dart';
import 'package:now_apps_task/screens/app_flow/products_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider.value(
      value: context.read<AppBloc>()..add(LoadCartProducts()),
      child: BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          if (state is StayHereState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductsDetailsScreen()),
                (route) => false);
            return;
          }
          if(state is CheckOutSuccess){
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false);
          }
        },
        child: _Scaffold(),
      ),
    ));
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Order Placed Successfully",
                            style: TextStyle(fontSize: 24),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                context.read<AppBloc>().add(CheckOutEvent());
                              },
                              child: const Text("Check Out")),
                          const Divider(),
                          TextButton(
                              onPressed: () {
                                context.read<AppBloc>().add(StayHereEvent());
                              },
                              child: const Text("Stay Here")),
                        ],
                      ),
                    ),
                  );
                });
          },
          label: const Text("Place Order")),
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: BlocBuilder<AppBloc, AppState>(buildWhen: (prev, curr) {
        if (curr is CartProductsLoaded) {
          return true;
        }
        return false;
      }, builder: (context, state) {
        if (state is CartProductsLoaded) {
          if (state.productList.isEmpty) {
            return const Center(
              child: Text("Cart is empty"),
            );
          } else {
            return ListView.builder(
                itemCount: state.productList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Image.network(
                          state.productList[index].prodImage,
                          width: 100,
                          height: 100,
                          errorBuilder: (context, object, stackTrace) {
                            return const Text("No image found");
                          },
                        ),
                        title: Text(state.productList[index].prodName),
                        subtitle: Text(
                            '\u{20B9} ${state.productList[index].prodPrice}'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (state.cartCountList[index] > 0) {
                                  if(state.cartCountList[index]==1){
                                    context.read<AppBloc>().add(RemoveFromCartEvent(productId: state.productList[index].id));
                                  }
                                  else{
                                    context.read<AppBloc>().add(AddToCartEvent(
                                        isHome: false,
                                        productId: state.productList[index].id,
                                        productCount:
                                        state.cartCountList[index] - 1));
                                  }

                                }
                              },
                              icon: const Text(
                                "-",
                                style: TextStyle(fontSize: 26),
                              )),
                          Text(state.cartCountList[index].toString()),
                          IconButton(
                              onPressed: () {
                                context.read<AppBloc>().add(AddToCartEvent(
                                    productId: state.productList[index].id,
                                    productCount:
                                        state.cartCountList[index] + 1,
                                    isHome: false));
                              },
                              icon: const Text("+",
                                  style: TextStyle(fontSize: 26))),
                        ],
                      )
                    ],
                  );
                });
          }
        } else {
          return const Text("Something went wrong");
        }
      }),
    );
  }
}
