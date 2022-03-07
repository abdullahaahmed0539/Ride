import 'package:flutter/material.dart';

class LongButton extends StatelessWidget {
  final VoidCallback handler;
  final String buttonText;
  bool isActive;

  // ignore: prefer_const_constructors_in_immutables
  LongButton({Key? key, required this.handler, required this.buttonText, required this.isActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: ,
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        child: Opacity(
          opacity: isActive? 1.0: 0.2,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: isActive? MaterialStateProperty.all(const Color(0xFF7722F0)): MaterialStateProperty.all(Colors.grey),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
            ),
            onPressed: isActive ? handler : null,
            child: Text(
              buttonText,
              style: const TextStyle(
                  fontSize: 21,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }
}
