import 'package:flutter/material.dart';
import 'package:frontend/models/Directions.dart';

class LocationProvider extends ChangeNotifier {
  Directions? _userPickupLocation;
  Directions? _userDropLocation;

  void updatePickupLocationAddress(Directions userPickupAddress) {
    _userPickupLocation = userPickupAddress;
    notifyListeners();
  }

  void updateDropoffLocationAddress(Directions userDropLocation) {
    _userDropLocation = userDropLocation;
    notifyListeners();
  }

  Directions? get userPickupLocation => _userPickupLocation;
  Directions? get userDropLocation => _userDropLocation;
}
