import 'package:flutter/material.dart';
import '../screens/Booking.dart';
import '../screens/DisputeGuidelines.dart';
import '../screens/Home.dart';
import '../screens/Login.dart';
import '../screens/PublishDispute.dart';
import '../screens/Rating.dart';
import '../screens/Verification.dart';
import '../screens/Register.dart';
import '../screens/Profile.dart';
import '../screens/PersonalInformation.dart';
import '../screens/Voting.dart';
import '../screens/VotingGuidelines.dart';
import '../screens/Wallet.dart';
import '../screens/Activities.dart';
import '../screens/Disputes.dart';
import '../screens/UpdateEmail.dart';
import '../screens/UpdateName.dart';
import '../screens/UpdatePhoneNumber.dart';

Map<String, Widget Function(BuildContext)> routes() {
  return {
    Home.routeName: (context) => const Home(),
    Login.routeName: (context) => const Login(),
    Register.routeName: (context) => const Register(),
    Verification.routeName: (context) => const Verification(),
    Rating.routeName: (context) => const Rating(),
    DisputeGuidelines.routeName: (context) => const DisputeGuidelines(),
    PublishDispute.routeName: (context) => const PublishDispute(),
    Booking.routeName: (context) => const Booking(),
    VotingGuidelines.routeName: (context) => const VotingGuidelines(),
    Voting.routeName: (context) => const Voting(),
    Wallet.routeName: (context) => const Wallet(),
    Profile.routeName: (context) => const Profile(),
    PersonalInformation.routeName: (context) => const PersonalInformation(),
    Disputes.routeName: (context) => const Disputes(),
    Activities.routeName: (context) => const Activities(),
    UpdateName.routeName: (context) => const UpdateName(),
    UpdateEmail.routeName: (context) => const UpdateEmail(),
    UpdatePhoneNumber.routeName: (context) => const UpdatePhoneNumber(),
  };
}
