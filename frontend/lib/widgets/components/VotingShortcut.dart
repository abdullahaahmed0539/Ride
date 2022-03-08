//Add http calls
// different display when no voting available

import 'package:flutter/material.dart';
import 'package:frontend/widgets/ui/LongButton.dart';

import '../ui/CardItem.dart';

class VotingShortcut extends StatefulWidget {
  const VotingShortcut({Key? key}) : super(key: key);

  @override
  State<VotingShortcut> createState() => _VotingShortcutState();
}

class _VotingShortcutState extends State<VotingShortcut> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: const Color(0xff333439),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 12, left: 12, bottom: 15),
            child: const Text(
              'EARN AND HELP OTHERS WITH YOUR VOTE',
              style: TextStyle(
                color: Color(0xffA0A0A0),
                fontFamily: 'SF-Pro-Rounded-Regular',
                fontSize: 14,
                
              ),
            ),
          ),
          CardItem(
              'Robbery',
              'I was held hostage by the driver for 4 hours. then what should i do ',
              'Read more',
              () {}),
          CardItem(
              'Robbery',
              'I was held hostage by the driver for 4 hours. then what should i do ',
              'Read more',
              () {}),
          CardItem(
              'Robbery',
              'I was held hostage by the driver for 4 hours. then what should i do ',
              'Read more',
              () {}),
          LongButton(handler: () {}, buttonText: 'More', isActive: true)
        ]));
  }
}
