import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:black_cat_lib/widgets/ios_widgets.dart';
import 'package:black_cat_lib/widgets/my_custom_widgets.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

Future<void> showLocationTurnedOffDialog(
    {required BuildContext? context}) async {
  const content = Text(
      'Please turn on location to allow Epic Skies to fetch your local weather conditions');
  const title = Text('Location turned off');
  const goToSettings = Text('Go to location settings');
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
            child: goToSettings,
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
            child: goToSettings,
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
