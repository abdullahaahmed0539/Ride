// ignore_for_file: file_names
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BookingDetailBlock extends StatelessWidget {
  final String bookingId, pickup, dropoff, status, date;
  double top, bottom;
  BookingDetailBlock(
      {Key? key,
      required this.bookingId,
      required this.pickup,
      required this.dropoff,
      required this.date,
      required this.status,
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
            Text('Booking Information', style: Theme.of(context).textTheme.titleMedium,),
            Container(
              margin: const EdgeInsets.only(top: 6),
              child: Text('ID: $bookingId', style: Theme.of(context).textTheme.titleSmall,)),
            Text('Status: $status',  style: Theme.of(context).textTheme.titleSmall),
            Text('Date: $date', style: Theme.of(context).textTheme.titleSmall,),
            Text('Pickup: $pickup', style: Theme.of(context).textTheme.titleSmall,),
            Text('Drop-off: $dropoff', style: Theme.of(context).textTheme.titleSmall,),
          ],
        ));
  }
}
