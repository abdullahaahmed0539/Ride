// ignore_for_file: file_names
import 'package:intl_phone_field/phone_number.dart';
import 'package:http/http.dart';
import 'dart:convert';

String _uri = 'http://10.0.2.2:8080/users';

Future<Response> userExists(PhoneNumber phoneNumber) async {
  final response = await post(Uri.parse('$_uri/exists'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
      }));
  return response;
}

Future<Response> login(PhoneNumber phoneNumber) async {
  final response = await post(Uri.parse('$_uri/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
      }));
  return response;
}

Future<Response> register(PhoneNumber phoneNumber, String firstName,
    String lastName, String email, String walletAddress) async {
  final response = await post(Uri.parse('$_uri/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
        'country': phoneNumber.countryISOCode,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'walletAddress': walletAddress
      }));
  return response;
}

Future<Response> updateName(PhoneNumber phoneNumber, String firstName,
    String lastName, String token) async {
  final response = await patch(Uri.parse('$_uri/update_name'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
        'firstName': firstName,
        'lastName': lastName,
      }));
  return response;
}

Future<Response> updateEmail(
    PhoneNumber phoneNumber, String email, String token) async {
  final response = await patch(Uri.parse('$_uri/update_email'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
        'email': email,
      }));
  return response;
}

Future<Response> updatePhoneNumber(
    PhoneNumber phoneNumber, PhoneNumber newPhoneNumber, String token) async {
  final response = await patch(Uri.parse('$_uri/update_phone_number'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
        'newPhoneNumber':
            '${newPhoneNumber.countryCode}${newPhoneNumber.number}',
        'country': newPhoneNumber.countryISOCode,
      }));
  return response;
}

Future<Response> fetchUserDetails(PhoneNumber phoneNumber, String token) async {
  final response = await post(Uri.parse('$_uri/details'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
      }));
  return response;
}
