// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../models/app.dart';

class AppProvider with ChangeNotifier {
  App app = App('rider');
}
