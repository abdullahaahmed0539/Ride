//packages
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/services/utilities.dart';
import 'package:intl_phone_field/phone_number.dart';

//custom
import '../models/User.dart';

class UserProvider with ChangeNotifier {
  late User user;

  void onLogin(var response) {
    var responseData = json.decode(response.body)['data'];
    PhoneNumber extractedPhoneNumber = convertToPhoneNumber(
        responseData['phoneNumber'], responseData['country']);
    user = User(
        id: responseData['_id'],
        firstName: responseData['firstName'],
        lastName: responseData['lastName'],
        email: responseData['email'],
        phoneNumber: extractedPhoneNumber,
        country: responseData['country'],
        walletAddress: responseData['walletAddress'],
        isDriver: responseData['isDriver'],
        token: responseData['token'],
        expiresIn: responseData['expiresIn']);
  }

  void updateUserName(
    String firstName,
    String lastName,
  ) {
    user.firstName = firstName;
    user.lastName = lastName;
  }

  void updateUserEmail(String email) {
    user.email = email;
  }

  void updateUserPhoneNumberAndCountry(
      PhoneNumber phoneNumber, String country, String token) {
    user.phoneNumber = phoneNumber;
    user.country = country;
    user.token = token;
  }
}
