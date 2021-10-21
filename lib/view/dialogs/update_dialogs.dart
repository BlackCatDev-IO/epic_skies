import 'dart:io';

import 'package:epic_skies/global/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateDialog {
  static void showChangeLogDialog({required String changeLog}) {
    const content = 'App is Updated';

    const buttonText = 'Got it!';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            content: Text(content, style: iOSContentTextStyle),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Get.back(),
                child: const Text(buttonText),
              ),
            ],
          )
        : AlertDialog(
            content: const Text(content),
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
