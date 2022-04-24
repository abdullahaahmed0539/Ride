import '../models/active_nearby_drivers.dart';

class GeoFireAssistant {
  static List<ActiveNearbyDrivers> activeNearbyDriversList = [];

  static void removeOfflineDriverFromList(String driverId) {
    int index = activeNearbyDriversList
        .indexWhere((element) => element.driverId == driverId);
    if (index != -1) {
      activeNearbyDriversList.removeAt(index);
    }
  }

  static void updateActiveNearbyDriversLocation(ActiveNearbyDrivers driver) {
    int index = activeNearbyDriversList
        .indexWhere((element) => element.driverId == driver.driverId);
    if (index != -1) {
      activeNearbyDriversList[index].locationLatitude = driver.locationLatitude;
      activeNearbyDriversList[index].locationLongitude =
          driver.locationLongitude;
    }
  }
}
