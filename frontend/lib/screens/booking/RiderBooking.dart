// ignore_for_file: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/services/map.dart';
import 'package:frontend/widgets/ui/LongButton.dart';
import 'package:frontend/widgets/ui/spinner.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/Directions.dart';
import '../../providers/Location.dart';
import '../../widgets/ui/LocationPicker.dart';

class RiderBooking extends StatefulWidget {
  static const routeName = '/booking';
  const RiderBooking({Key? key}) : super(key: key);

  @override
  State<RiderBooking> createState() => _RiderBooking();
}

class _RiderBooking extends State<RiderBooking> {
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
  // var geolocator = Geolocator();
  LocationPermission? _locationPermission;
  double bottomPaddingOfMap = 0;
  bool showLocationPicker = true;

  List<LatLng> polylineCoOrdinatesList = [];
  Set<Polyline> polyLineSet = {};
  Set<Marker> markersSet = {};

  void setShowLocationPicker(val) {
    setState(() {
      showLocationPicker = val;
    });
  }

  void clearPoints() {
    setState(() {
      polylineCoOrdinatesList.clear();
      polyLineSet.clear();
      markersSet.clear();
    });
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
    setState(() {
      polyLineSet.add(polyline);
    });

    var origin = Provider.of<LocationProvider>(context, listen: false)
        .userPickupLocation;
    var destination =
        Provider.of<LocationProvider>(context, listen: false).userDropLocation;
    var originLatLng = LatLng(origin!.lat!, origin.long!);
    var destinationLatLng = LatLng(destination!.lat!, destination.long!);

    adjustCameraForPolyline(originLatLng, destinationLatLng);
    addMarker(destination, destinationLatLng);
  }

  void addMarker(Directions location, LatLng locationLatLng) {
    Marker destinationMarker = Marker(
        markerId: const MarkerId('destinationId'),
        infoWindow:
            InfoWindow(title: location.locationName, snippet: 'Destination'),
        position: locationLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));

    setState(() {
      markersSet.add(destinationMarker);
    });
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
    setState(() {
      camPosition = CameraPosition(target: latLngPosition, zoom: 14);
    });
    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(camPosition!));
    String humanReadableAddress = await searchLocationFromGeographicCoOrdinated(
        userCurrentLocation!, context);
  }

  void checkIfLocationPermissionAllowed() async {
    _locationPermission = await Geolocator.requestPermission();
    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    }
  }

  blackThemeGoogleMap() {
    newGoogleMapController!.setMapStyle('''
                    [
                      {
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "featureType": "administrative.locality",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#263c3f"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#6b9a76"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#38414e"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#212a37"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#9ca5b3"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#1f2835"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#f3d19c"
                          }
                        ]
                      },
                      {
                        "featureType": "transit",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#2f3948"
                          }
                        ]
                      },
                      {
                        "featureType": "transit.station",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#515c6d"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      }
                    ]
                ''');
  }

  @override
  void initState() {
    super.initState();
    checkIfLocationPermissionAllowed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              blackThemeGoogleMap();
              setState(() {
                bottomPaddingOfMap = 250;
              });
              locateUserPosition();
            },
          ),
          showLocationPicker
              ? Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: LocationPicker(
                      addTopolylineCoOrdinatesList:
                          addTopolylineCoOrdinatesList,
                      setShowLocationPicker: setShowLocationPicker))
              : Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: LongButton(
                      handler: () {
                        clearPoints();
                        setState(() {
                          showLocationPicker = true;
                        });
                        newGoogleMapController!.animateCamera(
                            CameraUpdate.newCameraPosition(camPosition!));
                      },
                      buttonText: 'back',
                      isActive: true),
                ),
          camPosition == null
              ? Spinner(text: 'Fetching current location ', height: 0)
              : Container()
        ],
      ),
    );
  }
}
