import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> initFlutterLocalNotifications() async {
  const initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  const initializationSettingsIOS = IOSInitializationSettings();

  const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelect);
}

Future onSelect(String? data) async {
  debugPrint("onSelectNotification $data");
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  debugPrint("myBackgroundMessageHandler message: $message");
  final msgId = int.tryParse(message["data"]["msgId"].toString()) ?? 0;
  debugPrint("msgId $msgId");
  final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      color: Colors.blue.shade800,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker');
  const iOSPlatformChannelSpecifics = IOSNotificationDetails();
  final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  // await serviceLocatorInstance<NotificationService>().showNotificationWithDefaultSound(message);
  await flutterLocalNotificationsPlugin.show(
      msgId,
      message["data"]["msgTitle"] as String?,
      message["data"]["msgBody"] as String?,
      platformChannelSpecifics,
      payload: message["data"]["data"] as String?);
  // return Future<void>.value();
}
