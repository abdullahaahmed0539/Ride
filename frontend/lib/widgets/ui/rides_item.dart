import 'package:flutter/material.dart';
import 'package:frontend/providers/app.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'textual_button.dart';

class RidesItem extends StatelessWidget {
  final String pickup;
  final String dropOff;
  final String date;
  final double width;
  final double height;
  final String buttonText;
  final Function handler;
  final DateFormat formatter = DateFormat.yMMMMd();

  RidesItem({
    Key? key,
    required this.pickup,
    required this.dropOff,
    required this.date,
    required this.width,
    required this.height,
    required this.buttonText,
    required this.handler,
  }) : super(key: key);

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
              formatter.format(DateTime.parse(date)).toString(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Container(
              margin: const EdgeInsets.only(top: 7),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_searching_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      pickup,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.white),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      dropOff,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ),
            Provider.of<AppProvider>(context, listen: false).app.getAppMode() == 'rider'?
            Container(
                alignment: Alignment.bottomRight,
                child: TextualButton(
                    handler: () => handler(), buttonText: buttonText)):Container()
          ],
        ));
  }
}
