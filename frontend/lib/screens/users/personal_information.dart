import 'package:flutter/material.dart';
import 'package:frontend/screens/users/update_email.dart';
import 'package:frontend/screens/users/update_name.dart';
import 'package:frontend/screens/users/update_phone_number.dart';
import 'package:frontend/widgets/components/list_item_B.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../providers/user.dart';

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
