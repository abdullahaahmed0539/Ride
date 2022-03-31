import 'package:intl_phone_field/phone_number.dart';
import '../services/string_extension.dart';

class User {
  String id;
  String firstName;
  String lastName;
  String email;
  PhoneNumber phoneNumber;
  String country;
  String walletAddress;
  bool isDriver = false;
  String token;
  String expiresIn;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.country,
      required this.email,
      required this.phoneNumber,
      required this.token,
      required this.walletAddress,
      required this.isDriver,
      required this.expiresIn});

  String getName() {
    return '${firstName.capitalize()} ${lastName.capitalize()}';
  }
}
