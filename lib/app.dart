import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:now_apps_task/bloc/app_bloc.dart';
import 'package:now_apps_task/screens/app_flow/home_page.dart';
import 'package:now_apps_task/screens/app_flow/products_screen.dart';
import 'package:now_apps_task/screens/login_flow/login_screen.dart';
import 'package:now_apps_task/utils/repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<Repository>(
      create: (context) => Repository(),
      child: BlocProvider<AppBloc>(
        create: (context) => AppBloc(repository: context.read<Repository>()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: sharedPreferences.getBool('isLoggedIn') == null
              ? LoginScreen()
              : sharedPreferences.getInt('checkedIn') != null
                  ? const ProductsDetailsScreen()
                  : const HomeScreen(),
        ),
      ),
    );
  }
}
