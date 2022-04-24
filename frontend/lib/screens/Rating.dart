import 'package:flutter/material.dart';
import 'package:frontend/providers/app.dart';
import 'package:frontend/screens/disputes/dispute_guidelines.dart';
import 'package:frontend/screens/driver/driver_map_for_ride.dart';
import 'package:frontend/widgets/ui/long_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Rating extends StatefulWidget {
  static const routeName = '/rating';
  const Rating({Key? key}) : super(key: key);

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  int rating = 1;
  bool ratingChanged = false;

  void setRating(double rating) {
    setState(() {
      rating = rating;
    });
  }

  void setRatingChanged(bool val) {
    setState(() {
      ratingChanged = val;
    });
  }

  void onSubmit() {
    //http request for submitting rating

    if (Provider.of<AppProvider>(context, listen: false).app.getAppMode() ==
        'driver') {
      Navigator.of(context).pushReplacementNamed(Home.routeName);
      Navigator.of(context).pushNamed(DriverMapForRide.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(Home.routeName);
    }
  }

  void onRaiseDispute() {
    //http request for submitting rating
    Navigator.of(context).pushNamed(DisputeGuidelines.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Rating'),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
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
                    onRatingUpdate: (rating) {
                      setRatingChanged(true);
                      setRating(rating);
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
                const SizedBox(height: 20,),
                TextButton(
                  onPressed: () {},
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
              ]),
        ),
      ),
    );
  }
}
