import 'package:http/http.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'dart:convert';

import '../global/configuration.dart';

String url = '$uri/bookings';

Future<Response> fetchScheduledBookings(
    String userId, PhoneNumber phoneNumber, String token) async {
  final response = await post(Uri.parse('$url/rider/my_scheduled_bookings'),
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
  final response = await post(Uri.parse('$url/rider/my_bookings_history'),
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
  final response = await post(Uri.parse('$url/driver/my_scheduled_bookings'),
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
  final response = await post(Uri.parse('$url/driver/my_bookings_history'),
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

Future<Response> createBooking(
    String riderId,
    String driverId,
    String pickup,
    String dropoff,
    PhoneNumber phoneNumber,
    String token) async {
  final response = await post(Uri.parse('$url/create_booking'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
        'driverId': driverId,
        'riderId': riderId,
        'pickup': pickup,
        'dropoff': dropoff,
      }));
  return response;
}

Future<Response> setArrived(String driverId, String bookingId,
    PhoneNumber phoneNumber, String token) async {
  final response = await post(Uri.parse('$uri/trips/set_arrived'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
        'driverId': driverId,
        'bookingId': bookingId
      }));
  return response;
}

Future<Response> setInProgress(String driverId, String bookingId,
    PhoneNumber phoneNumber, String token) async {
  final response = await patch(Uri.parse('$uri/trips/start_trip'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
        'driverId': driverId,
        'bookingId': bookingId
      }));
  return response;
}

Future<Response> setComplete(String driverId, String bookingId, int distance,
    PhoneNumber phoneNumber, String token) async {
  final response = await patch(Uri.parse('$uri/trips/end_trip'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
        'driverId': driverId,
        'bookingId': bookingId,
        'distance': distance
      }));
  return response;
}

Future<Response> fetchBookingDetails(String riderId, String driverId,
    PhoneNumber phoneNumber, String token) async {
  final response = await post(Uri.parse('$url/details'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
        'riderId': riderId,
        'driverId': driverId,
      }));
  return response;
}
