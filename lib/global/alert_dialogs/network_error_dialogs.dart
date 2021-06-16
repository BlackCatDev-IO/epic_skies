import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:black_cat_lib/widgets/ios_widgets.dart';
import 'package:black_cat_lib/widgets/my_custom_widgets.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
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

Future<void> show400ErrorDialog(
    {required BuildContext context, required int statusCode}) async {
  const content =
      "Whoops! Something went wrong with the network. Please try again. The developer has been notified. Click below to send any more info that you'd like.";
  const title = 'Network Error';
  const contactDeveloper = 'Contact Developer';
  const tryAgain = 'Try Again';

  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const IOSDialogTextWidget(
                text: title, fontColor: Colors.white, fontSize: 22)
            .paddingOnly(bottom: 5),
        content: const IOSDialogTextWidget(text: content),
        actions: [
          CupertinoDialogAction(
            onPressed: () => AppSettings.openLocationSettings(),
            child: const IOSDialogTextWidget(
                text: contactDeveloper, fontColor: Colors.blue),
          ),
          CupertinoDialogAction(
            onPressed: () => Get.back(),
            child: const IOSDialogTextWidget(
                text: tryAgain, fontColor: Colors.blue),
          ),
        ],
      ),
    );
  } else {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(title, style: dialogTitleTextStyle),
        content: const Text(content, style: dialogContentTextStyle),
        actions: [
          TextButton(
            onPressed: () async {
              final Email email = Email(
                subject: 'Epic Skies Error: $statusCode',
                recipients: ['loren@blackcataudio.net'],
              );
              await FlutterEmailSender.send(email);
            },
            child: const Text(contactDeveloper, style: dialogActionTextStyle),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(tryAgain, style: dialogActionTextStyle),
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

  Future<void> _send401Email() async {
    final Email email = Email(
      subject: 'Epic Skies Feedback',
      recipients: ['loren@blackcataudio.net'],
    );
    await FlutterEmailSender.send(email);
    Get.back();
    ViewController.to.tabController.animateTo(0);
  }

  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context!,
      builder: (context) => CupertinoAlertDialog(
        title: title,
        content: content,
        actions: [
          CupertinoDialogAction(
            onPressed: () => _send401Email,
            child: contactDeveloper,
          ),
          CupertinoDialogAction(
            onPressed: () => Get.back(),
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
            onPressed: () => _send401Email,
            child: contactDeveloper,
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: tryAgain,
          ),
        ],
      ),
    );
  }
}
