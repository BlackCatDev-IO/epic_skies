import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global/app_theme.dart';

void explainDynamicSwitch() {
  const content =
      'To turn this setting off, select an image from your device gallery or from the Epic Skies image gallery. Once you select an image, you can go back to the dynamic setting with this switch';

  final dialog = Platform.isIOS
      ? CupertinoAlertDialog(
          content: Text(content, style: iOSContentTextStyle),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Get.back(),
              child: const Text('Got it!'),
            ),
          ],
        )
      : AlertDialog(
          content: const Text(content),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Got it!', style: dialogActionTextStyle),
            ),
          ],
        );

  Get.dialog(dialog, barrierDismissible: true);
}

void confirmSelectDeviceImage() {
  const content = 'Select image as Epic Skies background?';

  final dialog = Platform.isIOS
      ? CupertinoAlertDialog(
          content: Text(content, style: iOSContentTextStyle),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Get.back(),
              child: const Text('Select image'),
            ),
            CupertinoDialogAction(
              onPressed: () => Get.back(),
              child: const Text('Go back'),
            ),
          ],
        )
      : AlertDialog(
          content: const Text(content),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Select image', style: dialogActionTextStyle),
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Go back', style: dialogActionTextStyle),
            ),
          ],
        );

  Get.dialog(dialog, barrierDismissible: true);
}
