import 'package:flutter/material.dart';
import 'UI widgets/LongButton.dart';
import 'UI widgets/TextualButton.dart'

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF202124),
        appBar: AppBar(
          title: const Text('Ride'),
        ),
        body: TextualButton()
      ),
    );
  }
}
