import 'package:flutter/material.dart';
import 'package:frontend/screens/booking/select_nearest_active_drivers.dart';
import 'package:frontend/screens/driver/driver_map_for_ride.dart';
import 'package:frontend/screens/driver/driver_signup.dart';

import '../screens/booking/rider_booking.dart';
import '../screens/booking/booking_detail.dart';
import '../screens/disputes/dispute_detail.dart';
import '../screens/disputes/dispute_guidelines.dart';
import '../screens/disputes/dispute_tabs.dart';
import '../screens/home.dart';
import '../screens/driver/trip_screen.dart';
import '../screens/users/login.dart';
import '../screens/disputes/create_dispute.dart';
import '../screens/rating.dart';
import '../screens/users/verification.dart';
import '../screens/users/register.dart';
import '../screens/profile.dart';
import '../screens/users/personal_information.dart';
import '../screens/voting/voting.dart';
import '../screens/voting/voting_guidelines.dart';
import '../screens/users/wallet.dart';
import '../screens/booking/activities_tab.dart';
import '../screens/users/update_email.dart';
import '../screens/users/update_name.dart';
import '../screens/users/update_phone_number.dart';

Map<String, Widget Function(BuildContext)> routes() {
  return {
    Home.routeName: (context) => const Home(),
    Login.routeName: (context) => const Login(),
    Register.routeName: (context) => const Register(),
    Verification.routeName: (context) => const Verification(),
    Rating.routeName: (context) => const Rating(),
    DisputeGuidelines.routeName: (context) => const DisputeGuidelines(),
    PublishDispute.routeName: (context) => const PublishDispute(),
    RiderBooking.routeName: (context) => const RiderBooking(),
    VotingGuidelines.routeName: (context) => const VotingGuidelines(),
    Voting.routeName: (context) => const Voting(),
    Wallet.routeName: (context) => const Wallet(),
    Profile.routeName: (context) => const Profile(),
    PersonalInformation.routeName: (context) => const PersonalInformation(),
    DisputeDetail.routeName: (context) => const DisputeDetail(),
    DisputeTabs.routeName: (context) => const DisputeTabs(),
    Activities.routeName: (context) => const Activities(),
    UpdateName.routeName: (context) => const UpdateName(),
    UpdateEmail.routeName: (context) => const UpdateEmail(),
    UpdatePhoneNumber.routeName: (context) => const UpdatePhoneNumber(),
    BookingDetail.routeName: (context) => const BookingDetail(),
    DriverMapForRide.routeName: (context) => const DriverMapForRide(),
    SelectNearestActiveDrivers.routeName: (context) => const SelectNearestActiveDrivers(),
    DriverSignup.routeName:(context)=> const DriverSignup(),
    NewTripScreen.routeName:(context)=> const NewTripScreen()
  };
}
