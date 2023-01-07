import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';

import '../../features/main_weather/bloc/weather_bloc.dart';
import '../../global/app_theme.dart';
import '../../global/local_constants.dart';
import '../../services/ticker_controllers/tab_navigation_controller.dart';

class NetworkDialogs {
  static Future<void> _emailDeveloper(String subject) async {
    final Email email = Email(
      subject: subject,
      recipients: [myEmail],
    );
    await FlutterEmailSender.send(email);
  }

  static void showNoConnectionDialog() {
    const title = 'No Network Connection';
    const content =
        'Epic Skies needs an internet connection to pull weather data';
    const goToSettings = 'Go to network settings';
    const tryAgain = 'Try again';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            title: const Text(title).paddingOnly(bottom: 10),
            content: Text(content, style: iOSContentTextStyle),
            actions: [
              const CupertinoDialogAction(
                onPressed: AppSettings.openWIFISettings,
                child: Text(goToSettings),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(Get.context!).pop();
                  TabNavigationController.to.tabController.animateTo(0);
                  Get.context!.read<WeatherBloc>().add(RefreshWeatherData());
                },
                child: const Text(tryAgain),
              ),
            ],
          )
        : AlertDialog(
            title: const Text(title),
            content: const Text(content),
            actions: [
              const TextButton(
                onPressed: AppSettings.openWIFISettings,
                child: Text(goToSettings, style: dialogActionTextStyle),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(Get.context!).pop();
                  TabNavigationController.to.tabController.animateTo(0);
                  Get.context!.read<WeatherBloc>().add(RefreshWeatherData());
                },
                child: const Text(tryAgain, style: dialogActionTextStyle),
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

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            title: const Text(title).paddingOnly(bottom: 10),
            content: Text(content, style: iOSContentTextStyle),
            actions: [
              CupertinoDialogAction(
                onPressed: () =>
                    _emailDeveloper('Epic Skies Error: $statusCode'),
                child: const Text(contactDeveloper),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(Get.context!).pop();
                  TabNavigationController.to.tabController.animateTo(0);
                  Get.context!.read<WeatherBloc>().add(RefreshWeatherData());
                },
                child: const Text(tryAgain),
              ),
            ],
          )
        : AlertDialog(
            title: const Text(title),
            content: const Text(content),
            actions: [
              TextButton(
                onPressed: () =>
                    _emailDeveloper('Epic Skies Error: $statusCode'),
                child: const Text(contactDeveloper),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(Get.context!).pop();
                  TabNavigationController.to.tabController.animateTo(0);
                  Get.context!.read<WeatherBloc>().add(RefreshWeatherData());
                },
                child: const Text(tryAgain, style: dialogActionTextStyle),
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

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            title: const Text(title).paddingOnly(bottom: 10),
            content: Text(content, style: iOSContentTextStyle),
            actions: [
              CupertinoDialogAction(
                onPressed: () =>
                    _emailDeveloper('Epic Skies Error: $statusCode'),
                child: const Text(contactDeveloper),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(Get.context!).pop();
                  TabNavigationController.to.tabController.animateTo(0);
                  Get.context!.read<WeatherBloc>().add(RefreshWeatherData());
                },
                child: const Text(tryAgain),
              ),
            ],
          )
        : AlertDialog(
            title: const Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () =>
                    _emailDeveloper('Epic Skies Error: $statusCode'),
                child: const Text(contactDeveloper),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(Get.context!).pop();
                  TabNavigationController.to.tabController.animateTo(0);
                  Get.context!.read<WeatherBloc>().add(RefreshWeatherData());
                },
                child: const Text(tryAgain, style: dialogActionTextStyle),
              ),
            ],
          );

    Get.dialog(dialog, barrierDismissible: true);
  }
}
