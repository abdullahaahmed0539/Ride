import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:frontend/api%20calls/Bookings.dart';
import 'package:frontend/global/map.dart';
import 'package:frontend/models/DirectionDetailsInfo.dart';
import 'package:frontend/models/Driver.dart';
import 'package:frontend/models/User.dart';
import 'package:frontend/models/rider_ride_request_info.dart';
import 'package:frontend/providers/Driver.dart';
import 'package:frontend/providers/User.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../global/global.dart';
import '../../models/Booking.dart';
import '../../providers/Booking.dart';
import '../../services/images.dart';
import '../../services/map.dart';
import '../../services/user_alert.dart';
import '../../widgets/components/RiderDetails.dart';
import '../../widgets/components/fare_amount_dialog.dart';

//riderRideRequestInformation
class NewTripScreen extends StatefulWidget {
  static const routeName = 'new_trip_screen';
  const NewTripScreen({Key? key}) : super(key: key);

  @override
  State<NewTripScreen> createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newTripGoogleMapController;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  String? buttonText = 'Arrived';
  Set<Marker> setOfMarkers = Set<Marker>();
  Set<Circle> setOfCircles = Set<Circle>();
  Set<Polyline> setOfPolyline = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  double bottomPaddingOfMap = 0;
  BitmapDescriptor? driverIconMarker;
  var geolocator = Geolocator();
  Position? onlineDriverCurrentPosition;
  String rideRequestStatus = 'accepted';
  String durationFromPickupToDropoff = '';
  bool isRequestDirectionDetails = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool nearby = false;

  void setRideRequestStatus(val) {
    if (mounted) {
      rideRequestStatus = val;
    }
  }

  void createDriverIcon() {
    if (driverIconMarker == null) {
      getBytesFromAsset('assets/images/car.png', 130).then((onValue) {
        driverIconMarker = BitmapDescriptor.fromBytes(onValue);
      });
    }
  }

  void setTripCompleteResponseHandler(Response response) async {
    if (response.statusCode != 201 && response.statusCode != 401) {
      snackBar(scaffoldKey, 'Internal server error');
    }

    if (response.statusCode == 201) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final RiderRideRequestInformation riderRideRequestInformation =
          routeArgs['riderRideRequestInformation'];
      var responseData = json.decode(response.body)['data']['tripDetails'];
      FirebaseDatabase.instance
          .ref()
          .child('allRideRequests')
          .child(riderRideRequestInformation.rideRequestId!)
          .child('total')
          .set(responseData['total']);

      FirebaseDatabase.instance
          .ref()
          .child('allRideRequests')
          .child(riderRideRequestInformation.rideRequestId!)
          .child('status')
          .set('completed');

      Provider.of<BookingProvider>(context, listen: false)
          .booking
          .setStatus('completed');

      streamSubscriptionDriverLivePosition!.cancel();

      showDialog(
        barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => FairCollectionDialog(
                disputeCost: responseData['disputeCost'],
                total: responseData['total'],
                waitTimeCost: responseData['waitTimeCost'],
                milesCost: responseData['milesCost'],
              ));
    }

