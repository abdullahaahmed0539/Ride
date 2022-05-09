import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/services/user_alert.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../../api calls/bookings.dart';
import '../../models/user.dart';
import '../../providers/app.dart';
import '../../providers/user.dart';
import '../../widgets/ui/rides_item.dart';

class Scheduled extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const Scheduled({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  State<Scheduled> createState() => _ScheduledState();
}

class _ScheduledState extends State<Scheduled> {
  List<dynamic> scheduledRides = [];
  late User user;
  late String appMode;
  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration.zero, fetchScheduledBookingsFromServer);
    super.initState();
  }

  Future fetchScheduledBookingsFromServer() async {
    user = Provider.of<UserProvider>(context, listen: false).user;
    appMode = Provider.of<AppProvider>(context, listen: false).app.getAppMode();
    late Response response;
    if (appMode == 'rider') {
      response =
          await fetchScheduledBookings(user.id, user.phoneNumber, user.token);
    } else if (appMode == 'driver') {
      response = await fetchScheduledBookingsForDriver(
          user.id, user.phoneNumber, user.token);
    }
    fetchBookingsResponseHandler(response);
    setState(() {
      isLoading = false;
    });
  }

  void fetchBookingsResponseHandler(Response response) {
    if (response.statusCode != 404 &&
        response.statusCode != 406 &&
        response.statusCode != 200) {
      snackBar(widget.scaffoldKey, 'Internal Server Error.');
    }

    if (response.statusCode == 406) {
      snackBar(widget.scaffoldKey, 'Missing params.');
    }

    if (response.statusCode == 200) {
      setState(() {
        scheduledRides = json.decode(response.body)['data']['myBookings'];
      });
    }

    if (response.statusCode == 404) {
      setState(() {
        scheduledRides = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: fetchScheduledBookingsFromServer,
      child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: scheduledRides.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        ...scheduledRides.map((booking) {
                          return RidesItem(
                            buttonText: 'Track',
                            date: booking['bookingTime'],
                            pickup: booking['pickup'],
                            dropOff: booking['dropoff'],
                            height: 5,
                            width: 0,
                            handler: () {},
                          );
                        }).toList()
                      ])
                : Center(
                    child: Text(
                      'There are no bookings',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
          )),
    );
  }
}
