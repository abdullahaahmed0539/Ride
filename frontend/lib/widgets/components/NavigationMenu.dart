//Need to add functionality to buttons

import 'package:flutter/material.dart';
import 'package:frontend/widgets/ui/CardButton.dart';

class NavigationMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      color: const Color(0xff333439),
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          padding: const EdgeInsets.all(5),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 2, left: 5, bottom: 15),
              child: const Text(
                'WHAT WOULD YOU LIKE TO DO?',
                style: TextStyle(
                  color: Color(0xffA0A0A0),
                  fontFamily: 'SF-Pro-Rounded-Regular',
                  fontSize: 14,
                ),
              ),
            ),
            Row(children: [
              Expanded(
                child: CardButton(const Color(0xff771AF0),
                    Icons.account_circle_sharp, 'Profile', () {}),
              ),
              Expanded(
                child: CardButton(
                    const Color(0xff5CCB57), Icons.attach_money, 'Earn', () {}),
              ),
              Expanded(
                child: CardButton(const Color(0xff43ABBE),
                    Icons.account_balance_wallet, 'Wallet', () {}),
              ),
            ]),
            Row(children: [
              Expanded(
                child: CardButton(
                    const Color(0xffEABD2A), Icons.commute, 'Book a ride', () {}),
              ),
            ]),
          ])),
    );
  }
}
