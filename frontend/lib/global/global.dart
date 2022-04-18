


import 'dart:async';

import 'package:geolocator/geolocator.dart';

StreamSubscription<Position>? streamSubscriptionPosition;

//online nearest available driver list
List driversList = [];