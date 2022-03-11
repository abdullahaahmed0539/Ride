// ignore: file_names
import 'package:flutter/material.dart';
import '../widgets/components/DisputesOnYou.dart';
import '../widgets/components/NavigationMenu.dart';
import '../widgets/components/VotingShortcut.dart';
import '../widgets/components/YourDisputesShortcut.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: const Text(
            'Ride',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: const [
            NavigationMenu(),
            DisputesOnYou(),
            VotingShortcut(),
            YourDisputesShortcut()
          ]),
        ));
  }
}
