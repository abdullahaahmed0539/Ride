import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:frontend/api%20calls/push_notification.dart';
import 'package:frontend/global/configuration.dart';
import 'package:frontend/global/global.dart';
import 'package:frontend/models/direction_detais_info.dart';
import 'package:frontend/models/directions.dart';
import 'package:frontend/models/driver.dart';
import 'package:frontend/providers/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../api calls/map.dart';
import '../providers/driver.dart';

Future<String> searchLocationFromGeographicCoOrdinated(
    Position position, context) async {
  String apiUrl =
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$map_key";
  String humanReadableAddress = '';
  var response = await recieveRequest(apiUrl);
  if (response != "Error") {
    humanReadableAddress = response['results'][0]['formatted_address'];
    Directions userPickupAddress = Directions(
        locationName: humanReadableAddress,
        lat: position.latitude,
        long: position.longitude);
    Provider.of<LocationProvider>(context, listen: false)
        .updatePickupLocationAddress(userPickupAddress);
  }
  return humanReadableAddress;
}

Future<DirectionDetailsInfo?> obtainDirectionDetails(
    LatLng origin, LatLng destination) async {
  String url =
      'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$map_key';
  var response = await recieveRequest(url);

  if (response == "Error") {
    return null;
  }

  DirectionDetailsInfo directionDetails = DirectionDetailsInfo(
    ePoints: response['routes'][0]['overview_polyline']['points'],
    distanceText: response['routes'][0]['legs'][0]['distance']['text'],
    distanceValue: response['routes'][0]['legs'][0]['distance']['value'],
    durationText: response['routes'][0]['legs'][0]['duration']['text'],
    durationValue: response['routes'][0]['legs'][0]['duration']['value'],
  );
  return directionDetails;
}

double calculateEstimatedFareAmountBasedOnDistance(
    DirectionDetailsInfo directionDetails) {
  double distance = directionDetails.distanceValue! / 1000;
  double litresRequired = distance / 12;
  double total = litresRequired * 180 * 1.25;
  return double.parse(total.toStringAsFixed(2));
}

void stopLiveLocationUpdates(BuildContext context) {
  streamSubscriptionPosition!.pause();
  Driver driver = Provider.of<DriverProvider>(context, listen: false).driver;
  Geofire.removeLocation(driver.driverId);
}

void resumeLiveLocationUpdates(BuildContext context) {
  streamSubscriptionPosition!.resume();
  Driver driver = Provider.of<DriverProvider>(context, listen: false).driver;
  Geofire.setLocation(driver.driverId, driverCurrentLocation!.latitude,
      driverCurrentLocation!.longitude);
}

sendNotificationToDriverNow(String FCMtoken, String riderRideRequestId) async {
  Map<String, String> notificationHeader = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': serverFCMToken
  };

  Map<String, String> notificationBody = {
    "body": "You have a new ride request. Tap to open.",
    "title": "Ride"
  };

  Map<String, String> dataMap = {
    "click_action": "FLUTTER_NOTIFICATION_CLICK",
    "id": "1",
    "status": "done",
    "rideRequestId": riderRideRequestId
  };

  Map officialNotificationFormat = {
    'notification': notificationBody,
    'data': dataMap,
    'priority': 'high',
    'to': FCMtoken
  };

  await sendPushNotification(
      notificationHeader, jsonEncode(officialNotificationFormat));
}
