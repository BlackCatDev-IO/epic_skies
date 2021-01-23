import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../main.dart';

class NotificationController {
  // var settingsController = Get.find<SettingsController>();

  void testNotification() {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'TEST NOTIFICATION', platformChannelSpecifics,
        payload: 'item x');
  }
}
