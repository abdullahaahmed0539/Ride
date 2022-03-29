import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  String text;

  Spinner({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          margin: const EdgeInsets.only(top: 300),
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        ),
        Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'SF-Pro-Rounded',
                  fontSize: 14),
            ))
      ]),
    );
  }
}
