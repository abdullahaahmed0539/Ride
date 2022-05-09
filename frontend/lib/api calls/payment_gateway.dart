import 'package:http/http.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'dart:convert';
import '../global/configuration.dart';

String url = '$uri/payments';

Future<Response> makePayment(
   int amount, PhoneNumber phoneNumber, String token) async {
  final response = await post(Uri.parse('$url/make_payment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
        'amount': amount
      }));
  return response;
}