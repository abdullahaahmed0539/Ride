import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/api%20calls/Bookings.dart';
import 'package:frontend/global/global.dart';
import 'package:frontend/models/Driver.dart';
import 'package:frontend/models/User.dart';
import 'package:frontend/models/rider_ride_request_info.dart';
import 'package:frontend/providers/Booking.dart';
import 'package:frontend/providers/Driver.dart';
import 'package:frontend/providers/User.dart';
import 'package:frontend/screens/driver/trip_screen.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../services/map.dart';

class NotificationDialogBox extends StatefulWidget {
  RiderRideRequestInformation? riderRideRequestInformation;
  NotificationDialogBox({this.riderRideRequestInformation, Key? key})
      : super(key: key);

  @override
  State<NotificationDialogBox> createState() => _NotificationDialogBoxState();
}

class _NotificationDialogBoxState extends State<NotificationDialogBox> {
  void createBookingResponseHandler(Response response, Driver driver) {
    var error = json.decode(response.body)['error'];
    if (response.statusCode == 201) {
      var booking = json.decode(response.body)['data']['booking'];
      Provider.of<BookingProvider>(context, listen: false).booking.addBooking(
          booking['_id'],
          booking['riderId'],
          booking['driverId'],
          booking['pickup'],
          booking['dropoff'],
          booking['status'],
          widget.riderRideRequestInformation!);
          
      FirebaseDatabase.instance
          .ref()
          .child('drivers')
          .child(driver.driverId)
          .child('rideRequestStatus')
          .set('accepted');
      stopLiveLocationUpdates(context);
      Navigator.of(context).popAndPushNamed(NewTripScreen.routeName,
          arguments: {
            'riderRideRequestInformation': widget.riderRideRequestInformation
          });
    } else if (response.statusCode == 401) {
      Fluttertoast.showToast(
          msg: 'Access denied, You are not allowed',
          backgroundColor: Colors.black);
      Navigator.of(context).pop();
    } else if (response.statusCode == 406 &&
        error['code'].toString() == 'BOOKING_ALREADY_MADE') {
      Fluttertoast.showToast(
          msg: error['message'].toString(), backgroundColor: Colors.black);
      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(
          msg: 'Error while booking. Please try later.',
          backgroundColor: Colors.black);
      Navigator.of(context).pop();
    }
  }

  void acceptRideRequest(BuildContext context) {
    Driver driver = Provider.of<DriverProvider>(context, listen: false).driver;
    User user = Provider.of<UserProvider>(context, listen: false).user;
    String rideRequestId = '';
    FirebaseDatabase.instance
        .ref()
        .child('drivers')
        .child(driver.driverId)
        .child('rideRequestStatus')
        .once()
        .then((snap) async {
      if (snap.snapshot.value != null) {
        rideRequestId = snap.snapshot.value.toString();
      } else {
        Fluttertoast.showToast(
            msg: 'Request has been cancelled',
            backgroundColor: Theme.of(context).primaryColor);
      }

      if (rideRequestId == widget.riderRideRequestInformation!.rideRequestId) {
        Response response = await createBooking(
            widget.riderRideRequestInformation!.riderId!,
            driver.driverId,
            widget.riderRideRequestInformation!.pickupAddress!,
            widget.riderRideRequestInformation!.dropoffAddress!,
            false,
            user.phoneNumber,
            user.token);
        createBookingResponseHandler(response, driver);
      } else {
        Fluttertoast.showToast(
            msg: 'This ride request got cencelled by the rider',
            backgroundColor: Theme.of(context).primaryColor);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.transparent,
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 52, 53, 56)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            'Incoming Ride Request',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 1,
          ),
          const Divider(
            color: Colors.white,
          ),
          const SizedBox(
            height: 10,
          ),
          Column(children: [
            Row(children: [
              const Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 50,
              ),
              Expanded(
                  child: Text(
                widget.riderRideRequestInformation!.pickupAddress!,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.clip,
              ))
            ]),
            Row(children: [
              const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 50,
              ),
              Expanded(
                  child: Text(
                widget.riderRideRequestInformation!.dropoffAddress!,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.clip,
              ))
            ]),
            const Divider(
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {
                      //cancel ride
                      audioPlayer.stop();
                      audioPlayer = AssetsAudioPlayer();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.titleMedium,
                    )),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 64, 201, 68),
                    ),
                    onPressed: () {
                      //accept ride
                      audioPlayer.stop();
                      audioPlayer = AssetsAudioPlayer();

                      acceptRideRequest(context);
                    },
                    child: Text(
                      'Accept',
                      style: Theme.of(context).textTheme.titleMedium,
                    ))
              ],
            )
          ])
        ]),
      ),
    );
  }
}
