import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';

class UserProvider with ChangeNotifier {
  String id = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  PhoneNumber phoneNumber =
      PhoneNumber(countryISOCode: '', countryCode: '', number: '');
  String country = '';
  String walletAddress = '';
  bool isDriver = false;
  String token = '';
  String expiresIn = '';

  void createUser(
      String _id,
      String _firstName,
      String _lastName,
      String _email,
      PhoneNumber _phoneNumber,
      String _country,
      String _walletAddress,
      bool _isDriver,
      String _token,
      String _expiresIn) {
    id = _id;
    firstName = _firstName;
    lastName = _lastName;
    email = _email;
    phoneNumber = _phoneNumber;
    country = _country;

    //add decryption
    walletAddress = _walletAddress;
    isDriver = _isDriver;
    token = _token;
    expiresIn = _expiresIn;
    notifyListeners();
  }
}
