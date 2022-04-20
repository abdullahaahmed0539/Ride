import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:frontend/api%20calls/Map.dart';
import 'package:frontend/global/configuration.dart';
import 'package:frontend/models/PredictedPlaces.dart';
import 'package:frontend/providers/Location.dart';
import 'package:frontend/providers/User.dart';
import 'package:frontend/services/map.dart';
import 'package:frontend/widgets/ui/LongButton.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../global/global.dart';
import '../../models/Directions.dart';
import '../components/PlacePredictionDropdown.dart';

class LocationPicker extends StatefulWidget {
  final Function addTopolylineCoOrdinatesList;
  final Function setShowLocationPicker;
  const LocationPicker({
    required this.setShowLocationPicker,
    required this.addTopolylineCoOrdinatesList,
    Key? key,
  }) : super(key: key);

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  List<PredictedPlaces> predictionsList = [];
  bool selected = false;
  Directions? userDropLocation;
  TextEditingController pickupController = TextEditingController();
  TextEditingController dropoffController = TextEditingController();

  void setSelected(val) {
    if (mounted) {
      setState(() {
        selected = val;
      });
    }
  }

  void setDropOffLocation(val) {
    if (mounted) {
      setState(() {
        userDropLocation = val;
      });
    }

    dropoffController.text = userDropLocation!.locationName.toString();
    dropoffController.selection = TextSelection.fromPosition(
        TextPosition(offset: dropoffController.text.length));
  }

  void findPlaceAutoComplete(String inputText) async {
    if (inputText.length > 2) {
      String countryISO = Provider.of<UserProvider>(context, listen: false)
          .user
          .phoneNumber
          .countryISOCode;
      String urlAutoCompleteSearch =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&key=$map_key&components=country:$countryISO';
      var responseAutoCompleteSearch =
          await recieveRequest(urlAutoCompleteSearch);
      if (responseAutoCompleteSearch == 'Error') {
        return;
      }
      if (responseAutoCompleteSearch['status'] == 'OK') {
        if (mounted) {
          setState(() {
            predictionsList =
                (responseAutoCompleteSearch['predictions'] as List)
                    .map((jsonData) => PredictedPlaces.fromJson(jsonData))
                    .toList();
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        predictionsList.isNotEmpty && !selected
            ? PlacePredictionDropdown(
                predictedPlaces: predictionsList,
                setSelected: setSelected,
                setDropOffLoaction: setDropOffLocation)
            : Container(),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: ShapeDecoration(
              color: const Color.fromARGB(255, 36, 37, 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter trip details',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Container(
                    margin: const EdgeInsets.only(top: 6, bottom: 8),
                    child: customTextField(
                        context, 'Pickup', "Enter pickup location", false)),
                Container(
                    margin: const EdgeInsets.only(bottom: 18),
                    child: customTextField(
                        context, 'Dropoff', "Enter dropoff location", true)),
                userDropLocation != null
                    ? LongButton(
                        handler: () async {
                          Provider.of<LocationProvider>(context, listen: false)
                              .updateDropoffLocationAddress(userDropLocation!);
                          var origin = Provider.of<LocationProvider>(context,
                                  listen: false)
                              .userPickupLocation;
                          var originLatLng = LatLng(origin!.lat!, origin.long!);
                          var destinationLatLng = LatLng(
                              userDropLocation!.lat!, userDropLocation!.long!);
                          var directionDetails = await obtainDirectionDetails(
                              originLatLng, destinationLatLng);

                          tripDirectionDetailsInfo = directionDetails;
                          PolylinePoints polylinePoints = PolylinePoints();
                          List<PointLatLng> decodedPolylinePointsList =
                              polylinePoints
                                  .decodePolyline(directionDetails!.ePoints!);
                          if (decodedPolylinePointsList.isNotEmpty) {
                            decodedPolylinePointsList
                                .forEach((PointLatLng pointLatLng) {
                              widget.addTopolylineCoOrdinatesList(pointLatLng);
                            });
                          }

                          widget.setShowLocationPicker(false);

                          
                        },
                        isActive: true,
                        buttonText: 'Next',
                      )
                    : LongButton(
                        handler: () {}, buttonText: 'Next', isActive: false)
              ],
            )),
      ],
    );
  }

  //Custom widget
  Widget customTextField(context, label, placeholder, enabled) {
    if (label == 'Pickup') {
      pickupController.text =
          Provider.of<LocationProvider>(context).userPickupLocation != null
              ? Provider.of<LocationProvider>(context)
                  .userPickupLocation!
                  .locationName
                  .toString()
              : '';
    }

    return TextField(
      onChanged: (val) {
        if (label == 'Dropoff') {
          findPlaceAutoComplete(val);
        }
        if (userDropLocation != null) {
          if (userDropLocation!.locationName != val) {
            if (mounted) {
              setState(() {
                selected = false;
                userDropLocation = null;
              });
            }
          }
        }
      },
      controller: label == 'Pickup' ? pickupController : dropoffController,
      cursorColor: Theme.of(context).primaryColor,
      enabled: enabled,
      autofocus: false,
      autocorrect: false,
      style: const TextStyle(
          fontFamily: 'SF-Pro-Rounded', fontSize: 18, color: Colors.white),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        fillColor: const Color(0xFF43444B),
        filled: true,
        labelText: label,
        labelStyle: const TextStyle(
            color: Color(0xFFA0A0A0),
            fontSize: 16,
            fontFamily: 'SF-Pro-Rounded-Medium'),
        hintText: placeholder,
        hintStyle: const TextStyle(color: Color(0xFFA0A0A0)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
