import 'package:flutter/material.dart';
import '../models/app.dart';

class AppProvider with ChangeNotifier {
  App app = App('rider');
}
