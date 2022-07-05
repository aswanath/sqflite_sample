import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {Key? key,
         this.textEditingController,
        required this.onPressed,
        required this.text})
      : super(key: key);

  final TextEditingController? textEditingController;
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
      style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
          backgroundColor: MaterialStateProperty.all(Colors.red),
          shape: MaterialStateProperty.all(const StadiumBorder())),
    );
  }
}