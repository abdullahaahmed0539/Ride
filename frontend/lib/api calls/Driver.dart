// ignore_for_file: file_names

import 'package:frontend/global/configuration.dart';
import 'package:http/http.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'dart:convert';

String url = '$uri/drivers';

Future<Response> fetchDriverDetailsForSummary(String riderId, String bookingId,
    String driverId, PhoneNumber phoneNumber, String token) async {
  final response = await post(Uri.parse('$url/driver_details_for_trip'),
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

Future<Response> switchModes(String userId, String appMode,
    PhoneNumber phoneNumber, String token) async {
  // print(appMode);
  final response = await patch(Uri.parse('$url/switch_mode'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
        'userId': userId,
        'appMode': appMode
      }));
  return response;
}

Future<Response> fetchDriverDetails(
    String driverId, PhoneNumber phoneNumber, String token) async {
  final response = await post(Uri.parse('$url/driver_details'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
        'driverId': driverId,
      }));
  return response;
}

Future<Response> createDriverOnBoardingRequest(
    String userId,
    String carModel,
    String licenseURL,
    String cnic,
    String color,
    String registrationNumber,
    double milage,
    PhoneNumber phoneNumber,
    String token) async {
  final response =
      await post(Uri.parse('$uri/requests/create_onboarding_request'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(<String, dynamic>{
            'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
            'userId': userId,
            'carModel': carModel,
            'licenseURL': licenseURL,
            'cnic': cnic,
            'color': color,
            'registrationNumber': registrationNumber,
            'milage': milage,
          }));
  return response;
}
