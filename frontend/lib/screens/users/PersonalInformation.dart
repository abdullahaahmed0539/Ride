// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:frontend/screens/users/UpdateEmail.dart';
import 'package:frontend/screens/users/UpdateName.dart';
import 'package:frontend/screens/users/UpdatePhoneNumber.dart';
import 'package:frontend/widgets/components/listItemB.dart';
import 'package:provider/provider.dart';

import '../../models/User.dart';
import '../../providers/User.dart';

class PersonalInformation extends StatelessWidget {
  static const routeName = '/personal_information';
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Personal information'),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: SingleChildScrollView(
                child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: ListItem(
                          title: 'Name',
                          data:
                              user.getFullName(),
                          icon: Icons.account_circle_sharp,
                          handler: () => Navigator.of(context).pushNamed(UpdateName.routeName))),
                  Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: ListItem(
                          title: 'Mobile number',
                          data:
                              '${user.phoneNumber.countryCode} ${user.phoneNumber.number}',
                          icon: Icons.call,
                          handler: () => Navigator.of(context).pushNamed(UpdatePhoneNumber.routeName))),
                  Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: ListItem(
                          title: 'Email',
                          data: user.email,
                          icon: Icons.email,
                          handler: () => Navigator.of(context).pushNamed(UpdateEmail.routeName)))
                ],
              ),
            ))));
  }
}
