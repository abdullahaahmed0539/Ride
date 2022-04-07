// ignore_for_file: file_names

import 'package:frontend/providers/App.dart';
import 'package:http/http.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String _uri = 'http://10.0.2.2:8080/trips';

Future<Response> fetchTripDetails(
    BuildContext ctx,
    String userId,
    String bookingId,
    String appMode,
    PhoneNumber phoneNumber,
    String token) async {
  final response = await post(Uri.parse('$_uri/details'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
        'bookingId': bookingId,
        'userId': userId,
        'mode': appMode
      }));
  return response;
}
