import 'package:http/http.dart';

Future<Response> sendPushNotification(header, body) async {
  final response = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: header,
      body: body);
  return response;
}
