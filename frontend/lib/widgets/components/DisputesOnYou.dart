//Add http calls
// different display when no voting available

import 'package:flutter/material.dart';
import 'package:frontend/widgets/ui/LongButton.dart';

import '../ui/CardItem.dart';

class DisputesOnYou extends StatefulWidget {
  const DisputesOnYou({Key? key}) : super(key: key);

  @override
  State<DisputesOnYou> createState() => _DisputesOnYou();
}

class _DisputesOnYou extends State<DisputesOnYou> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        color: const Color(0xff333439),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 12, left: 12, bottom: 15),
            child:  Text(
              'THERE MIGHT BE SOME DISPUTES ON YOU',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          CardItem(
              'Robbery',
              'I was held hostage by the driver for 4 hours. then what should i do ',
              'Add claim',
              () {}),
          CardItem(
              'Robbery',
              'I was held hostage by the driver for 4 hours. then what should i do ',
              'Add claim',
              () {}),
          
          LongButton(handler: () {}, buttonText: 'More', isActive: true)
        ]));
  }
}
