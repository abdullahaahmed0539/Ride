// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/api%20calls/Trips.dart';
import 'package:frontend/services/error.dart';
import 'package:frontend/widgets/components/BookingDetailBlock.dart';
import 'package:frontend/widgets/components/TripDetails.dart';
import 'package:frontend/widgets/ui/spinner.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';

import '../../providers/App.dart';
import '../../providers/User.dart';

class BookingDetail extends StatefulWidget {
  static const routeName = '/booking_detail';
  const BookingDetail({Key? key}) : super(key: key);

  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final DateFormat formatter1 = DateFormat.yMMMMd();
  final DateFormat formatter2 = DateFormat.M();
  dynamic tripDetails = {};
  bool isLoading = true;

  void fetchTripDetailsFromServer(BuildContext ctx, String bookingId) async {
    String userId = Provider.of<UserProvider>(ctx, listen: false).user.id;
    PhoneNumber phoneNumber =
        Provider.of<UserProvider>(ctx, listen: false).user.phoneNumber;
    String token = Provider.of<UserProvider>(ctx, listen: false).user.token;
    String appMode =
        Provider.of<AppProvider>(ctx, listen: false).app.getAppMode();
    Response response = await fetchTripDetails(
        ctx, userId, bookingId, appMode, phoneNumber, token);

    fetchTripDetailsResponseHandler(response);
  }

  fetchTripDetailsResponseHandler(Response response) {
    if (response.statusCode != 200 && response.statusCode != 401) {
      snackBar(scaffoldKey, 'Internal server error.');
    }

    if (response.statusCode == 401) {
      snackBar(scaffoldKey, 'Forbidden access.');
    }

    if (response.statusCode == 200) {
      setState(() {
        tripDetails = json.decode(response.body)['data']['trip'];
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      dynamic bookingDetails = routeArgs['booking'];
      if (bookingDetails['status'] == 'completed') {
        fetchTripDetailsFromServer(context, bookingDetails['_id']);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    dynamic bookingDetails = routeArgs['booking'];
    if (bookingDetails['status'] == 'cancelled') {
      setState(() {
        isLoading = false;
      });
    }
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Booking details'),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: !isLoading ? Column(children: [
                      BookingDetailBlock(
                          bookingId: bookingDetails['_id'],
                          pickup: bookingDetails['pickup'],
                          dropoff: bookingDetails['dropoff'],
                          status: bookingDetails['status'],
                          date: formatter1.format(
                              DateTime.parse(bookingDetails['bookingTime'])),
                          bottom: 10,
                          top: 20),
                      bookingDetails['status'] != 'cancelled'
                          ? TripDetails(
                              distance: tripDetails['distance'].toString(),
                              duration: formatter2.format(
                              DateTime.parse(tripDetails['duration'])),
                              waitTime:formatter2.format(
                              DateTime.parse( tripDetails['waitTime'])),
                              bottom: 10,
                              top: 7)
                          : Container()
                    ]): Spinner(text: 'Loading', height: 300)))));
  }
}
