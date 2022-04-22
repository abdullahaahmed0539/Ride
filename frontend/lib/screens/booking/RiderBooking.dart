// ignore_for_file: file_names
import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:frontend/api%20calls/Driver.dart';
import 'package:frontend/global/global.dart';
import 'package:frontend/models/ActiveNearbyDrivers.dart';
import 'package:frontend/providers/User.dart';
import 'package:frontend/screens/booking/SelectNearestActiveDrivers.dart';
import 'package:frontend/services/geofireAssistant.dart';
import 'package:frontend/services/images.dart';
import 'package:frontend/services/map.dart';
import 'package:frontend/widgets/components/ConfirmRide.dart';
import 'package:frontend/widgets/ui/spinner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../global/map.dart';
import '../../models/Directions.dart';
import '../../models/User.dart';
import '../../providers/Location.dart';
import '../../services/user_alert.dart';
import '../../widgets/components/driver_detail_widget.dart';
import '../../widgets/components/waiting_for_driver.dart';
import '../../widgets/ui/LocationPicker.dart';

class RiderBooking extends StatefulWidget {
  static const routeName = '/booking';
  const RiderBooking({Key? key}) : super(key: key);

  @override
  State<RiderBooking> createState() => _RiderBooking();
}

class _RiderBooking extends State<RiderBooking> {
  DatabaseReference? referenceRideRequest;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;
  CameraPosition? camPosition;

  //default coordinates if unable to find current location
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Position? userCurrentLocation;
  var geolocator = Geolocator();
  LocationPermission? _locationPermission;
  double bottomPaddingOfMap = 0;
  bool showLocationPicker = true,
      activeNearbyDriversKeysLoaded = false,
      displayConfirmWidget = true,
      displayDriverDetailsWidget = false,
      requestPostionInfo = true;
  BitmapDescriptor? activeNearByIcon;
  LatLng? driverRealTimePosition;
  List<LatLng> polylineCoOrdinatesList = [];
  List<ActiveNearbyDrivers> onlineNearByDriversList = [];
  Set<Polyline> polyLineSet = {};
  Set<Marker> markersSet = {};
  StreamSubscription<DatabaseEvent>? tripRideRequestInfoStreamSubscription;
  String carColor = '',
      carModel = '',
      registrationNumber = '',
      driverName = '',
      driverPhoneNumber = '',
      riderRideRequestStatus = '',
      driverRideStatus = 'Driver is on the way.';

  void setShowLocationPicker(val) {
    if (mounted) {
      setState(() {
        showLocationPicker = val;
      });
    }
  }

  void clearPoints() {
    if (mounted) {
      setState(() {
        polylineCoOrdinatesList.clear();
        polyLineSet.clear();
        markersSet.removeWhere(
            (element) => element.markerId == const MarkerId('pickupId'));
        markersSet.removeWhere(
            (element) => element.markerId == const MarkerId('destinationId'));
      });
    }
  }

  void addTopolylineCoOrdinatesList(val) {
    polylineCoOrdinatesList.add(LatLng(val.latitude, val.longitude));
    createPolyLine();
  }

  void createPolyLine() {
    Polyline polyline = Polyline(
        polylineId: const PolylineId('polylineId'),
        color: Theme.of(context).primaryColor,
        jointType: JointType.round,
        points: polylineCoOrdinatesList,
        width: 4,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true);

    if (mounted) {
      setState(() {
        polyLineSet.add(polyline);
      });
    }

    var origin = Provider.of<LocationProvider>(context, listen: false)
        .userPickupLocation;
    var destination =
        Provider.of<LocationProvider>(context, listen: false).userDropLocation;
    var originLatLng = LatLng(origin!.lat!, origin.long!);
    var destinationLatLng = LatLng(destination!.lat!, destination.long!);

    adjustCameraForPolyline(originLatLng, destinationLatLng);

    addMarker(origin, originLatLng, destination, destinationLatLng);
  }

  void addMarker(Directions originlocation, LatLng originlocationLatLng,
      Directions destinationlocation, LatLng destinationlocationLatLng) {
    Marker originMarker = Marker(
        markerId: const MarkerId('pickupId'),
        infoWindow:
            InfoWindow(title: originlocation.locationName, snippet: 'Pickup'),
        position: originlocationLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure));

