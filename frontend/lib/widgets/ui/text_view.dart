// ignore_for_file: file_names
import 'package:flutter/material.dart';

import 'message.dart';

class TextView extends StatelessWidget {
  final String text;
  const TextView({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: const Color(0xff333439),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, children: [
        Container(
            padding: const EdgeInsets.all(12),
            child: Message(
                text, Colors.white, 18, "SF-Pro-Rounded", FontWeight.w500))
      ]),
    );
  }
}
