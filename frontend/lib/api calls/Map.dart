import 'dart:convert';

import 'package:http/http.dart';

Future<dynamic> recieveRequest(String url) async {
  try {
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return 'Error';
    }
  } catch (exp) {
    return "Error";
  }
}
