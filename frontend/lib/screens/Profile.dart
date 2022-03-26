import 'package:flutter/material.dart';
import 'package:frontend/providers/User.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  static const routeName = '/profile';
  const Profile({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text( '${user.firstName} ${user.lastName}'),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: const SingleChildScrollView(child: null)));
  }
}
