// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:frontend/screens/disputes/DisputeTabs.dart';
import 'package:frontend/screens/Profile.dart';
import 'package:provider/provider.dart';
import '../../providers/App.dart';
import '../../screens/booking/Booking.dart';
import '../../widgets/ui/CardButton.dart';
import '../../screens/users/Wallet.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({Key? key}) : super(key: key);

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
              child: Text(
                'WHAT WOULD YOU LIKE TO DO?',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Row(children: [
              // ignore: unrelated_type_equality_checks
              Provider.of<AppProvider>(context).app.getAppMode() == 'rider'
                  ? CardButton(
                      const Color(0xffEABD2A),
                      Icons.commute,
                      'Booking',
                      () => Navigator.pushNamed(context, Booking.routeName))
                  : CardButton( Color.fromARGB(255, 240, 115, 76), Icons.commute,
                      'Find rides', () {}),

              Expanded(
                child: CardButton(
                    const Color(0xff5CCB57),
                    Icons.attach_money,
                    'Earn',
                    () => Navigator.pushNamed(context, DisputeTabs.routeName,
                        arguments: {'initialIndex': 2})),
              ),
              Expanded(
                child: CardButton(
                    const Color(0xff43ABBE),
                    Icons.account_balance_wallet,
                    'Wallet',
                    () => Navigator.pushNamed(context, Wallet.routeName)),
              ),
            ]),
            Row(children: [
              CardButton(
                  const Color(0xff771AF0),
                  Icons.account_circle_sharp,
                  'Profile',
                  () => Navigator.pushNamed(context, Profile.routeName)),
            ]),
          ])),
    );
  }
}
