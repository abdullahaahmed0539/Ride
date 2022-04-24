import 'package:flutter/material.dart';
import 'message.dart';

class CardButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final VoidCallback handler;

//add handler
  const CardButton(this.color, this.icon, this.text, this.handler, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 115,
        margin: const EdgeInsets.all(5),
        child: Ink(
          decoration: ShapeDecoration(
            color: color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            IconButton(
              icon: Icon(icon),
              iconSize: 90,
              color: Colors.white,
              padding: const EdgeInsets.all(2),
              onPressed: handler,
            ),
            Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Message(
                    text, Colors.white, 20, "SF-Pro-Rounded", FontWeight.w600))
          ]),
        ));
  }
}
