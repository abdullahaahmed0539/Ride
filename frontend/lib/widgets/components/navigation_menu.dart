import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/providers/user.dart';
import 'package:frontend/screens/disputes/dispute_tabs.dart';
import 'package:frontend/screens/profile.dart';
import 'package:frontend/screens/driver/driver_map_for_ride.dart';
import 'package:frontend/services/user_alert.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../../api calls/wallet.dart';
import '../../providers/app.dart';
import '../../screens/booking/rider_booking.dart';
import '../ui/card_button.dart';
import '../../screens/users/wallet.dart';

class NavigationMenu extends StatelessWidget {
  final scaffoldKey;
  const NavigationMenu({this.scaffoldKey, Key? key}) : super(key: key);

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
                      () =>
                          Navigator.pushNamed(context, RiderBooking.routeName))
                  : CardButton(const Color.fromARGB(255, 240, 115, 76),
                      Icons.commute, 'Find rides', () async {
                      User user =
                          Provider.of<UserProvider>(context, listen: false)
                              .user;
                      Response response = await getBalance(
                          user.phoneNumber, user.walletAddress, user.token);
                      if (response.statusCode == 200) {
                        var balance =
                            jsonDecode(response.body)['data']['balance'];
                        if (balance < 200) {
                          Fluttertoast.showToast(
                              msg: 'Insufficient balance. Please top-up.',
                              backgroundColor: Theme.of(context).primaryColor,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3);
                        } else {
                          Navigator.pushNamed(
                              context, DriverMapForRide.routeName);
                        }
                      } else {
                        snackBar(scaffoldKey,
                            'Server Error. Sorry for inconvinience Please try later. ');
                      }
                    }),

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
