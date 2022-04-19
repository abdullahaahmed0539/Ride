// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/api%20calls/Driver.dart';
import 'package:frontend/models/User.dart';
import 'package:frontend/providers/App.dart';
import 'package:frontend/providers/Driver.dart';
import 'package:frontend/providers/User.dart';
import 'package:frontend/screens/disputes/DisputeTabs.dart';
import 'package:frontend/screens/driver/driver_signup.dart';
import 'package:frontend/screens/users/PersonalInformation.dart';
import 'package:frontend/screens/users/Wallet.dart';
import 'package:frontend/services/user_alert.dart';
import 'package:frontend/widgets/components/listItemA.dart';

import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'Home.dart';
import 'booking/ActivitiesTab.dart';
import 'users/Login.dart';

class Profile extends StatefulWidget {
  static const routeName = '/profile';
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String appMode = 'rider';
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  void onModeSwitch() async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    String appMode =
        Provider.of<AppProvider>(context, listen: false).app.getAppMode();
    Response response =
        await switchModes(user.id, appMode, user.phoneNumber, user.token);
    onModeSwitchHandler(response);
  }

  void onModeSwitchHandler(Response response) {
    if (response.statusCode != 401 &&
        response.statusCode != 404 &&
        response.statusCode != 201) {
      snackBar(scaffoldKey, 'Internal Server Error. Please try later.');
    }

    if (response.statusCode == 401) {
      snackBar(scaffoldKey, 'Permission denied. Unauthorized access.');
    }

    if (response.statusCode == 404) {
      snackBar(scaffoldKey,
          'You are not a driver. Please sign up to become a driver.');
    }

    if (response.statusCode == 201) {
      var isActive =
          json.decode(response.body)['data']['driverDetails']['isActive'];
      if (Provider.of<AppProvider>(context, listen: false).app.getAppMode() ==
              'rider' &&
          isActive) {
        Provider.of<DriverProvider>(context, listen: false)
            .driver
            .storeDriverDetails(response);
        Provider.of<AppProvider>(context, listen: false)
            .app
            .setAppMode('driver');
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Home.routeName, (route) => false);
      } else if (Provider.of<AppProvider>(context, listen: false)
                  .app
                  .getAppMode() ==
              'driver' &&
          !isActive) {
        Provider.of<DriverProvider>(context, listen: false)
            .driver
            .removeDriverDetails();
        Provider.of<AppProvider>(context, listen: false)
            .app
            .setAppMode('rider');
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Home.routeName, (route) => false);
      }
    }
  }

  @override
  void initState() {
    Future.delayed(
        Duration.zero,
        () => setState(() {
              appMode = Provider.of<AppProvider>(context, listen: false)
                  .app
                  .getAppMode();
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(user.getFullName()),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Text('Your account',
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                        ListItem(
                            text: 'Personal information',
                            icon: Icons.account_circle_sharp,
                            handler: () => Navigator.of(context)
                                .pushNamed(PersonalInformation.routeName)),
                        ListItem(
                            text: 'Top up wallet with RideCoins',
                            icon: Icons.account_balance_wallet,
                            handler: () => Navigator.of(context)
                                .pushNamed(Wallet.routeName)),
                        ListItem(
                            text: 'Your disputes',
                            icon: Icons.report,
                            handler: () => Navigator.of(context).pushNamed(
                                DisputeTabs.routeName,
                                arguments: {'initialIndex': 0})),
                        ListItem(
                            text: 'Your activities',
                            icon: Icons.history_toggle_off_outlined,
                            handler: () => Navigator.of(context)
                                .pushNamed(Activities.routeName)),
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: Text('Support',
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                        user.isDriver
                            ? appMode == 'rider'
                                ? ListItem(
                                    text: 'Driver mode',
                                    icon: Icons.commute,
                                    handler: onModeSwitch)
                                : ListItem(
                                    text: 'Rider mode',
                                    icon: Icons.commute,
                                    handler: onModeSwitch)
                            : ListItem(
                                text: 'Become a captain',
                                icon: Icons.attach_money_sharp,
                                handler: () {
                                  Navigator.of(context)
                                      .pushNamed(DriverSignup.routeName);
                                }),
                        ListItem(
                            text: 'Log out',
                            icon: Icons.logout,
                            handler: () {
                              Provider.of<UserProvider>(context, listen: false)
                                  .user
                                  .onLogout(context);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  Login.routeName, (route) => false);
                            }),
                      ],
                    )))));
  }
}
