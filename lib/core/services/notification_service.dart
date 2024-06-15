import 'package:catt_catt/utils/print.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final notificationServiceProvider = Provider((_) => NotificationService());

class NotificationService {
  FirebaseAuth get _auth => FirebaseAuth.instance;
  FirebaseMessaging get _notification => FirebaseMessaging.instance;

  User? get user => _auth.currentUser;
  final localNotification = FlutterLocalNotificationsPlugin();

  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    // Background message handling logic
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    // Handle the message, maybe navigate to a specific screen
  }

  Future<void> initNotifications() async {
    await _notification.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    RemoteMessage? initialMessage = await _notification.getInitialMessage();
    handleMessage(initialMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    // Register background message handler
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await localNotification.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            "channelId",
            "channelName",
            channelDescription: "channelDescription",
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    });
  }

  Future<void> requestNotificationPermission() async {
    await _notification.requestPermission();
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidImplementation?.requestNotificationsPermission();
    await initNotifications();
    final fcmToken = await _notification.getToken();
    Print.error(fcmToken);
  }
}
