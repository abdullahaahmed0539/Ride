import 'package:flutter/material.dart';

import './Message.dart';

class TextView extends StatelessWidget {
  final text;
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
            padding: const EdgeInsets.all(8),
            child: Message(
                text, Colors.white, 18, "SF-Pro-Rounded", FontWeight.w500))
      ]),
    );
  }
}
