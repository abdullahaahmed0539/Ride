import 'package:flutter/material.dart';
import 'package:frontend/widgets/ui/textual_button.dart';

class CardItem extends StatelessWidget {
  final String heading;
  final String shortDescription;
  final String buttonText;
  final double width;
  final double height;
  final VoidCallback handler;

   const CardItem(
      this.heading, this.shortDescription, this.buttonText, this.width, this.height, this.handler, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: width, vertical: height),
        padding: const EdgeInsets.only(top: 10, bottom: 2, left: 10, right: 10),
        width: double.infinity,
        decoration: ShapeDecoration(
          color: const Color(0xff43444B),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              heading,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: Text(
                shortDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Container(
                alignment: Alignment.bottomRight,
                child: TextualButton(handler: handler, buttonText: buttonText))
          ],
        ));
  }
}
