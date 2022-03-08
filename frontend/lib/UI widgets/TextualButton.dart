import 'package:flutter/material.dart';

class TextualButton extends StatelessWidget {
  final VoidCallback handler;
  final String buttonText;

  const TextualButton({
    required this.handler,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style:  TextButton.styleFrom(
          primary: Theme.of(context).primaryColor,
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontFamily: "SF-Pro-Display-Bold",
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: handler);
  }
}