    Marker destinationMarker = Marker(
        markerId: const MarkerId('destinationId'),
        infoWindow: InfoWindow(
            title: destinationlocation.locationName, snippet: 'Destination'),
        position: destinationlocationLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
    if (mounted) {
      setState(() {
        markersSet.add(originMarker);
        markersSet.add(destinationMarker);
      });
    }
  }

  void adjustCameraForPolyline(LatLng originLatLng, LatLng destinationLatLng) {
    LatLngBounds latLngBounds;
    if (originLatLng.latitude > destinationLatLng.latitude &&
        originLatLng.longitude > destinationLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: destinationLatLng, northeast: originLatLng);
    } else if (originLatLng.longitude > destinationLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(originLatLng.latitude, destinationLatLng.longitude),
          northeast:
              LatLng(destinationLatLng.latitude, originLatLng.longitude));
    } else if (originLatLng.latitude > destinationLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(destinationLatLng.latitude, originLatLng.longitude),
          northeast:
              LatLng(originLatLng.latitude, destinationLatLng.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: originLatLng, northeast: destinationLatLng);
    }
    newGoogleMapController!
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 65));
  }

  void locateUserPosition() async {
    userCurrentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    LatLng latLngPosition =
        LatLng(userCurrentLocation!.latitude, userCurrentLocation!.longitude);
    if (mounted) {
      setState(() {
        camPosition = CameraPosition(target: latLngPosition, zoom: 14);
      });
    }
    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(camPosition!));
    String humanReadableAddress = await searchLocationFromGeographicCoOrdinated(
        userCurrentLocation!, context);
    initializeGeofireListener();
  }

  void checkIfLocationPermissionAllowed() async {
    _locationPermission = await Geolocator.requestPermission();
    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    }
  }

  void initializeGeofireListener() {
    Geofire.initialize('activeDrivers');
    if (mounted) {
      Geofire.queryAtLocation(
              userCurrentLocation!.latitude, userCurrentLocation!.longitude, 5)!
          .listen((map) {
        if (map != null) {
          var callBack = map['callBack'];

          switch (callBack) {
            case Geofire.onKeyEntered:

              //When driver is online
              if (Provider.of<UserProvider>(context, listen: false).user.id !=
                  map['key']) {
                ActiveNearbyDrivers activeNearbyDriver = ActiveNearbyDrivers(
                  driverId: map['key'],
                  locationLatitude: map['latitude'],
                  locationLongitude: map['longitude'],
                );
                GeoFireAssistant.activeNearbyDriversList
                    .add(activeNearbyDriver);
                if (activeNearbyDriversKeysLoaded) {
                  displayActiveDriversOnMap();
                }
              }
              break;

            case Geofire.onKeyExited:

              //When driver is after they were online offline
              GeoFireAssistant.removeOfflineDriverFromList(map['key']);
              displayActiveDriversOnMap();
              break;

            case Geofire.onKeyMoved:
              // When driver moves

              ActiveNearbyDrivers activeNearbyDriver = ActiveNearbyDrivers(
                driverId: map['key'],
                locationLatitude: map['latitude'],
                locationLongitude: map['longitude'],
              );
              GeoFireAssistant.updateActiveNearbyDriversLocation(
                  activeNearbyDriver);
              displayActiveDriversOnMap();
              break;

            case Geofire.onGeoQueryReady:

              // All Intial Data is loaded on rider's map
              activeNearbyDriversKeysLoaded = true;
              displayActiveDriversOnMap();
              break;
          }
        }
      });
    }
  }

  void createActiveNearbyDriverIcon() {
    getBytesFromAsset('assets/images/car.png', 130).then((onValue) {
      activeNearByIcon = BitmapDescriptor.fromBytes(onValue);
    });
  }

  void displayActiveDriversOnMap() {
    if (mounted) {
      setState(() {
        markersSet.removeWhere((element) =>
            (element.markerId.value != 'pickupId' &&
                element.markerId.value != 'destinationId'));

        Set<Marker> driversMarkerSet = markersSet;
        for (ActiveNearbyDrivers eachDriver
            in GeoFireAssistant.activeNearbyDriversList) {
          LatLng eachDriverActiveLocation = LatLng(
              eachDriver.locationLatitude!, eachDriver.locationLongitude!);

          Marker marker = Marker(
              markerId: MarkerId(eachDriver.driverId!),
              position: eachDriverActiveLocation,
              icon: activeNearByIcon!,
              rotation: 360);

          driversMarkerSet.add(marker);
        }
        setState(() {
          markersSet = driversMarkerSet;
        });
      });
    }
  }

  void removeMarkers() {
    clearPoints();
    if (mounted) {
      setState(() {
        showLocationPicker = true;
      });
    }
    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(camPosition!));
  }

  @override
  void initState() {
    super.initState();
    checkIfLocationPermissionAllowed();
    createActiveNearbyDriverIcon();
  }

  void getDriversLocationUpdatesAtRealTime() {
    if (mounted) {
      Marker driverAnimatedMarker = Marker(
          markerId: const MarkerId('animatedMarker'),
          position: driverRealTimePosition!,
          icon: activeNearByIcon!,
          infoWindow: const InfoWindow(title: 'Your current location'));

      setState(() {
        CameraPosition cameraPosition =
            CameraPosition(target: driverRealTimePosition!, zoom: 16);

        newGoogleMapController!
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

        markersSet.removeWhere(
            (element) => element.markerId.value == 'animatedMarker');
        markersSet.add(driverAnimatedMarker);
      });
    }
  }

  updateArrivalTimeToRidePickupLocation(driverCurrentPositionLatlng) async {
    if (requestPostionInfo) {
      requestPostionInfo = false;
      LatLng riderPickUpPosition =
          LatLng(userCurrentLocation!.latitude, userCurrentLocation!.longitude);
      var directionDetailsInfo = await obtainDirectionDetails(
          driverCurrentPositionLatlng, riderPickUpPosition);
      if (directionDetailsInfo == null) {
        return;
      }
      setState(() {
        driverRideStatus =
            'Driver is coming in ${directionDetailsInfo.durationText!}';
      });
      setState(() {
        driverRealTimePosition = driverCurrentPositionLatlng;
      });
      getDriversLocationUpdatesAtRealTime();
      requestPostionInfo = true;
    }
  }

  updateReachingTimeToRidePickupLocation(driverCurrentPositionLatlng) async {
    if (requestPostionInfo) {
      requestPostionInfo = false;
      var dropoffLocation =
          Provider.of<LocationProvider>(context, listen: false)
              .userDropLocation;
      LatLng riderdropoffPosition =
          LatLng(dropoffLocation!.lat!, dropoffLocation!.long!);
      var directionDetailsInfo = await obtainDirectionDetails(
          driverCurrentPositionLatlng, riderdropoffPosition);
      if (directionDetailsInfo == null) {
        return;
      }
      setState(() {
        driverRideStatus =
            'Reaching destination in ${directionDetailsInfo.durationText!}';
      });
      setState(() {
        driverRealTimePosition = driverCurrentPositionLatlng;
      });
      getDriversLocationUpdatesAtRealTime();
      requestPostionInfo = true;
    }
  }

  void saveRideRequestInformation() {
    referenceRideRequest =
        FirebaseDatabase.instance.ref().child('allRideRequests').push();

    var pickupLocation = Provider.of<LocationProvider>(context, listen: false)
        .userPickupLocation!;
    var droppoffLocation =
        Provider.of<LocationProvider>(context, listen: false).userDropLocation!;

    Map pickupLocationMap = {
      "latitude": pickupLocation.lat,
      "longitude": pickupLocation.long,
    };

    Map droppoffLocationMap = {
      "latitude": droppoffLocation.lat,
      "longitude": droppoffLocation.long,
    };

    User user = Provider.of<UserProvider>(context, listen: false).user;
    Map userInfoMap = {
      'pickup': pickupLocationMap,
      'dropoff': droppoffLocationMap,
      'time': DateTime.now().toString(),
      'riderId': user.id,
      'riderName': user.getFullName(),
      'riderPhoneNumber':
          '${user.phoneNumber.countryCode}${user.phoneNumber.number}',
      'pickupAddress': pickupLocation.locationName,
      'dropoffAddress': droppoffLocation.locationName,
      'driverId': 'waiting'
    };

    referenceRideRequest!.set(userInfoMap);
    tripRideRequestInfoStreamSubscription =
        referenceRideRequest!.onValue.listen((eventSnap) {
      if (eventSnap.snapshot.value == null) {
        return;
      }
      if ((eventSnap.snapshot.value as Map)['carModel'] != null) {
        setState(() {
          carModel = (eventSnap.snapshot.value as Map)['carModel'].toString();
        });
      }
      if ((eventSnap.snapshot.value as Map)['registrationNumber'] != null) {
        setState(() {
          registrationNumber =
              (eventSnap.snapshot.value as Map)['registrationNumber']
                  .toString();
        });
      }
      if ((eventSnap.snapshot.value as Map)['carColor'] != null) {
        setState(() {
          carColor = (eventSnap.snapshot.value as Map)['carColor'].toString();
        });
      }
      if ((eventSnap.snapshot.value as Map)['driverName'] != null) {
        setState(() {
          driverName =
              (eventSnap.snapshot.value as Map)['driverName'].toString();
        });
      }
      if ((eventSnap.snapshot.value as Map)['driverPhoneNumber'] != null) {
        setState(() {
          driverPhoneNumber =
              (eventSnap.snapshot.value as Map)['driverPhoneNumber'].toString();
        });
      }

      if ((eventSnap.snapshot.value as Map)['status'] != null) {
        riderRideRequestStatus = (eventSnap.snapshot.value as Map)['status'];
      }

      if ((eventSnap.snapshot.value as Map)['driverLocation'] != null) {
        double driverCurrentPositionLat = double.parse(
            (eventSnap.snapshot.value as Map)['driverLocation']['latitude']
                .toString());
        double driverCurrentPositionLng = double.parse(
            (eventSnap.snapshot.value as Map)['driverLocation']['longitude']
                .toString());

        LatLng driverCurrentPositionLatlng =
            LatLng(driverCurrentPositionLat, driverCurrentPositionLng);

        if (riderRideRequestStatus == 'accepted') {
          updateArrivalTimeToRidePickupLocation(driverCurrentPositionLatlng);
        }
        if (riderRideRequestStatus == 'arrived') {
          setState(() {
            driverRideStatus = 'Driver has arrived';
          });
        }
        if (riderRideRequestStatus == 'inprogress') {
          updateReachingTimeToRidePickupLocation(driverCurrentPositionLatlng);
        }
      }
    });
    onlineNearByDriversList = GeoFireAssistant.activeNearbyDriversList;
    searchNearestOnlineDrivers();
  }

  void searchNearestOnlineDrivers() async {
    if (onlineNearByDriversList.isEmpty) {
      referenceRideRequest!.remove();
      Fluttertoast.showToast(
          backgroundColor: Theme.of(context).primaryColor,
          msg: 'No online drivers nearby');
      removeMarkers();
      return;
    }

    await retrieveOnlineDriversInfo(onlineNearByDriversList);
  }

  showWaitingResponseUI() {
    setState(() {
      displayConfirmWidget = false;
    });
  }

  showUIForAssignDriver() {
    setState(() {
      displayDriverDetailsWidget = true;
    });
  }

  retrieveOnlineDriversInfo(
      List<ActiveNearbyDrivers> onlineNearestDriversList) async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    for (int i = 0; i < onlineNearestDriversList.length; i++) {
      Response response = await fetchDriverDetails(
          onlineNearestDriversList[i].driverId.toString(),
          user.phoneNumber,
          user.token);
      onFetchDriverDetailsHandler(response);
    }
    var response = await Navigator.of(context).pushNamed(
        SelectNearestActiveDrivers.routeName,
        arguments: {'referenceRideRequest': referenceRideRequest});
    if (response.toString() == 'driverChosen') {
      FirebaseDatabase.instance
          .ref()
          .child('drivers')
          .child(chosenDriverId!)
          .once()
          .then((snap) {
        if (snap.snapshot.value != null) {
          //assign ride request id to driver in firebase db.
          FirebaseDatabase.instance
              .ref()
              .child('drivers')
              .child(chosenDriverId!)
              .child('rideRequestStatus')
              .set(referenceRideRequest!.key);

          FirebaseDatabase.instance
              .ref()
              .child('drivers')
              .child(chosenDriverId!)
              .child('token')
              .once()
              .then((token) {
            if (token.snapshot.value != null) {
              String deviceTokenbyFCM = token.snapshot.value.toString();

              sendNotificationToDriverNow(
                  deviceTokenbyFCM, referenceRideRequest!.key!.toString());
              Fluttertoast.showToast(
                  msg: 'Request sent to the driver',
                  backgroundColor: Theme.of(context).primaryColor,
                  timeInSecForIosWeb: 5,
                  gravity: ToastGravity.TOP);
            } else {
              Fluttertoast.showToast(
                  msg: 'Please choose another driver',
                  backgroundColor: Theme.of(context).primaryColor,
                  timeInSecForIosWeb: 5,
                  gravity: ToastGravity.TOP);
              return;
            }
          });

          showWaitingResponseUI();

          FirebaseDatabase.instance
              .ref()
              .child('drivers')
              .child(chosenDriverId!)
              .child('rideRequestStatus')
              .onValue
              .listen((eventSnapshot) {
            if (eventSnapshot.snapshot.value == 'idle') {
              Fluttertoast.showToast(
                  msg:
                      'Driver has cancelled your request. Choose another driver.',
                  backgroundColor: Theme.of(context).primaryColor,
                  timeInSecForIosWeb: 5,
                  gravity: ToastGravity.TOP);

              setState(() {
                displayConfirmWidget = true;
              });
            }
            if (eventSnapshot.snapshot.value == 'accepted') {
              showUIForAssignDriver();
            }
          });
        } else {
          Fluttertoast.showToast(
              msg: 'This driver is not available. Try another.');
        }
      });
    }
  }

  onFetchDriverDetailsHandler(Response response) {
    if (response.statusCode != 200 && response.statusCode != 401) {
      snackBar(scaffoldKey, 'Internal server error.');
    }

    if (response.statusCode == 401) {
      snackBar(scaffoldKey, 'Forbidden access.');
    }

    if (response.statusCode == 200) {
      var driverdata = json.decode(response.body)['data']['driver'];
      int index = driversList
          .indexWhere((element) => element['_id'] == driverdata['_id']);
      if (index == -1) {
        driversList.add(driverdata);
      }
    }
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
                  'Trips details will be lost if you go back.',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<LocationProvider>(context, listen: false)
                          .clearLocations();
                      driversList.clear();
                      onlineNearByDriversList.clear();
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
        key: scaffoldKey,
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              initialCameraPosition: _kGooglePlex,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              polylines: polyLineSet,
              markers: markersSet,
              padding: EdgeInsets.only(bottom: bottomPaddingOfMap, top: 20),
              onMapCreated: (GoogleMapController controller) {
                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller;
                blackThemeGoogleMap(newGoogleMapController);

                if (mounted && displayConfirmWidget) {
                  setState(() {
                    bottomPaddingOfMap = 250;
                  });
                }
                locateUserPosition();
              },
            ),
            !displayDriverDetailsWidget
                ? displayConfirmWidget
                    ? showLocationPicker
                        ? Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: LocationPicker(
                              addTopolylineCoOrdinatesList:
                                  addTopolylineCoOrdinatesList,
                              setShowLocationPicker: setShowLocationPicker,
                            ))
                        : Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: ConfirmRide(
                              searchDrivers: saveRideRequestInformation,
                              editTripDetails: removeMarkers,
                            ),
                          )
                    : const Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: WaitingForDriverUI())
                : Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: DriverDetailWidget(
                        carColor: carColor,
                        registrationNumber: registrationNumber,
                        carModel: carModel,
                        driverName: driverName,
                        driverRideStatus: driverRideStatus,
                        driverPhoneNumber: driverPhoneNumber)),
            camPosition == null
                ? Spinner(text: 'Fetching current location ', height: 0)
                : Container()
          ],
        ),
      ),
    );
  }
}
