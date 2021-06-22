import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:black_cat_lib/widgets/ios_widgets.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:epic_skies/view/widgets/general/buttons/dialog_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';

import '../local_constants.dart';

void showNoConnectionDialog() {
  const title = 'No Network Connection';
  const content =
      'Epic Skies needs an internet connection to pull weather data';
  const goToSettings = 'Go to network settings';

  final dialog = Platform.isIOS
      ? CupertinoAlertDialog(
          title: const Text(title, style: TextStyle(fontSize: 20))
              .paddingOnly(bottom: 10),
          content: const IOSDialogTextWidget(text: content, fontSize: 17),
          actions: const [
            CupertinoDialogAction(
              onPressed: AppSettings.openWIFISettings,
              child: Text(goToSettings),
            ),
          ],
        )
      : const AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            DialogButton(
              onPressed: AppSettings.openWIFISettings,
              child: Text(goToSettings),
            ),
          ],
        );

  Get.dialog(dialog, barrierDismissible: true);
}

void show400ErrorDialog({required int statusCode}) {
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
          title: const Text(title, style: TextStyle(fontSize: 20))
              .paddingOnly(bottom: 10),
          content: const IOSDialogTextWidget(text: content, fontSize: 17),
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
            DialogButton(
              onPressed: _emailDeveloper,
              child: const Text(contactDeveloper),
            ),
            DialogButton(
              onPressed:
                  WeatherRepository.to.retryWeatherSearchAfterNetworkError,
              child: const Text(tryAgain),
            ),
          ],
        );

  Get.dialog(dialog, barrierDismissible: true);
}

void showTomorrowIOErrorDialog({required int statusCode}) {
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
          title: const Text(title, style: TextStyle(fontSize: 20))
              .paddingOnly(bottom: 10),
          content: IOSDialogTextWidget(text: content, fontSize: 17),
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
            DialogButton(
              onPressed: _emailDeveloper,
              child: const Text(contactDeveloper),
            ),
            DialogButton(
              onPressed:
                  WeatherRepository.to.retryWeatherSearchAfterNetworkError,
              child: const Text(tryAgain),
            ),
          ],
        );

  Get.dialog(dialog, barrierDismissible: true);
}
