import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:frontend/providers/driver.dart';
import 'package:frontend/services/push_notifications/push_notification_system.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../../global/global.dart';
import '../../global/map.dart';
import '../../models/driver.dart';
import '../../widgets/components/waiting_for_riders.dart';
import '../../widgets/ui/spinner.dart';

class DriverMapForRide extends StatefulWidget {
  static const routeName = '/driver_map_screen';
  const DriverMapForRide({Key? key}) : super(key: key);

  @override
  State<DriverMapForRide> createState() => _DriverMapForRideState();
}

class _DriverMapForRideState extends State<DriverMapForRide> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  double bottomPaddingOfMap = 0;
  Driver? driver;
  CameraPosition? camPosition;
  LocationPermission? _locationPermission;
  var geolocator = Geolocator();

  void setDriver() {
    setState(() {
      driver = Provider.of<DriverProvider>(context, listen: false).driver;
    });
  }

  void locateUserPosition() async {
    driverCurrentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    LatLng latLngPosition = LatLng(
        driverCurrentLocation!.latitude, driverCurrentLocation!.longitude);
    setState(() {
      camPosition = CameraPosition(target: latLngPosition, zoom: 14);
    });
    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(camPosition!));
  }

  void checkIfLocationPermissionAllowed() async {
    _locationPermission = await Geolocator.requestPermission();
    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    }
  }

  void driverIsOnlineNow() async {
    Geofire.initialize('activeDrivers');

    Position driverCurrentLocationTemp = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    Geofire.setLocation(driver!.driverId, driverCurrentLocationTemp.latitude,
        driverCurrentLocationTemp.longitude);
  }

  void driverIsOffline() {
    Geofire.removeLocation(driver!.driverId);
  }

  void readCurrentDriverInfo(context) {
    PushNotificationSystem pushNotificationSystem = PushNotificationSystem();
    pushNotificationSystem.initializeCloudMessaging(context);
    pushNotificationSystem.generateAndGetToken(context);
  }

  void updateDriversLocationAtRealTime() {
    streamSubscriptionPosition =
        Geolocator.getPositionStream().listen((Position position) {
      if (mounted) {
        driverCurrentLocation = position;
        Geofire.setLocation(driver!.driverId, driverCurrentLocation!.latitude,
            driverCurrentLocation!.longitude);
        LatLng latLng = LatLng(
            driverCurrentLocation!.latitude, driverCurrentLocation!.longitude);
        newGoogleMapController!.animateCamera(CameraUpdate.newLatLng(latLng));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setDriver();
    checkIfLocationPermissionAllowed();
    driverIsOnlineNow();
    updateDriversLocationAtRealTime();
    readCurrentDriverInfo(context);
  }

  @override
  void dispose() {
    driverIsOffline();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return (await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Are you sure?',
                    style: TextStyle(color: Colors.black)),
                content: Text(
                  'Stay on this screen to find rides. Do you want to continue to go back? \n(You can still recieve ride requests if you minimize the app from this screen)',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      FirebaseDatabase.instance
                          .ref()
                          .child('drivers')
                          .child(driver!.driverId)
                          .child('token')
                          .remove();
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ),
            )) ??
            false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).backgroundColor,
          body: Stack(children: [
            GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              padding: EdgeInsets.only(bottom: bottomPaddingOfMap, top: 20),
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller;
                blackThemeGoogleMap(newGoogleMapController);
                setState(() {
                  bottomPaddingOfMap = 60;
                });
                locateUserPosition();
              },
            ),
            const Positioned(
                bottom: 10, right: 0, left: 0, child: WaitingForRidersUI()),
            camPosition == null
                ? Spinner(text: 'Fetching current location ', height: 0)
                : Container()
          ])),
    );
  }
}
