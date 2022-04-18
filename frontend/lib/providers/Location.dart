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

  void clearLocations() {
    if (_userPickupLocation != null) {
      _userPickupLocation = null;
    }
    if (_userDropLocation != null) {
      _userDropLocation = null;
    }
    
   
  }

  Directions? get userPickupLocation => _userPickupLocation;
  Directions? get userDropLocation => _userDropLocation;
}
