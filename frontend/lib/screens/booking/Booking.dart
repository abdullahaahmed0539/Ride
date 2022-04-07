// ignore_for_file: file_names
import 'package:flutter/material.dart';

class Booking extends StatefulWidget {
  static const routeName = '/booking';
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Booking'),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: const SingleChildScrollView(child: Text('Booking screen'))));
  }
}
