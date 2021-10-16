import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';


final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

Future<void> initFirebaseNotifications() async {
  await firebaseMessaging.requestPermission();

  final NotificationSettings settings =
      await firebaseMessaging.requestPermission();

  log('User granted permission: ${settings.authorizationStatus}');

  final token = await firebaseMessaging.getToken(
    vapidKey:
        'BPR1UzDkzxFvPsWnwcYF7_sIK60RHscHEwwzxkE9wpk4P27eKyB_HqZoZ8r9FfQMBitrlK3cI-fs3uBVqbIQujk',
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log('Got a message whilst in the foreground!');
    log('Message data: ${message.data}');

    if (message.notification != null) {
      log('Message also contained a notification: ${message.notification}');
    }
  });

  log('token $token');
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Handling a background message: ${message.notification} id: ${message.messageId}");
}

Future<String?> requestGenerateFirebaseToken() async {
  log(firebaseMessaging.getToken().toString());
  return firebaseMessaging.getToken();
}

Future onSelectNotification(String payload) async {
  log("onSelectNotification:$payload");
}
