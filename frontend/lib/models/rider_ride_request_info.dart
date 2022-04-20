import 'package:google_maps_flutter/google_maps_flutter.dart';

class RiderRideRequestInformation {
  LatLng? pickupLatLng;
  LatLng? dropoffLatLng;
  String? pickupAddress;
  String? dropoffAddress;
  String? riderName;
  String? riderPhoneNumber;
  String? rideRequestId;
  String? riderId;
  
  RiderRideRequestInformation(
      {this.dropoffAddress,
      this.dropoffLatLng,
      this.pickupAddress,
      this.pickupLatLng,
      this.riderName,
      this.riderId,
      this.riderPhoneNumber,
      this.rideRequestId});
}
