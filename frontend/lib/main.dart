import 'package:flutter/material.dart';
import 'package:frontend/widgets/components/DisputesOnYou.dart';
import 'package:frontend/widgets/components/NavigationMenu.dart';
import 'package:frontend/widgets/components/VotingShortcut.dart';
import 'package:frontend/widgets/components/YourDisputesShortcut.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  void onChangeHandler(value) {
    print(value);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ride',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 134, 64, 232),
      ),
      home: Scaffold(
          backgroundColor: const Color(0xFF202124),
          appBar: AppBar(
            title: const Text(
              'Ride',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'SF-Pro-Rounded-Bold',
                  fontSize: 20),
            ),
            backgroundColor: const Color.fromARGB(255, 134, 64, 232),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              NavigationMenu(),
              const DisputesOnYou(),
              const VotingShortcut(),
              const YourDisputesShortcut()
            ]),
          )),
    );
  }
}
