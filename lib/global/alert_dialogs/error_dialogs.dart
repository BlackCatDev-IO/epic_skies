import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:black_cat_lib/widgets/my_custom_widgets.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showNoConnectionDialog({required BuildContext? context}) async {
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context!,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('No Network Connection'),
        content: const MyTextWidget(text: 'Please check your network settings'),
        actions: [
          CupertinoDialogAction(
            onPressed: () {},
            child: const MyTextWidget(text: 'Go to settings'),
          )
        ],
      ),
    );
  } else {
    return showDialog(
      context: context!,
      builder: (context) => AlertDialog(
        title: const Text('No Network Connection'),
        backgroundColor: Colors.white,
        content: const MyTextWidget(text: 'Please check your network settings'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Go to settings'),
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