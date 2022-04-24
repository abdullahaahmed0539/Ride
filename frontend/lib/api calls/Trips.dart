import 'package:http/http.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'dart:convert';

import '../global/configuration.dart';

String url = '$uri/trips';

Future<Response> fetchTripDetails(String userId, String bookingId,
    String appMode, PhoneNumber phoneNumber, String token) async {
  final response = await post(Uri.parse('$url/details'),
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



