import 'dart:async';

import 'package:geolocator/geolocator.dart';

import '../models/DirectionDetailsInfo.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

StreamSubscription<Position>? streamSubscriptionPosition;

//online nearest available driver list
List driversList = [];

DirectionDetailsInfo? tripDirectionDetailsInfo;

String? chosenDriverId = '';

AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
