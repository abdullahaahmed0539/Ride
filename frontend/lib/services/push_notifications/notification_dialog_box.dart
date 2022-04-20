import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/global/global.dart';
import 'package:frontend/models/Driver.dart';
import 'package:frontend/models/rider_ride_request_info.dart';
import 'package:frontend/providers/Driver.dart';
import 'package:frontend/screens/driver/trip_screen.dart';
import 'package:provider/provider.dart';

class NotificationDialogBox extends StatefulWidget {
  RiderRideRequestInformation? riderRideRequestInformation;
  NotificationDialogBox({this.riderRideRequestInformation, Key? key})
      : super(key: key);

  @override
  State<NotificationDialogBox> createState() => _NotificationDialogBoxState();
}

class _NotificationDialogBoxState extends State<NotificationDialogBox> {
  void acceptRideRequest(BuildContext context) {
    Driver driver = Provider.of<DriverProvider>(context, listen: false).driver;
    String rideRequestId = '';
    FirebaseDatabase.instance
        .ref()
        .child('drivers')
        .child(driver.driverId)
        .child('rideRequest')
        .once()
        .then((snap) {
      if (snap.snapshot.value != null) {
        rideRequestId = snap.snapshot.value.toString();
      } else {
        Fluttertoast.showToast(
            msg: 'Request has been cancelled',
            backgroundColor: Theme.of(context).primaryColor);
      }

      if (rideRequestId == widget.riderRideRequestInformation!.rideRequestId){
FirebaseDatabase.instance
        .ref()
        .child('drivers')
        .child(driver.driverId)
        .child('rideRequest')
        .set('accepted');

        //http to backend
        Navigator.of(context).pushNamed(NewTripScreen.routeName, arguments: {'riderRideRequestInformation': widget.riderRideRequestInformation});
      }else{
        Fluttertoast.showToast(msg: 'This ride request got cencelled by the rider', backgroundColor: Theme.of(context).primaryColor);
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
