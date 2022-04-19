import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:frontend/api%20calls/Map.dart';
import 'package:frontend/global/configuration.dart';
import 'package:frontend/models/Directions.dart';
import 'package:frontend/providers/Location.dart';
import 'package:provider/provider.dart';
import '../../models/PredictedPlaces.dart';

class PlacePredictionDropdown extends StatelessWidget {
  final List<PredictedPlaces>? predictedPlaces;
  final Function? setSelected;
  final Function? setDropOffLoaction;
  const PlacePredictionDropdown(
      {this.predictedPlaces,
      this.setSelected,
      this.setDropOffLoaction,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 220,
        margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        decoration: ShapeDecoration(
          color: const Color.fromARGB(255, 36, 37, 40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Scrollbar(
          trackVisibility: true,
          isAlwaysShown: true,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...predictedPlaces!
                      .map((place) => listItem(place, context))
                      .toList()
                ]),
          ),
        ));
  }

  getPlaceDirectionDetails(String placeId, context) async {
    String placeDirectionDetailsUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$map_key';
    var response = await recieveRequest(placeDirectionDetailsUrl);
    if (response == 'Error') {
      return;
    }
    if (response['status'] == 'OK') {
      Directions dropOffDirection = Directions(
          locationId: placeId,
          locationName: response['result']['name'],
          lat: response['result']['geometry']['location']['lat'],
          long: response['result']['geometry']['location']['lng']);

      setDropOffLoaction!(dropOffDirection);

    
    }
  }

  Widget listItem(place, context) {
    return GestureDetector(
      child: Bounceable(
        onTap: () {
          getPlaceDirectionDetails(place!.placeId, context);
          setSelected!(true);
        },
        child: Column(children: [
          Row(
            children: [
              const Icon(
                Icons.add_location,
                color: Colors.white,
                size: 30,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                  child: Text(
                place.mainText,
                style: Theme.of(context).textTheme.titleMedium,
              ))
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 35,
              ),
              Expanded(
                  child: Text(
                place.secondaryText,
                style: Theme.of(context).textTheme.titleSmall,
              )),
            ],
          ),
          const Divider(
            color: Colors.white,
          )
        ]),
      ),
    );
  }
}
