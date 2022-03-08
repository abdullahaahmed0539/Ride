import 'package:flutter/material.dart';
import 'package:frontend/widgets/ui/Message.dart';
import 'package:frontend/widgets/ui/TextualButton.dart';

class CardItem extends StatelessWidget {
  final String heading;
  final String shortDescription;
  final String buttonText;
  final VoidCallback handler;

  const CardItem(
      this.heading, this.shortDescription, this.buttonText, this.handler);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        padding: const EdgeInsets.only(top:10, bottom:2, left:10, right:10),
        width: double.infinity,
        decoration: ShapeDecoration(
          color: const Color(0xff43444B),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Message(heading, Colors.white, 22, 'SF-Pro-Rounded-Medium',
                FontWeight.w700),
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: Message(shortDescription, Colors.white, 18,
                  'SF-Pro-Rounded-Regular', FontWeight.normal),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: TextualButton(handler: handler, buttonText: buttonText))
          ],
        ));
  }
}
