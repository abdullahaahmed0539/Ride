import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/api%20calls/bookings.dart';
import 'package:frontend/models/booking.dart';
import 'package:frontend/models/driver.dart';
import 'package:frontend/models/rider_ride_request_info.dart';
import 'package:frontend/providers/driver.dart';
import 'package:frontend/providers/user.dart';
import 'package:frontend/services/user_alert.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:frontend/widgets/ui/long_button.dart';

import '../../models/user.dart';
import '../../providers/booking.dart';

// ignore: must_be_immutable
class RiderDetails extends StatefulWidget {
  final String? duration, riderName, dropoff, pickup;
  String? rideRequestStatus;
  final RiderRideRequestInformation? riderRideRequestInformation;
  final Function? drawPolylineFromPickupToDropoff,
      endTripNow,
      setRideRequestStatus;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  bool? nearby;
  RiderDetails({
    this.riderRideRequestInformation,
    this.drawPolylineFromPickupToDropoff,
    this.setRideRequestStatus,
    this.rideRequestStatus,
    this.dropoff,
    this.endTripNow,
    this.nearby,
    this.duration,
    this.pickup,
    this.scaffoldKey,
    this.riderName,
    Key? key,
  }) : super(key: key);

  @override
  State<RiderDetails> createState() => _RiderDetailsState();
}

class _RiderDetailsState extends State<RiderDetails> {
  String buttonText = 'Arrived';
  String rideStatus = 'accepted';

  get streamSubscriptionDriverLivePosition => null;

  void setArrivedResponseHandler(Response response) async {
    if (response.statusCode != 201 && response.statusCode != 401) {
      snackBar(widget.scaffoldKey!, 'Internal server error');
    }

    if (response.statusCode == 201) {
      widget.setRideRequestStatus!('arrived');
      setState(() {
        rideStatus = 'arrived';
      });
      Provider.of<BookingProvider>(context, listen: false)
          .booking
          .setStatus('arrived');
      Fluttertoast.showToast(
          gravity: ToastGravity.TOP,
          msg: 'Rider has been notified',
          backgroundColor: Theme.of(context).primaryColor,
          timeInSecForIosWeb: 5);

      FirebaseDatabase.instance
          .ref()
          .child('allRideRequests')
          .child(widget.riderRideRequestInformation!.rideRequestId!)
          .child('status')
          .set(rideStatus);

      setState(() {
        buttonText = 'Start';
      });

      await widget.drawPolylineFromPickupToDropoff!(
        widget.riderRideRequestInformation!.pickupLatLng,
        widget.riderRideRequestInformation!.dropoffLatLng,
      );
    }

    if (response.statusCode == 401) {
      snackBar(widget.scaffoldKey!, 'This is not your ride');
    }
  }

  setInProgressHandlerResponseHandler(Response response) async {
    if (response.statusCode != 201 && response.statusCode != 401) {
      snackBar(widget.scaffoldKey!, 'Internal server error');
    }

    if (response.statusCode == 201) {
      widget.setRideRequestStatus!('inprogress');
      setState(() {
        rideStatus = 'inprogress';
      });
      Provider.of<BookingProvider>(context, listen: false)
          .booking
          .setStatus('inprogress');
      Fluttertoast.showToast(
          gravity: ToastGravity.TOP,
          msg: 'Ride has started',
          backgroundColor: Theme.of(context).primaryColor,
          timeInSecForIosWeb: 5);

      FirebaseDatabase.instance
          .ref()
          .child('allRideRequests')
          .child(widget.riderRideRequestInformation!.rideRequestId!)
          .child('status')
          .set(rideStatus);

      setState(() {
        buttonText = 'End';
      });
    }

    if (response.statusCode == 401) {
      snackBar(widget.scaffoldKey!, 'This is not your ride');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: ShapeDecoration(
              color: const Color.fromARGB(255, 36, 37, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      widget.riderName!,
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    Expanded(
                      child: Text(
                        '${widget.duration!} ',
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.clip,
                      ),
                    )
                  ],
                ),
                const Divider(color: Colors.white, thickness: 1),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Flexible(
                        child: Text(
                          widget.pickup!,
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Flexible(
                        child: Text(
                          widget.dropoff!,
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor),
                        onPressed: () async {
                          await url_launcher.launchUrl(
                              Uri.parse('tel://${widget.riderRideRequestInformation!.riderPhoneNumber}'));
                        },
                        icon: const Icon(
                          Icons.phone_android,
                          color: Colors.white,
                          size: 22,
                        ),
                        label: const Text('Call rider')),
                  ],
                ),
                const Divider(
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 15,
                ),
                widget.nearby!
                    ? LongButton(
                        handler: () async {
                          Driver driver = Provider.of<DriverProvider>(context,
                                  listen: false)
                              .driver;
                          User user =
                              Provider.of<UserProvider>(context, listen: false)
                                  .user;
                          Booking booking = Provider.of<BookingProvider>(
                                  context,
                                  listen: false)
                              .booking;
                          if (widget.rideRequestStatus == 'accepted') {
                            Response response = await setArrived(
                                driver.driverId,
                                booking.id,
                                user.phoneNumber,
                                user.token);
                            setArrivedResponseHandler(response);
                          } else if (widget.rideRequestStatus == 'arrived') {
                            Response response = await setInProgress(
                                driver.driverId,
                                booking.id,
                                user.phoneNumber,
                                user.token);
                            setInProgressHandlerResponseHandler(response);
                          } else if (widget.rideRequestStatus == 'inprogress') {
                            widget.endTripNow!();
                          }
                        },
                        buttonText: buttonText,
                        isActive: true)
                    : LongButton(
                        handler: () {}, buttonText: 'Arrived', isActive: false)
              ],
            )),
      ],
    );
  }
}
