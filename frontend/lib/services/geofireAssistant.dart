import 'dart:ffi';

import '../models/ActiveNearbyDrivers.dart';

class GeoFireAssistant {
  static List<ActiveNearbyDrivers> activeNearbyDriversList = [];

  static void removeOfflineDriverFromList(String driverId) {
    int index = activeNearbyDriversList
        .indexWhere((element) => element.driverId == driverId);
    activeNearbyDriversList.removeAt(index);
  }

  static void updateActiveNearbyDriversLocation(ActiveNearbyDrivers driver) {
    int index = activeNearbyDriversList
        .indexWhere((element) => element.driverId == driver.driverId);
    activeNearbyDriversList[index].locationLatitude = driver.locationLatitude;
    activeNearbyDriversList[index].locationLongitude = driver.locationLongitude;
  }
}
