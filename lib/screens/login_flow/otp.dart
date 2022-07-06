import 'package:flutter/material.dart';
import 'package:now_apps_task/bloc/app_bloc.dart';
import 'package:now_apps_task/main.dart';
import 'package:now_apps_task/screens/app_flow/home_page.dart';
import 'package:now_apps_task/utils/repository.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<AppBloc, AppState>(
  listener: (context, state) {
    if(state is LogInSuccess){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomeScreen()), (route) => false);
    }
  },
  child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "O T P",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.redAccent,fontSize: 22),
              ),
              const SizedBox(height: 10,),
              OTPTextField(
                length: 4,
                width: double.infinity,
                fieldWidth: 80,
                otpFieldStyle: OtpFieldStyle(focusBorderColor: Colors.redAccent),
                style: const TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {
                  context.read<AppBloc>().add(LogInEvent());
                },
              ),
            ],
          ),
        ),
      ),
),
    );
  }
}
