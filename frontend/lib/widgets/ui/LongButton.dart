import 'package:flutter/material.dart';

class LongButton extends StatelessWidget {
  final VoidCallback handler;
  final String buttonText;
  final bool isActive;

  // ignore: prefer_const_constructors_in_immutables
  const LongButton({ required this.handler, required this.buttonText, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Opacity(
          opacity: isActive? 1.0: 0.2,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: isActive? MaterialStateProperty.all(Theme.of(context).primaryColor): MaterialStateProperty.all(Colors.grey),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
            ),
            onPressed: isActive ? handler : null,
            child: Text(
              buttonText,
              style: const TextStyle(
                  fontSize: 21,
                  fontFamily: "SF-Pro-Rounded",
                  fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }
}
