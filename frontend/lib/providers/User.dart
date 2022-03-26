//packages
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/services/utilities.dart';
import 'package:intl_phone_field/phone_number.dart';

//custom
import '../models/User.dart';

class UserProvider with ChangeNotifier {
  late User user;

  Future<void> onLogin(var response) async {
    var responseData = json.decode(response.body)['data'];
    PhoneNumber extractedPhoneNumber = convertToPhoneNumber(responseData['phoneNumber'], responseData['country']);
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
}
