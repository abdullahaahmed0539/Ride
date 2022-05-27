import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/api%20calls/bookings.dart';
import 'package:frontend/global/global.dart';
import 'package:frontend/models/driver.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/models/rider_ride_request_info.dart';
import 'package:frontend/providers/booking.dart';
import 'package:frontend/providers/driver.dart';
import 'package:frontend/providers/user.dart';
import 'package:frontend/screens/driver/trip_screen.dart';
import 'package:frontend/widgets/ui/spinner.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../services/map.dart';

// ignore: must_be_immutable
class NotificationDialogBox extends StatefulWidget {
  RiderRideRequestInformation? riderRideRequestInformation;
  NotificationDialogBox({this.riderRideRequestInformation, Key? key})
      : super(key: key);

  @override
  State<NotificationDialogBox> createState() => _NotificationDialogBoxState();
}

class _NotificationDialogBoxState extends State<NotificationDialogBox> {
  bool isLoading = false;

  void createBookingResponseHandler(
      Response response, Driver driver, BuildContext context) {
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
        setState(() {
          isLoading = true;
        });
        Response response = await createBooking(
            widget.riderRideRequestInformation!.riderId!,
            driver.driverId,
            widget.riderRideRequestInformation!.pickupAddress!,
            widget.riderRideRequestInformation!.dropoffAddress!,
            user.phoneNumber,
            user.token);
        createBookingResponseHandler(response, driver, context);
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
        child: !isLoading? Column(mainAxisSize: MainAxisSize.min, children: [
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
                      Driver driver =
                          Provider.of<DriverProvider>(context, listen: false)
                              .driver;
                      FirebaseDatabase.instance
                          .ref()
                          .child('allRideRequests')
                          .child(widget
                              .riderRideRequestInformation!.rideRequestId!)
                          .remove()
                          .then((value) {
                        FirebaseDatabase.instance
                            .ref()
                            .child('drivers')
                            .child(driver.driverId)
                            .child('rideRequestStatus')
                            .once()
                            .then((statusVal) {
                          if (statusVal.snapshot.value != 'userCancelled') {
                            FirebaseDatabase.instance
                                .ref()
                                .child('drivers')
                                .child(driver.driverId)
                                .child('rideRequestStatus')
                                .set('driverCancelled')
                                .then((value) => Fluttertoast.showToast(
                                    msg: 'Request rejected',
                                    backgroundColor: Colors.black,
                                    timeInSecForIosWeb: 5,
                                    gravity: ToastGravity.TOP));
                          }
                        });
                      });

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
        ]): 
        
        Container(
          height: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spinner(text: 'Accepting...', height: 0),
            ],
          ),
        ),
      ),
    );
  }
}
