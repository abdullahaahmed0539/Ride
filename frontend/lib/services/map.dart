import 'package:frontend/global/configuration.dart';
import 'package:frontend/models/DirectionDetailsInfo.dart';
import 'package:frontend/models/Directions.dart';
import 'package:frontend/providers/Location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../api calls/Map.dart';

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
  double total = litresRequired*180*1.25;
  return double.parse(total.toStringAsFixed(2));
}
