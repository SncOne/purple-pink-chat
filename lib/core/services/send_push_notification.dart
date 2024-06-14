import 'dart:convert';

import 'package:catt_catt/utils/print.dart';
import 'package:http/http.dart' as http;

Future<void> sendPushNotification(final String deviceToken) async {
  const serverKey = '';
  const apiUrl = 'https://fcm.googleapis.com/fcm/send';

  final notification = <String, dynamic>{
    'to': deviceToken,
    'notification': {
      'title': 'title',
      'body': 'body',
    },
    'data': {},
  };

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    },
    body: jsonEncode(notification),
  );

  Print.info('FCM Response status: ${response.statusCode}');
  Print.info('FCM Response body: ${response.body}');
}
