import 'package:flutter/material.dart';
import 'package:frontend/models/User.dart';
import 'package:frontend/providers/User.dart';
import 'package:frontend/screens/PersonalInformation.dart';
import 'package:frontend/screens/Wallet.dart';
import 'package:frontend/widgets/components/listItemA.dart';
import 'package:provider/provider.dart';
import '../services/string_extension.dart';
import 'Disputes.dart';
import 'Activities.dart';

class Profile extends StatefulWidget {
  static const routeName = '/profile';
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void goToPersonalInformation() {
    Navigator.of(context).pushNamed(PersonalInformation.routeName);
  }

  void goToWallet() {
    Navigator.of(context).pushNamed(Wallet.routeName);
  }

  void goToDisputes() {
    Navigator.of(context).pushNamed(Disputes.routeName);
  }

  void goToActivities() {
    Navigator.of(context).pushNamed(Activities.routeName);
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(
                  '${user.firstName.capitalize()} ${user.lastName.capitalize()}'),
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
                            handler: goToPersonalInformation),
                        ListItem(
                            text: 'Top up wallet with RideCoins',
                            icon: Icons.account_balance_wallet,
                            handler: goToWallet),
                        ListItem(
                            text: 'Your disputes',
                            icon: Icons.report,
                            handler: goToDisputes),
                        ListItem(
                            text: 'Your activities',
                            icon: Icons.history_toggle_off_outlined,
                            handler: goToActivities),
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: Text('Support',
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                        ListItem(
                            text: 'Become a captain',
                            icon: Icons.attach_money_sharp,
                            handler: () {}),
                             ListItem(
                            text: 'Log out',
                            icon: Icons.logout,
                            handler: () {}),
                      ],
                    )))));
  }
}
