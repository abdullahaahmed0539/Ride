import 'package:flutter/material.dart';
import 'package:frontend/UI%20widgets/DarkTextField.dart';
import 'UI widgets/LongButton.dart';
import 'UI widgets/TextualButton.dart';

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
        theme: ThemeData(
          primaryColor: Color(0xFF7722F0),
        ),
        home: Scaffold(
          backgroundColor: Color(0xFF202124),
          appBar: AppBar(
            title: const Text('Ride'),
          ),
          body: Column(
            children: [
              DarkTextField(
                label: 'Name',
                placeholder: 'Enter your name here',
                onChangeHandler: (value) {
                  onChangeHandler(value);
                },
              ),
            ],
          ),
        ));
  }
}
