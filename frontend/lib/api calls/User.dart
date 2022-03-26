import 'package:intl_phone_field/phone_number.dart';
import 'package:http/http.dart';
import 'dart:convert';

Future<Response> login(PhoneNumber phoneNumber) async {
  final response = await post(Uri.parse('http://10.0.2.2:5000/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
      }));
  return response;
}

Future<Response> register(
    PhoneNumber phoneNumber,
    String firstName,
    String lastName,
    String email,
    String walletAddress) async {
  final response = await post(Uri.parse('http://10.0.2.2:5000/users/register'),
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
