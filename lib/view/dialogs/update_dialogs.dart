import 'dart:io';

import 'package:epic_skies/global/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateDialog {
  static void showChangeLogDialog({required String changeLog}) {
    const buttonText = 'Got it!';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            content: Text(changeLog, style: iOSContentTextStyle),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Get.back(),
                child: const Text(buttonText),
              ),
            ],
          )
        : AlertDialog(
            content: Text(changeLog),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text(buttonText),
              ),
            ],
          );

    Get.dialog(dialog, barrierDismissible: true);
  }
}
