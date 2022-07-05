import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String head;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final TextEditingController textEditingController;

  const CustomTextField({
    required this.validator,
    this.textInputType,
    required this.head,
    required this.hintText,
    required this.textEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: 350,
      child: TextFormField(
        controller: textEditingController,
        keyboardType: textInputType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        cursorColor: Colors.red,
        decoration: InputDecoration(
            hintStyle:
                TextStyle(fontSize: 14, color: Colors.grey.withOpacity(.5)),
            counterText: '',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            hintText: hintText),
      ),
    );
  }
}
