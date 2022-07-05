import 'package:flutter/material.dart';
import 'package:now_apps_task/bloc/app_bloc.dart';
import 'package:now_apps_task/custom_widgets/custom_elevated_button.dart';
import 'package:now_apps_task/models/products_model.dart';
import 'package:now_apps_task/models/retailer_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:now_apps_task/screens/app_flow/products_screen.dart';

class RetailerDetailsScreen extends StatelessWidget {
  final RetailerModel retailerModel;

  const RetailerDetailsScreen({Key? key, required this.retailerModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state is CheckInSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProductsDetailsScreen()),
              (route) => false);
        }
      },
      child: _Scaffold(
        retailerModel: retailerModel,
      ),
    ));
  }
}

class _Scaffold extends StatelessWidget {
  final RetailerModel retailerModel;

  const _Scaffold({Key? key, required this.retailerModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.redAccent, width: 2),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(retailerModel.image),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              retailerModel.shopName,
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              retailerModel.ownerName,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${retailerModel.address}, ${retailerModel.city}, ${retailerModel.state}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomElevatedButton(
                onPressed: () {
                  context
                      .read<AppBloc>()
                      .add(CheckInEvent(id: retailerModel.id!));
                },
                text: 'Check In'),
          ],
        ),
      ),
    );
  }
}
