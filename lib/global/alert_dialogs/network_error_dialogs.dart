import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:black_cat_lib/widgets/ios_widgets.dart';
import 'package:black_cat_lib/widgets/my_custom_widgets.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';

Future<void> showNoConnectionDialog({required BuildContext? context}) async {
  const content =
      'Epic Skies needs an internet connection to pull weather data';
  const goToSettings = MyTextWidget(
    text: 'Go to network settings',
    color: Colors.blue,
    fontSize: 17,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w200,
  );
  if (Platform.isIOS) {
    return showCupertinoDialog(
      barrierDismissible: true,
      context: context!,
      builder: (context) => CupertinoAlertDialog(
        title: const IOSDialogTextWidget(
            text: 'No Network Connection', fontSize: 22),
        content:
            const IOSDialogTextWidget(text: content, fontColor: Colors.white54),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              AppSettings.openWIFISettings();
            },
            child: goToSettings,
          )
        ],
      ),
    );
  } else {
    return showDialog(
      barrierDismissible: true,
      context: context!,
      builder: (context) => AlertDialog(
        title: const MyTextWidget(
            text: 'No Network Connection', fontFamily: 'roboto'),
        backgroundColor: Colors.grey[850],
        content: const MyTextWidget(
          text: content,
          fontSize: 16,
          fontFamily: 'roboto',
          color: Colors.white54,
        ),
        actions: [
          TextButton(
            onPressed: () {
              AppSettings.openWIFISettings();
            },
            child: goToSettings,
          )
        ],
      ),
    );
  }
}

Future<void> show400ErrorDialog({required BuildContext? context}) async {
  const content = Text(
      "Whoops! Something went wrong with the network. Please try again. Developer has been notified. Click below to send any more info that you'd like.");
  const title = Text('Network Error');
  const contactDeveloper = Text('Contact Developer');
  const tryAgain = Text('Try Again');

  void retryLocation() {
    Get.back();
    WeatherRepository.to.fetchLocalWeatherData();
  }

  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context!,
      builder: (context) => CupertinoAlertDialog(
        title: title,
        content: content,
        actions: [
          CupertinoDialogAction(
            onPressed: () => AppSettings.openLocationSettings(),
            child: contactDeveloper,
          ),
          CupertinoDialogAction(
            onPressed: () => retryLocation(),
            child: tryAgain,
          ),
        ],
      ),
    );
  } else {
    return showDialog(
      context: context!,
      builder: (context) => AlertDialog(
        title: title,
        backgroundColor: Colors.white,
        content: content,
        actions: [
          TextButton(
            onPressed: () => AppSettings.openLocationSettings(),
            child: contactDeveloper,
          ),
          TextButton(
            onPressed: () => retryLocation(),
            child: tryAgain,
          ),
        ],
      ),
    );
  }
}

Future<void> showTomorrowIOErrorDialog(
    {required BuildContext? context, required int statusCode}) async {
  final content = Text(
    'The weather data provider Tomorrow.io has encountered an error: Status code $statusCode, please try again.',
    style: const TextStyle(fontSize: 17, color: Colors.white70),
  );
  final title =
      const Text('Data Provider Error', style: TextStyle(fontSize: 22))
          .paddingOnly(bottom: 5);
  const contactDeveloper =
      Text('Contact Developer', style: TextStyle(fontSize: 20));
  const tryAgain = Text('Try Again', style: TextStyle(fontSize: 20));

  void retryLocation() {
    Get.back();
    WeatherRepository.to.fetchLocalWeatherData();
  }

  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context!,
      builder: (context) => CupertinoAlertDialog(
        title: title,
        content: content,
        actions: [
          CupertinoDialogAction(
            onPressed: () async {
              final Email email = Email(
                subject: 'Epic Skies Feedback',
                recipients: ['loren@blackcataudio.net'],
              );
              await FlutterEmailSender.send(email);
            },
            child: contactDeveloper,
          ),
          CupertinoDialogAction(
            onPressed: () => retryLocation(),
            child: tryAgain,
          ),
        ],
      ),
    );
  } else {
    return showDialog(
      context: context!,
      builder: (context) => AlertDialog(
        title: title,
        backgroundColor: Colors.white,
        content: content,
        actions: [
          TextButton(
            onPressed: () => AppSettings.openLocationSettings(),
            child: contactDeveloper,
          ),
          TextButton(
            onPressed: () => retryLocation(),
            child: tryAgain,
          ),
        ],
      ),
    );
  }
}
