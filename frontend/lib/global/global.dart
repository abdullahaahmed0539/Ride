import 'dart:async';

import 'package:geolocator/geolocator.dart';

import '../models/direction_detais_info.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

StreamSubscription<Position>? streamSubscriptionPosition;
StreamSubscription<Position>? streamSubscriptionDriverLivePosition;

//online nearest available driver list
List driversList = [];

DirectionDetailsInfo? tripDirectionDetailsInfo;

String? chosenDriverId = '';

AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

Position? driverCurrentLocation;
