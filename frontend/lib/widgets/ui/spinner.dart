// ignore_for_file: file_names
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Spinner extends StatelessWidget {
  String text;
  double height;

  Spinner({Key? key, required this.text, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          margin: EdgeInsets.only(top: height),
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
