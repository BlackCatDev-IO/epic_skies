
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

Future<void> initFirebaseNotifications() async {
  await firebaseMessaging.requestPermission();

  final NotificationSettings settings =
      await firebaseMessaging.requestPermission();

  debugPrint('User granted permission: ${settings.authorizationStatus}');

  final token = await firebaseMessaging.getToken(
    vapidKey:
        'BPR1UzDkzxFvPsWnwcYF7_sIK60RHscHEwwzxkE9wpk4P27eKyB_HqZoZ8r9FfQMBitrlK3cI-fs3uBVqbIQujk',
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Got a message whilst in the foreground!');
    debugPrint('Message data: ${message.data}');

    if (message.notification != null) {
      debugPrint(
          'Message also contained a notification: ${message.notification}');
    }
  });

  debugPrint('token $token');
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint(
      "Handling a background message: ${message.notification} id: ${message.messageId}");
}

Future<String?> requestGenerateFirebaseToken() async {
  debugPrint(await firebaseMessaging.getToken());
  return firebaseMessaging.getToken();
}

Future onSelectNotification(String payload) async {
  debugPrint("onSelectNotification:$payload");
}
