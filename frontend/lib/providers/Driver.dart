import 'package:flutter/material.dart';
import '../models/driver.dart';

class DriverProvider with ChangeNotifier {
  Driver driver = Driver('','','','',0,'','',[], false, false);
}
