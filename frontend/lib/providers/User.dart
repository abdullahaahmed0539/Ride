// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../models/User.dart';

class UserProvider with ChangeNotifier {
  User user = User();
}
