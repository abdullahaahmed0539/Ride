import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/global/map.dart';
import 'package:frontend/models/rider_ride_request_info.dart';
import 'package:frontend/widgets/components/ConfirmRide.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widgets/components/RiderDetails.dart';

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

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final RiderRideRequestInformation riderRideRequestInformation =
        routeArgs['riderRideRequestInformation'];

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newTripGoogleMapController = controller;
              blackThemeGoogleMap(newTripGoogleMapController);
            },
          ),
          

          Positioned(
             bottom: 10,
                    left: 0,
                    right: 0,
            child: RiderDetails(
              duration: '18',
              riderName: riderRideRequestInformation.riderName!,
              pickup: riderRideRequestInformation.pickupAddress!,
              dropoff: riderRideRequestInformation.dropoffAddress!
            ))
        ],
      ),
    );
  }
}
