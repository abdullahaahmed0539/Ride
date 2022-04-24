import 'package:flutter/material.dart';

class TripDetails extends StatelessWidget {
  final String waitTime, distance, duration;
  final double top, bottom;
  const TripDetails(
      {Key? key,
      required this.duration,
      required this.distance,
      required this.waitTime,
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
            Text(
              'Trip details',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Container(
                margin: const EdgeInsets.only(top: 6),
                child: Text(
                  'Distance: $distance kilometers',
                  style: Theme.of(context).textTheme.titleSmall,
                )),
            Text('Duration: $duration minutes',
                style: Theme.of(context).textTheme.titleSmall),
            Text('Driver wait time: $waitTime minutes',
                style: Theme.of(context).textTheme.titleSmall),
          ],
        ));
  }
}
