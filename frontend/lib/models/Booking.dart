// ignore_for_file: file_names
class Booking {
  String _id, _riderId, _driverId, _pickup, _dropoff, _status;
  DateTime _bookingTime;

  Booking(this._id, this._riderId, this._driverId, this._bookingTime,
      this._pickup, this._dropoff, this._status);

  String get id => _id;
  String get pickup => _pickup;
  String get dropoff => _dropoff;
  String get status => _status;
  DateTime get bookingTime => _bookingTime;
}
