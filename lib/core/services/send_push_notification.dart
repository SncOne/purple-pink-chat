import 'dart:convert';

import 'package:catt_catt/utils/print.dart';
import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_admin/messaging.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';

Future<void> sendPushNotification({
  required String deviceToken,
  required String title,
  required String body,
}) async {
  final String res = await rootBundle.loadString('key.json');
  final data = await json.decode(res);
  final credentials = ServiceAccountCredentials.fromJson(data);
  final firebaseAdmin = FirebaseAdminApp.initializeApp(
    'catt-catt',
    Credential.fromServiceAccountParams(
      clientId: '113110539568147441495',
      email: credentials.email,
      privateKey: credentials.privateKey,
    ),
  );

  final messaging = Messaging(firebaseAdmin);

  final response = await messaging.send(
    TokenMessage(
      token: deviceToken,
      notification: Notification(
        title: 'Hello',
        body: 'World',
      ),
    ),
  );
  Print.info(response);
}
