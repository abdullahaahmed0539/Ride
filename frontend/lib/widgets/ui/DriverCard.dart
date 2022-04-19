// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:frontend/global/global.dart';
import 'package:frontend/services/string_extension.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../services/utilities.dart';

// ignore: must_be_immutable
class DriverCard extends StatelessWidget {
  final String driverId,
      firstName,
      lastName,
      carModel,
      color,
      registrationNumber;
  final List<dynamic> rating;
  double top, bottom;
  DriverCard(
      {Key? key,
      required this.driverId,
      required this.firstName,
      required this.lastName,
      required this.carModel,
      required this.color,
      required this.registrationNumber,
      required this.rating,
      required this.bottom,
      required this.top})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        chosenDriverId = driverId;
        Navigator.of(context).pop('driverChosen');
      },
      child: Container(
        margin: EdgeInsets.only(top: top, bottom: bottom),
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        decoration: ShapeDecoration(
          color: const Color(0xff43444B),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/driver.png'),
              backgroundColor: Color(0xff43444B),
              minRadius: 30,
            ),
            const SizedBox(
              width: 18,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${firstName.toString().capitalize()} ${lastName.toString().capitalize()}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    carModel.capitalize(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    color.capitalize(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    registrationNumber.capitalize(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SmoothStarRating(
                    rating: calculateRating(rating),
                    color: Colors.yellow,
                    borderColor: Colors.yellow,
                    allowHalfRating: false,
                    starCount: 5,
                    size: 15,
                  )
                ])
          ],
        ),
      ),
    );
  }
}
