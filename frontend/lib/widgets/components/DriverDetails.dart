import 'package:flutter/material.dart';
import 'package:frontend/services/string_extension.dart';
import 'package:frontend/widgets/ui/TextualButton.dart';

class DriverDetails extends StatelessWidget {
  final String firstName, lastName, carModel, color, registrationNumber;
  double top, bottom;

  DriverDetails(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.carModel,
      required this.color,
      required this.registrationNumber,
      required this.bottom,
      required this.top})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: top, bottom: bottom),
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        decoration: ShapeDecoration(
          color: const Color(0xff43444B),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Driver Information',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                // TextualButton(handler: () {}, buttonText: 'Raise a dispute')
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 6),
              child: Text(
                '${firstName.capitalize()} ${lastName.capitalize()}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
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
              registrationNumber,
              style: Theme.of(context).textTheme.titleSmall,
            ),
           
          ],
        ));
  }
}
