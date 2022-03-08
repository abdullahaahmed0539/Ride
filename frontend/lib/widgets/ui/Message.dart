import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final String fontFamily;
  final FontWeight fontWeight;

  const Message(this.text, this.color, this.fontSize, this.fontFamily, this.fontWeight);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            color: color, fontFamily: fontFamily, fontSize: fontSize, fontWeight: fontWeight),
            );
  }
}
