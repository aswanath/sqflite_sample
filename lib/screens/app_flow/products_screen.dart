import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:now_apps_task/bloc/app_bloc.dart';
import 'package:now_apps_task/custom_widgets/custom_elevated_button.dart';
import 'package:now_apps_task/screens/app_flow/cart_screen.dart';
import 'package:now_apps_task/screens/app_flow/home_page.dart';

class ProductsDetailsScreen extends StatelessWidget {
  const ProductsDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider.value(
      value: context.read<AppBloc>()..add(LoadProductsListEvent()),
      child: BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          if (state is CheckOutSuccess) {
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Do you want to checkout?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("NO")),
                      TextButton(
                          onPressed: () {
                            context.read<AppBloc>().add(CheckOutEvent());
                          },
                          child: const Text("YES")),
                    ],
                  );
                });
          },
          icon: const Icon(Icons.exit_to_app),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: BlocBuilder<AppBloc, AppState>(buildWhen: (prev, curr) {
        if (curr is ProductsListLoaded) {
          return true;
        }
        return false;
      }, builder: (context, state) {
        if (state is ProductsListLoaded) {
          return ListView.builder(
              itemCount: state.productList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(
                    state.productList[index].prodImage,
                    width: 100,
                    height: 100,
                    errorBuilder: (context, object, stackTrace) {
                      return const Text("No image found");
                    },
                  ),
                  title: Text(state.productList[index].prodName),
                  subtitle:
                      Text('\u{20B9} ${state.productList[index].prodPrice}'),
                  trailing: SizedBox(
                    width: 80,
                    child: Center(
                      child: ElevatedButton(
                          onPressed: () {
                            if (state.cartCountList[index] == 0) {
                              context.read<AppBloc>().add(AddToCartEvent(
                                  productId: state.productList[index].id,
                                  productCount: 1,
                                  isHome: true));
                            } else {
                              context.read<AppBloc>().add(RemoveFromCartEvent(
                                  productId: state.productList[index].id));
                            }
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(horizontal: 10))),
                          child: Text(
                            state.cartCountList[index] == 0
                                ? "Add to cart"
                                : "Remove from cart",
                            style: const TextStyle(fontSize: 12),
                          )),
                    ),
                  ),
                );
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
