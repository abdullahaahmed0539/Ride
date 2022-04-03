import 'package:intl_phone_field/phone_number.dart';
import 'package:http/http.dart';
import 'dart:convert';

String _uri = 'http://10.0.2.2:8080/disputes';

Future<Response> addVote(String userId, String disputeId, dynamic voteFor,
    PhoneNumber phoneNumber, String token) async {
  final response = await patch(Uri.parse('$_uri/add_vote'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
        'userId': userId,
        'disputeId': disputeId,
        'voteFor': voteFor.toString()
      }));
  return response;
}

Future<Response> fetchDisputesForVoting(
    String userId, PhoneNumber phoneNumber, String token) async {
  final response =
      await post(Uri.parse('$_uri/disputes_available_for_voting/$userId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(<String, String>{
            'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
          }));
  return response;
}

Future<Response> fetchMyDisputes(
    String userId, PhoneNumber phoneNumber, String token) async {
  final response = await post(Uri.parse('$_uri/my_disputes/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
      }));
  return response;
}

Future<Response> fetchDisputesOnMe(
    String userId, PhoneNumber phoneNumber, String token) async {
  final response = await post(Uri.parse('$_uri/disputes_on_me/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
      }));
  return response;
}

Future<Response> fetchMyCompletedDisputes(
    String userId, PhoneNumber phoneNumber, String token) async {
  final response = await post(Uri.parse('$_uri/my_disputes_results/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
      }));
  return response;
}

Future<Response> fetchActiveDisputesOnMe(
    String userId, PhoneNumber phoneNumber, String token) async {
  final response = await post(Uri.parse('$_uri/disputes_on_me_pending/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
      }));
  return response;
}

Future<Response> fetchDisputeDetail(
    String? disputeId, PhoneNumber phoneNumber, String token) async {
  final response = await post(Uri.parse('$_uri/$disputeId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
      }));
  return response;
}

Future<Response> addClaim(String disputeId, String defendentsClaim,
    String userId, PhoneNumber phoneNumber, String token) async {
  final response = await patch(Uri.parse('$_uri/add_my_claim'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': '${phoneNumber.countryCode}${phoneNumber.number}',
        'disputeId': disputeId,
        'userId': userId,
        'defendentsClaim': defendentsClaim
      }));
  return response;
}
