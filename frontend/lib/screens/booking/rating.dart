import 'package:flutter/material.dart';
import 'package:frontend/api%20calls/drivers.dart';
import 'package:frontend/api%20calls/users.dart';
import 'package:frontend/providers/app.dart';
import 'package:frontend/providers/user.dart';
import 'package:frontend/screens/disputes/dispute_guidelines.dart';
import 'package:frontend/screens/driver/driver_map_for_ride.dart';
import 'package:frontend/services/user_alert.dart';
import 'package:frontend/widgets/ui/long_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../models/booking.dart';
import '../../models/user.dart';
import '../../providers/booking.dart';
import '../../widgets/ui/spinner.dart';
import '../home.dart';

class Rating extends StatefulWidget {
  static const routeName = '/rating';
  const Rating({Key? key}) : super(key: key);

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  double rating = 1;
  bool ratingChanged = false;
  bool loading = false;

  void setRating(double newRatingVal) {
    setState(() {
      rating = newRatingVal;
    });
  }

  void setRatingChanged(bool val) {
    setState(() {
      ratingChanged = val;
    });
  }

  void onSubmit() async {
    if(mounted){
     setState(() {
       loading=true;
     });
    }
    Response response = await addRating();
    addRatingResponseHandler(response);
    if (response.statusCode == 201) {
      if (Provider.of<AppProvider>(context, listen: false).app.getAppMode() ==
          'driver') {
        Navigator.of(context).pushReplacementNamed(Home.routeName);
        Navigator.of(context).pushNamed(DriverMapForRide.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(Home.routeName);
      }
    }
  }

  void onRaiseDispute() async {
    
    Response response = await addRating();
    addRatingResponseHandler(response);
    if (response.statusCode == 201) {
      Navigator.of(context).pushNamed(DisputeGuidelines.routeName);
    }
  }

  void addRatingResponseHandler(Response response) {
    if (response.statusCode != 201 && response.statusCode != 401) {
      if(mounted){
        setState((){loading=false;});
      }
      snackBar(scaffoldKey, 'Internal server error.');
    }
    if (response.statusCode == 401) {
       if(mounted){
        setState((){loading=false;});
      }
      snackBar(scaffoldKey, 'You are not allowed to add to rate.');
    }
  }

  Future<Response>addRating() async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    Booking booking =
        Provider.of<BookingProvider>(context, listen: false).booking;
    Response? response;
    Provider.of<AppProvider>(context, listen: false).app.getAppMode() ==
            'driver'
        ? response = await addUserRating(booking.riderId, booking.driverId,
            rating, booking.id, user.phoneNumber, user.token)
        : response = await addDriverRating(booking.riderId, booking.driverId,
            rating, booking.id, user.phoneNumber, user.token);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Rating'),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: !loading? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 60, bottom: 30),
                  child: Text(
                    'Your ride has ended. We hope you enjoyed your trip! Kindly rate your captain.',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: RatingBar.builder(
                    unratedColor: const Color(0xff43454A),
                    initialRating: 1,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    glow: false,
                    itemSize: 60,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 3),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Theme.of(context).primaryColor,
                    ),
                    onRatingUpdate: (newRatingVal) {
                      setRatingChanged(true);
                      setRating(newRatingVal);
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Did something go wrong on the trip? You can raise a dispute for voting and let the community help you.',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: onRaiseDispute,
                  child: Text(
                    'Raise a dispute for voting',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontFamily: "SF-Pro-Display"),
                  ),
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                ratingChanged
                    ? Container(
                        margin: const EdgeInsets.only(top: 320),
                        child: LongButton(
                            handler: onSubmit,
                            buttonText: 'Done',
                            isActive: true))
                    : Container(
                        margin: const EdgeInsets.only(top: 320),
                        child: LongButton(
                            handler: () {},
                            buttonText: 'Done',
                            isActive: false)),
              ]): Spinner(text: 'Adding rating', height: 100,),
        ),
      ),
    );
  }
}
