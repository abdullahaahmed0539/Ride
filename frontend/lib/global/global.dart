import 'dart:async';

import 'package:geolocator/geolocator.dart';

import '../models/DirectionDetailsInfo.dart';

StreamSubscription<Position>? streamSubscriptionPosition;

//online nearest available driver list
List driversList = [];

DirectionDetailsInfo? tripDirectionDetailsInfo;

String? chosenDriverId = '';
