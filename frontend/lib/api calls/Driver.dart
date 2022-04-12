// ignore_for_file: file_names

import 'package:http/http.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'dart:convert';

String _uri = 'http://10.0.2.2:8080/drivers';

Future<Response> fetchDriverDetails(String riderId, String bookingId,
    String driverId, PhoneNumber phoneNumber, String token) async {
  final response = await post(Uri.parse('$_uri/driver_details_for_trip'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
        'bookingId': bookingId,
        'riderId': riderId,
        'driverId': driverId
      }));
  return response;
}
