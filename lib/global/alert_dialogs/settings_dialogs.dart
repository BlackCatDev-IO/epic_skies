import 'dart:io';

import 'package:black_cat_lib/widgets/ios_widgets.dart';
import 'package:epic_skies/view/widgets/general/buttons/dialog_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void explainDynamicSwitch() {
  const content =
      'To turn this setting off, select an image from your device gallery or from the Epic Skies image gallery. Once you select an image, you can go back to the dynamic setting with this switch';

  final dialog = Platform.isIOS
      ? CupertinoAlertDialog(
          content: const IOSDialogTextWidget(text: content, fontSize: 17),
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
            DialogButton(
              onPressed: () => Get.back(),
              child: const Text('Got it!'),
            ),
          ],
        );

  Get.dialog(dialog, barrierDismissible: true);
}

void confirmSelectDeviceImage()  {
  const content = 'Select image as Epic Skies background?';

  final dialog = Platform.isIOS
      ? CupertinoAlertDialog(
          content: const IOSDialogTextWidget(text: content, fontSize: 17),
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
            DialogButton(
              onPressed: () => Get.back(),
              child: const Text('Got it!'),
            ),
          ],
        );

  Get.dialog(dialog, barrierDismissible: true);
}
