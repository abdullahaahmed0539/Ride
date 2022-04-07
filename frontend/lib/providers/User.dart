// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../models/User.dart';

class UserProvider with ChangeNotifier {
  User user = User(
      '',
      '',
      '',
      '',
      '',
      PhoneNumber(countryCode: '', countryISOCode: '', number: ''),
      '',
      '',
      false,
      '');
}