    if (response.statusCode == 401) {
      snackBar(scaffoldKey, 'This is not your ride');
    }
  }

  void endTripNow() async {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final RiderRideRequestInformation riderRideRequestInformation =
        routeArgs['riderRideRequestInformation'];
    LatLng currentPositionLatlng = LatLng(onlineDriverCurrentPosition!.latitude,
        onlineDriverCurrentPosition!.longitude);

//we will user driver current position because what if the ride ends before reaching drop-off
    var tripDirectionDetails = await obtainDirectionDetails(
        currentPositionLatlng, riderRideRequestInformation.pickupLatLng!);

    Driver driver = Provider.of<DriverProvider>(context, listen: false).driver;
    User user = Provider.of<UserProvider>(context, listen: false).user;
    Booking booking =
        Provider.of<BookingProvider>(context, listen: false).booking;

    Response response = await setComplete(driver.driverId, booking.id,
        tripDirectionDetails!.distanceValue!, user.phoneNumber, user.token);
    setTripCompleteResponseHandler(response);
  }

  void getDriversLocationUpdatesAtRealTime() {
    LatLng oldLatLng = LatLng(0, 0);
    streamSubscriptionDriverLivePosition =
        Geolocator.getPositionStream().listen((Position position) {
      if (mounted) {
        driverCurrentLocation = position;
        onlineDriverCurrentPosition = position;

        LatLng latLngLiveDriverPosition = LatLng(
            onlineDriverCurrentPosition!.latitude,
            onlineDriverCurrentPosition!.longitude);

        Marker driverAnimatedMarker = Marker(
            markerId: const MarkerId('animatedMarker'),
            position: latLngLiveDriverPosition,
            icon: driverIconMarker!,
            infoWindow: const InfoWindow(title: 'Your current location'));

        setState(() {
          CameraPosition cameraPosition =
              CameraPosition(target: latLngLiveDriverPosition, zoom: 16);

          newTripGoogleMapController!
              .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

          setOfMarkers.removeWhere(
              (element) => element.markerId.value == 'animatedMarker');
          setOfMarkers.add(driverAnimatedMarker);
        });
        oldLatLng = latLngLiveDriverPosition;
        updateDurationTimeInRealTime();

        Map driverLatLngMap = {
          'latitude': onlineDriverCurrentPosition!.latitude.toString(),
          'longitude': onlineDriverCurrentPosition!.longitude.toString(),
        };
        final routeArgs =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        final RiderRideRequestInformation riderRideRequestInformation =
            routeArgs['riderRideRequestInformation'];

        //updatinf driver location in real time in firebase
        FirebaseDatabase.instance
            .ref()
            .child('allRideRequests')
            .child(riderRideRequestInformation.rideRequestId!)
            .child('driverLocation')
            .set(driverLatLngMap);
      }
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
    newTripGoogleMapController!
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 65));
  }

  void saveDriverInfoToRideRequest() {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final RiderRideRequestInformation riderRideRequestInformation =
        routeArgs['riderRideRequestInformation'];
    DatabaseReference dbRef = FirebaseDatabase.instance
        .ref()
        .child('allRideRequests')
        .child(riderRideRequestInformation.rideRequestId!);

    Driver driver = Provider.of<DriverProvider>(context, listen: false).driver;
    User user = Provider.of<UserProvider>(context, listen: false).user;

    dbRef.child('status').set('accepted');
    dbRef.child('driverId').set(driver.driverId);
    dbRef.child('driverName').set(user.getFullName());
    dbRef
        .child('driverPhone')
        .set('${user.phoneNumber.countryCode}${user.phoneNumber.number}');
    dbRef.child('carColor').set(driver.color.toString());
    dbRef.child('carModel').set(driver.carModel.toString());
    dbRef.child('registrationNumber').set(driver.registrationNumber.toString());

    Map driverLocationMap = {
      'latitude': driverCurrentLocation!.latitude.toString(),
      'longitude': driverCurrentLocation!.longitude.toString()
    };

    dbRef.child('driverLocation').set(driverLocationMap);
  }

  void addMarker(
      LatLng originlocationLatLng, LatLng destinationlocationLatLng) {
    Marker originMarker = Marker(
        markerId: const MarkerId('pickupId'),
        infoWindow: const InfoWindow(
          title: 'Your location',
        ),
        position: originlocationLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure));

    Marker destinationMarker = Marker(
        markerId: const MarkerId('destinationId'),
        infoWindow: const InfoWindow(title: 'Rider\'s location'),
        position: destinationlocationLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
    if (mounted) {
      setState(() {
        setOfMarkers.add(originMarker);
        setOfMarkers.add(destinationMarker);
      });
    }
  }

  void createPolyLine(
    LatLng pickupLatLng,
    LatLng dropoffLatLng,
  ) {
    Polyline polyline = Polyline(
        polylineId: const PolylineId('polylineId'),
        color: Theme.of(context).primaryColor,
        jointType: JointType.round,
        points: polylineCoordinates,
        width: 4,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true);

    if (mounted) {
      setState(() {
        setOfPolyline.add(polyline);
      });
    }

    adjustCameraForPolyline(pickupLatLng, dropoffLatLng);
    addMarker(pickupLatLng, dropoffLatLng);
  }

  void addTopolylineCoOrdinatesList(
    PointLatLng pointLatLng,
  ) {
    polylineCoordinates
        .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
  }

  Future<void> drawPolylineFromPickupToDropoff(
      LatLng pickupLatLng, LatLng dropoffLatLng) async {
    var directionDetails =
        await obtainDirectionDetails(pickupLatLng, dropoffLatLng);
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolylinePointsList =
        polylinePoints.decodePolyline(directionDetails!.ePoints!);
    polylineCoordinates.clear();
    if (decodedPolylinePointsList.isNotEmpty) {
      decodedPolylinePointsList.forEach((PointLatLng pointLatLng) {
        addTopolylineCoOrdinatesList(pointLatLng);
      });
    }
    setOfPolyline.clear();
    createPolyLine(
      pickupLatLng,
      dropoffLatLng,
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      saveDriverInfoToRideRequest();
      createDriverIcon();
    });
  }

  void updateDurationTimeInRealTime() async {
    if (!isRequestDirectionDetails) {
      isRequestDirectionDetails = true;
      if (onlineDriverCurrentPosition == null) {
        return;
      }
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final RiderRideRequestInformation riderRideRequestInformation =
          routeArgs['riderRideRequestInformation'];

      var pickupLatLng = LatLng(onlineDriverCurrentPosition!.latitude,
          onlineDriverCurrentPosition!.longitude);

      LatLng dropoffLatLng;
      if (rideRequestStatus == 'accepted') {
        //since for driver, drop off is currently rider's location to pick from
        dropoffLatLng = riderRideRequestInformation.pickupLatLng!;
      } else {
        //since for driver, drop off is currently rider's drop off
        dropoffLatLng = riderRideRequestInformation.dropoffLatLng!;
      }
      var directionInfo =
          await obtainDirectionDetails(pickupLatLng, dropoffLatLng);
      if (directionInfo!.distanceValue! <= 350) {
        setState(() {
          nearby = true;
        });
      }
      if (directionInfo != null) {
        setState(() {
          durationFromPickupToDropoff = directionInfo.durationText!;
        });
      }
      isRequestDirectionDetails = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final RiderRideRequestInformation riderRideRequestInformation =
        routeArgs['riderRideRequestInformation'];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        body: Stack(
          children: [
            GoogleMap(
              padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
              mapType: MapType.normal,
              // myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              initialCameraPosition: _kGooglePlex,
              markers: setOfMarkers,
              circles: setOfCircles,
              polylines: setOfPolyline,
              onMapCreated: (GoogleMapController controller) {
                _controllerGoogleMap.complete(controller);
                newTripGoogleMapController = controller;
                blackThemeGoogleMap(newTripGoogleMapController);
                var driverCurrentLatlng = LatLng(driverCurrentLocation!.latitude,
                    driverCurrentLocation!.longitude);
                var userCurrentLatlng = riderRideRequestInformation.pickupLatLng;
                drawPolylineFromPickupToDropoff(
                    driverCurrentLatlng, userCurrentLatlng!);
                getDriversLocationUpdatesAtRealTime();
                setState(() {
                  bottomPaddingOfMap = 250;
                });
              },
            ),
            Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: RiderDetails(
                    duration: durationFromPickupToDropoff,
                    nearby: nearby,
                    endTripNow: endTripNow,
                    riderName: riderRideRequestInformation.riderName!,
                    pickup: riderRideRequestInformation.pickupAddress!,
                    dropoff: riderRideRequestInformation.dropoffAddress!,
                    riderRideRequestInformation: riderRideRequestInformation,
                    scaffoldKey: scaffoldKey,
                    setRideRequestStatus: setRideRequestStatus,
                    rideRequestStatus: rideRequestStatus,
                    drawPolylineFromPickupToDropoff:
                        drawPolylineFromPickupToDropoff))
          ],
        ),
      ),
    );
  }
}
