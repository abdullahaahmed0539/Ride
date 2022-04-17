import 'dart:convert';

class Driver {
  String _driverId;
  String _userId;
  String _cnic;
  String _carModel;
  double _milage;
  String _color;
  String _registrationNumber;
  List<dynamic> _rating = [];
  bool _isActive;
  bool _isBusy;

  Driver(
      this._driverId,
      this._userId,
      this._cnic,
      this._carModel,
      this._milage,
      this._color,
      this._registrationNumber,
      this._rating,
      this._isActive,
      this._isBusy);

  void storeDriverDetails(var response) {
    var responseData = json.decode(response.body)['data']['driverDetails'];
    _driverId = responseData['_id'];
    _userId = responseData['userId'];
    _cnic = responseData['cnic'];
    _carModel = responseData['carModel'];
    _color = responseData['color'];
    _milage = responseData['milage'].toDouble();
    _registrationNumber = responseData['registrationNumber'];
    _rating = responseData['ratings'];
    _isActive = responseData['isActive'];
    _isBusy = responseData['isBusy'];
  }

  void removeDriverDetails() {
    _driverId = '';
    _userId = '';
    _cnic = '';
    _carModel = '';
    _color = '';
    _milage = 0;
    _registrationNumber = '';
    _rating = [];
    _isActive = false;
    _isBusy = false;
  }

  String get driverId => _driverId;
  String get carModel => _carModel;
}
