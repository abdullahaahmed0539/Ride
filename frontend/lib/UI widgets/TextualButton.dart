import 'package:flutter/material.dart';

class TextualButton extends StatelessWidget {
  final VoidCallback handler;
  final String buttonText;

  const TextualButton({
    Key? key,
    required this.handler,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          primary: Theme.of(context).primaryColor,
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontFamily: "SF-Pro-Display-Bold",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: handler);
  }
}
