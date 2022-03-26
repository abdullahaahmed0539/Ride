import 'package:flutter/material.dart';

class PersonalInformation extends StatelessWidget {
  static const routeName = '/personal_information';
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Personal information'),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: const SingleChildScrollView(child: null)));
  }
}
