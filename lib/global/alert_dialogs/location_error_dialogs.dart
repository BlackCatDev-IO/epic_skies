import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:black_cat_lib/widgets/ios_widgets.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_theme.dart';

Future<void> showLocationTimeoutDialog({required BuildContext context}) async {
  const content = Text(
      'Failed to get your current location. Please ensure your GPS is turned on and try again.');
  const title = Text('Check Location Settings');
  const goToSettings = Text('Go to location settings');
  const tryAgain = Text('Try Again');

  void retryLocation() {
    Get.back();
    WeatherRepository.to.fetchLocalWeatherData();
  }

  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
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
      context: context,
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

Future<void> showLocationPermissionDeniedDialog(
    {required BuildContext? context}) async {
  const goToSettings = 'Go to location settings';
  const tryAgain = 'Try Again';
  const textContent =
      'Please enable location permissions for Epic Skies so you can see your local weather forecast.';
  const titleText = 'Location permissions denied';

  void retryLocation() {
    Get.back();
    WeatherRepository.to.fetchLocalWeatherData();
  }

  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context!,
      builder: (context) => CupertinoAlertDialog(
        title: const IOSDialogTextWidget(
                text: titleText, fontColor: Colors.white, fontSize: 22)
            .paddingOnly(bottom: 5),
        content: const IOSDialogTextWidget(text: textContent),
        actions: [
          CupertinoDialogAction(
            onPressed: () => AppSettings.openLocationSettings(),
            child: const IOSDialogTextWidget(
                text: goToSettings, fontColor: Colors.blue),
          ),
          CupertinoDialogAction(
            onPressed: () => retryLocation(),
            child: const IOSDialogTextWidget(
                text: tryAgain, fontColor: Colors.blue),
          ),
        ],
      ),
    );
  } else {
    return showDialog(
      context: context!,
      builder: (context) => AlertDialog(
        title: const Text(titleText, style: dialogContentTextStyle),
        content: const Text(textContent, style: dialogContentTextStyle),
        actions: [
          TextButton(
            onPressed: () => AppSettings.openLocationSettings(),
            child: Text(goToSettings,
                style: dialogActionTextStyle.copyWith(fontSize: 18)),
          ),
          TextButton(
            onPressed: () => retryLocation(),
            child: Text(tryAgain,
                style: dialogActionTextStyle.copyWith(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}

Future<void> showLocationTurnedOffDialog(
    {required BuildContext? context}) async {
  const goToSettings = 'Go to location settings';
  const tryAgain = 'Try Again';
  const textContent =
      'Please turn on GPS so Epic Skies can get your local weather forecast.';
  const titleText = 'Location turned off';

  void retryLocation() {
    Get.back();
    WeatherRepository.to.fetchLocalWeatherData();
  }

  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context!,
      builder: (context) => CupertinoAlertDialog(
        title: const IOSDialogTextWidget(
                text: titleText, fontColor: Colors.white, fontSize: 22)
            .paddingOnly(bottom: 5),
        content: const IOSDialogTextWidget(text: textContent),
        actions: [
          CupertinoDialogAction(
            onPressed: () => AppSettings.openLocationSettings(),
            child: const IOSDialogTextWidget(
                text: goToSettings, fontColor: Colors.blue),
          ),
          CupertinoDialogAction(
            onPressed: () => retryLocation(),
            child: const IOSDialogTextWidget(
                text: tryAgain, fontColor: Colors.blue),
          ),
        ],
      ),
    );
  } else {
    return showDialog(
      context: context!,
      builder: (context) => AlertDialog(
        title: const Text(titleText, style: dialogTitleTextStyle),
        content: const Text(textContent, style: dialogContentTextStyle),
        actions: [
          TextButton(
            onPressed: () => AppSettings.openLocationSettings(),
            child: const Text(goToSettings, style: dialogActionTextStyle),
          ),
          TextButton(
            onPressed: () => retryLocation(),
            child: const Text(tryAgain, style: dialogActionTextStyle),
          ),
        ],
      ),
    );
  }
}
