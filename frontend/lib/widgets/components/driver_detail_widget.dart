import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverDetailWidget extends StatefulWidget {
  String? carColor,
      registrationNumber,
      driverRideStatus,
      carModel,
      driverName,
      driverPhoneNumber;
  DriverDetailWidget(
      {this.carColor,
      this.carModel,
      this.driverName,
      this.driverRideStatus,
      this.driverPhoneNumber,
      this.registrationNumber,
      Key? key})
      : super(key: key);

  @override
  State<DriverDetailWidget> createState() => _DriverDetailWidgetState();
}

class _DriverDetailWidgetState extends State<DriverDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        decoration: ShapeDecoration(
          color: const Color.fromARGB(255, 30, 31, 33),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.timer,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                widget.driverRideStatus! == 'Driver has arrived'
                    ? Text(
                        widget.driverRideStatus!,
                        style: const TextStyle(color: Colors.green),
                      )
                    : Text(widget.driverRideStatus!),
              ],
            ),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(widget.driverName!,
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            Row(
              children: [
                Text('${widget.carModel!} - '),
                const SizedBox(
                  height: 1,
                ),
                Text(widget.carColor!),
              ],
            ),
            Row(
              children: [
                Text(widget.registrationNumber!),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.phone_android,
                      color: Colors.white,
                      size: 22,
                    ),
                    label: const Text('Call driver')),
              ],
            )
          ],
        ));
  }
}
