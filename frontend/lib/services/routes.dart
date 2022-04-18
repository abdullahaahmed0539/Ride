import 'package:flutter/material.dart';
import 'package:frontend/screens/booking/SelectNearestActiveDrivers.dart';
import 'package:frontend/screens/driver/DriverMapForRide.dart';

import '../screens/booking/RiderBooking.dart';
import '../screens/booking/bookingDetail.dart';
import '../screens/disputes/DisputeDetail.dart';
import '../screens/disputes/DisputeGuidelines.dart';
import '../screens/disputes/DisputeTabs.dart';
import '../screens/Home.dart';
import '../screens/users/Login.dart';
import '../screens/disputes/PublishDispute.dart';
import '../screens/Rating.dart';
import '../screens/users/Verification.dart';
import '../screens/users/Register.dart';
import '../screens/Profile.dart';
import '../screens/users/PersonalInformation.dart';
import '../screens/voting/Voting.dart';
import '../screens/voting/VotingGuidelines.dart';
import '../screens/users/Wallet.dart';
import '../screens/booking/ActivitiesTab.dart';
import '../screens/users/UpdateEmail.dart';
import '../screens/users/UpdateName.dart';
import '../screens/users/UpdatePhoneNumber.dart';

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
    SelectNearestActiveDrivers.routeName: (context) => const SelectNearestActiveDrivers()
  };
}
