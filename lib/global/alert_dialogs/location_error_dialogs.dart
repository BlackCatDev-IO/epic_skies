import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_theme.dart';

void showLocationTimeoutDialog() {
  const content =
      'Failed to get your current location. Please ensure your GPS is turned on and try again.';
  const title = 'Check Location Settings';
  const goToSettings = 'Go to location settings';
  const tryAgain = 'Try again';

  final dialog = Platform.isIOS
      ? CupertinoAlertDialog(
          title: const Text(title).paddingOnly(bottom: 10),
          content: Text(content, style: iOSContentTextStyle),
          actions: [
            const CupertinoDialogAction(
              onPressed: AppSettings.openLocationSettings,
              child: Text(goToSettings),
            ),
            CupertinoDialogAction(
              onPressed:
                  WeatherRepository.to.retryLocalWeatherAfterLocationError,
              child: const Text(tryAgain),
            ),
          ],
        )
      : AlertDialog(
          title: const Text(title),
          content: const Text(content),
          actions: [
            TextButton(
              onPressed: AppSettings.openLocationSettings,
              child: Text(goToSettings, style: dialogActionTextStyle),
            ),
            TextButton(
              onPressed:
                  WeatherRepository.to.retryLocalWeatherAfterLocationError,
              child: Text(tryAgain, style: dialogActionTextStyle),
            ),
          ],
        );

  Get.dialog(dialog, barrierDismissible: true);
}

void showLocationPermissionDeniedDialog() {
  const goToSettings = 'Go to location settings';
  const tryAgain = 'Try Again';
  const content =
      'Please enable location permissions for Epic Skies so you can see your local weather forecast.';
  const title = 'Location permissions denied';

  final dialog = Platform.isIOS
      ? CupertinoAlertDialog(
          title: const Text(title).paddingOnly(bottom: 10),
          content: Text(content, style: iOSContentTextStyle),
          actions: [
            const CupertinoDialogAction(
              onPressed: AppSettings.openLocationSettings,
              child: Text(goToSettings),
            ),
            CupertinoDialogAction(
              onPressed:
                  WeatherRepository.to.retryLocalWeatherAfterLocationError,
              child: const Text(tryAgain),
            ),
          ],
        )
      : AlertDialog(
          title: const Text(title),
          content: const Text(content),
          actions: [
            TextButton(
              onPressed: AppSettings.openLocationSettings,
              child: Text(goToSettings, style: dialogActionTextStyle),
            ),
            TextButton(
              onPressed:
                  WeatherRepository.to.retryLocalWeatherAfterLocationError,
              child: Text(tryAgain, style: dialogActionTextStyle),
            ),
          ],
        );

  Get.dialog(dialog, barrierDismissible: true);
}

void showLocationTurnedOffDialog() {
  const goToSettings = 'Go to location settings';
  const tryAgain = 'Try Again';
  const content =
      'Please turn on GPS so Epic Skies can get your local weather forecast.';
  const title = 'Location turned off';

  final dialog = Platform.isIOS
      ? CupertinoAlertDialog(
          title: const Text(title).paddingOnly(bottom: 10),
          content:  Text(content, style: iOSContentTextStyle),
          actions: [
            const CupertinoDialogAction(
              onPressed: AppSettings.openLocationSettings,
              child: Text(goToSettings),
            ),
            CupertinoDialogAction(
              onPressed:
                  WeatherRepository.to.retryLocalWeatherAfterLocationError,
              child: const Text(tryAgain),
            ),
          ],
        )
      : AlertDialog(
          title: const Text(title),
          content: const Text(content),
          actions: [
            TextButton(
              onPressed: AppSettings.openLocationSettings,
              child: Text(goToSettings, style: dialogActionTextStyle),
            ),
            TextButton(
              onPressed:
                  WeatherRepository.to.retryLocalWeatherAfterLocationError,
              child: Text(tryAgain, style: dialogActionTextStyle),
            ),
          ],
        );

  Get.dialog(dialog, barrierDismissible: true);
}
