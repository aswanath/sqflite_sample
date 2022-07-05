import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:now_apps_task/bloc/app_bloc.dart';
import 'package:now_apps_task/screens/app_flow/retailer_details.dart';
import 'package:now_apps_task/screens/login_flow/login_screen.dart';
import 'package:now_apps_task/utils/repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: context.read<AppBloc>()..add(RefreshRetailersEvent()),
        child: _Scaffold(),
      ),
    );
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
        onPressed: () async{
         await sharedPreferences.remove('isLoggedIn');
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
        },
        backgroundColor: Colors.redAccent,
        label: Row(
          children: const [Icon(Icons.exit_to_app), Text("Log Out")],
        ),
      ),
      body: BlocBuilder<AppBloc, AppState>(buildWhen: (prev, curr) {
        if (curr is RetailersListRefreshed) {
          return true;
        }
        return false;
      }, builder: (context, state) {
        if (state is RetailersListRefreshed) {
          if (state.list.isEmpty) {
            return const Center(
              child: Text("No retailers found"),
            );
          } else {
            final retailers = state.list;
            return ListView.builder(
                itemCount: retailers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RetailerDetailsScreen(
                                  retailerModel: retailers[index])));
                    },
                    leading: Image.asset(retailers[index].image),
                    title: Text(retailers[index].shopName),
                    subtitle: Text(retailers[index].ownerName),
                    trailing: Text(retailers[index].city),
                  );
                });
          }
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}

class _IconTextButton extends StatelessWidget {
  final String label;
  final IconData iconData;
  final VoidCallback onPressed;

  const _IconTextButton(
      {Key? key,
      required this.iconData,
      required this.label,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        iconData,
        color: Colors.grey,
      ),
      label: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
    );
  }
}
