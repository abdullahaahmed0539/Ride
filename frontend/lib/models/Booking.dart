import 'package:frontend/models/rider_ride_request_info.dart';

class Booking {
  String? _id, _riderId, _driverId, _pickup, _dropoff, _status;
  RiderRideRequestInformation? _riderRideRequestInformation;

  Booking();

  addBooking(
      String id,
      String riderId,
      String driverId,
      String pickup,
      String dropoff,
      String status,
      RiderRideRequestInformation riderRideRequestInformation) {
    _id = id;
    _riderId = riderId;
    _driverId = driverId;
    _pickup = pickup;
    _dropoff = dropoff;
    _status = status;
    _riderRideRequestInformation = riderRideRequestInformation;
  }

  addBookingAsperMongo(
    String id,
    String riderId,
    String driverId,
    String pickup,
    String dropoff,
    String status,
  ) {
    _id = id;
    _riderId = riderId;
    _driverId = driverId;
    _pickup = pickup;
    _dropoff = dropoff;
    _status = status;
  }

  void setStatus(newStatus) => _status = newStatus;

  String get id => _id!;
  String get pickup => _pickup!;
  String get dropoff => _dropoff!;
  String get status => _status!;
  RiderRideRequestInformation get riderRideRequestInformation =>
      _riderRideRequestInformation!;
}
