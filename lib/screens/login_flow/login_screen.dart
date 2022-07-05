import 'package:flutter/material.dart';
import 'package:now_apps_task/custom_widgets/custom_elevated_button.dart';
import 'package:now_apps_task/custom_widgets/custom_text_field.dart';
import 'package:now_apps_task/screens/login_flow/otp.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                textEditingController: _textEditingController,
                validator: (val) {
                  if (val != null) {
                    if (val.length == 10) {
                      return null;
                    } else {
                      return "Enter correct phone number";
                    }
                  } else {
                    return "Phone number can't be empty";
                  }
                },
                head: 'Phone',
                hintText: '9876543210',
                textInputType: TextInputType.phone,
              ),
              CustomElevatedButton(
                textEditingController: _textEditingController,
                onPressed: () {
                  if (_textEditingController.text.length == 10) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OTPScreen()));
                  }
                },
                text: "Send Otp",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

