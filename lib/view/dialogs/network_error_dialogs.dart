import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';

import '../../global/app_theme.dart';
import '../../global/local_constants.dart';

class NetworkDialogs {
  static void showNoConnectionDialog() {
    const title = 'No Network Connection';
    const content =
        'Epic Skies needs an internet connection to pull weather data';
    const goToSettings = 'Go to network settings';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            title: const Text(title).paddingOnly(bottom: 10),
            content: Text(content, style: iOSContentTextStyle),
            actions: const [
              CupertinoDialogAction(
                onPressed: AppSettings.openWIFISettings,
                child: Text(goToSettings),
              ),
            ],
          )
        : AlertDialog(
            title: const Text(title),
            content: const Text(content),
            actions: [
              TextButton(
                onPressed: AppSettings.openWIFISettings,
                child: Text(goToSettings, style: dialogActionTextStyle),
              ),
            ],
          );

    Get.dialog(dialog, barrierDismissible: true);
  }

  static void show400ErrorDialog({required int statusCode}) {
    const content =
        "Whoops! Something went wrong with the network. Please try again. The developer has been notified. Click below to send any more info that you'd like.";
    const title = 'Network Error';
    const contactDeveloper = 'Email Developer';
    const tryAgain = 'Try Again';

    Future<void> _emailDeveloper() async {
      final Email email = Email(
        subject: 'Epic Skies Error: $statusCode',
        recipients: [myEmail],
      );
      await FlutterEmailSender.send(email);
    }

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            title: const Text(title).paddingOnly(bottom: 10),
            content: Text(content, style: iOSContentTextStyle),
            actions: [
              CupertinoDialogAction(
                onPressed: _emailDeveloper,
                child: const Text(contactDeveloper),
              ),
              CupertinoDialogAction(
                onPressed:
                    WeatherRepository.to.retryWeatherSearchAfterNetworkError,
                child: const Text(tryAgain),
              ),
            ],
          )
        : AlertDialog(
            title: const Text(title),
            content: const Text(content),
            actions: [
              TextButton(
                onPressed: _emailDeveloper,
                child: const Text(contactDeveloper),
              ),
              TextButton(
                onPressed:
                    WeatherRepository.to.retryWeatherSearchAfterNetworkError,
                child: Text(tryAgain, style: dialogActionTextStyle),
              ),
            ],
          );

    Get.dialog(dialog, barrierDismissible: true);
  }

  static void showTomorrowIOErrorDialog({required int statusCode}) {
    final content =
        'The weather data provider Tomorrow.io has encountered a server error: Status code $statusCode. The developer is aware and is contact with them. Please try again shortly.';
    const title = 'Data Provider Error';
    const contactDeveloper = 'Email Developer';
    const tryAgain = 'Try Again';

    Future<void> _emailDeveloper() async {
      final Email email = Email(
        subject: 'Epic Skies Error: $statusCode',
        recipients: [myEmail],
      );
      await FlutterEmailSender.send(email);
    }

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            title: const Text(title).paddingOnly(bottom: 10),
            content: Text(content, style: iOSContentTextStyle),
            actions: [
              CupertinoDialogAction(
                onPressed: _emailDeveloper,
                child: const Text(contactDeveloper),
              ),
              CupertinoDialogAction(
                onPressed:
                    WeatherRepository.to.retryWeatherSearchAfterNetworkError,
                child: const Text(tryAgain),
              ),
            ],
          )
        : AlertDialog(
            title: const Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: _emailDeveloper,
                child: const Text(contactDeveloper),
              ),
              TextButton(
                onPressed:
                    WeatherRepository.to.retryWeatherSearchAfterNetworkError,
                child: Text(tryAgain, style: dialogActionTextStyle),
              ),
            ],
          );

    Get.dialog(dialog, barrierDismissible: true);
  }
}
