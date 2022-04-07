// ignore_for_file: file_names
import 'package:flutter/material.dart';

class BookingDetail extends StatefulWidget {
  static const routeName = '/booking_detail';
  const BookingDetail({Key? key}) : super(key: key);

  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
 final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Booking detail'),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: SingleChildScrollView(
                child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
            ))));
  }
}
