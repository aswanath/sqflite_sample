import 'package:flutter/material.dart';
import 'package:now_apps_task/main.dart';
import 'package:now_apps_task/screens/app_flow/home_page.dart';
import 'package:now_apps_task/utils/repository.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  sharedPreferences.setBool('isLoggedIn', true);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
