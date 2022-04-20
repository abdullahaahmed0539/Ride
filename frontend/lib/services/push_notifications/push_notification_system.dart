import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/global/global.dart';
import 'package:frontend/models/Driver.dart';
import 'package:frontend/models/rider_ride_request_info.dart';
import 'package:frontend/providers/Driver.dart';
import 'package:frontend/widgets/components/notification_dialog_box.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PushNotificationSystem {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future initializeCloudMessaging(BuildContext context) async {
    //foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      readUserRideRequestInfo(remoteMessage!.data['rideRequestId'], context);
    });

    //background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      readUserRideRequestInfo(remoteMessage!.data['rideRequestId'], context);
    });
  }

  readUserRideRequestInfo(String userRideRequestId, BuildContext context) {
    FirebaseDatabase.instance
        .ref()
        .child('allRideRequests')
        .child(userRideRequestId)
        .once()
        .then(
      (snapData) {
        if (snapData.snapshot.value != null) {
          var rideRequestFromDb = snapData.snapshot.value as Map;
          RiderRideRequestInformation riderRideRequestInformation =
              RiderRideRequestInformation(
                rideRequestId: snapData.snapshot.key,
                  dropoffAddress: rideRequestFromDb['dropoffAddress'],
                  dropoffLatLng: LatLng(
                      double.parse(
                          rideRequestFromDb['dropoff']['latitude'].toString()),
                      double.parse(rideRequestFromDb['dropoff']['longitude']
                          .toString())),
                  pickupAddress: rideRequestFromDb['pickupAddress'],
                  pickupLatLng: LatLng(
                      double.parse(
                          rideRequestFromDb['pickup']['latitude'].toString()),
                      double.parse(
                          rideRequestFromDb['pickup']['longitude'].toString())),
                  riderName: rideRequestFromDb['riderName'],
                  riderId: rideRequestFromDb['riderId'],
                  riderPhoneNumber: rideRequestFromDb['riderPhoneNumber']);
          audioPlayer.open(Audio('assets/audio/music_notification.mp3'));
          audioPlayer.play();
          showDialog(
              context: context,
              builder: (BuildContext context) => NotificationDialogBox(
                  riderRideRequestInformation: riderRideRequestInformation));
        } else {
          Fluttertoast.showToast(
              msg: 'This ride request has been cancelled by the rider');
        }
      },
    );
  }

  Future generateAndGetToken(BuildContext context) async {
    String? registrationToken = await messaging.getToken();

    Driver driver = Provider.of<DriverProvider>(context, listen: false).driver;
    FirebaseDatabase.instance
        .ref()
        .child('drivers')
        .child(driver.driverId)
        .child('token')
        .set(registrationToken);

    messaging.subscribeToTopic('allDrivers');
    messaging.subscribeToTopic('allUsers');
  }
}
