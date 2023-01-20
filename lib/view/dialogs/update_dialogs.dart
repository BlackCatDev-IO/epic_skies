import 'dart:io';

import 'package:epic_skies/global/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateDialog {
  static void showChangeLogDialog(
    BuildContext context, {
    required String changeLog,
    required String appVersion,
  }) {
    final title = 'App updated to version $appVersion';
    const buttonText = 'Got it!';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text(title),
            content: Text(changeLog, style: iOSContentTextStyle),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Get.back(),
                child: const Text(buttonText),
              ),
            ],
          )
        : AlertDialog(
            title: Text(title),
            content: Text(changeLog),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text(buttonText),
              ),
            ],
          );
    showDialog(context: context, builder: (context) => dialog);
  }
}
