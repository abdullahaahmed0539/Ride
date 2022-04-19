// ignore_for_file: file_names

import 'package:http/http.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'dart:convert';

String url = '$url/bookings';

Future<Response> fetchScheduledBookings(
    String userId, PhoneNumber phoneNumber, String token) async {
  final response =
      await post(Uri.parse('$url/rider/my_scheduled_bookings'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(<String, String>{
            'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
            'riderId': userId
          }));
  return response;
}

Future<Response> fetchBookingsHistory(
    String userId, PhoneNumber phoneNumber, String token) async {
  final response =
      await post(Uri.parse('$url/rider/my_bookings_history'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(<String, String>{
            'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
            'riderId': userId
          }));
  return response;
}

Future<Response> fetchScheduledBookingsForDriver(
    String userId, PhoneNumber phoneNumber, String token) async {
  final response =
      await post(Uri.parse('$url/driver/my_scheduled_bookings'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(<String, String>{
            'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
            'driverId': userId
          }));
  return response;
}

Future<Response> fetchBookingsHistoryForDriver(
    String userId, PhoneNumber phoneNumber, String token) async {
  final response =
      await post(Uri.parse('$url/driver/my_bookings_history'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(<String, String>{
            'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
            'driverId': userId
          }));
  return response;
}