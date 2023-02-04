import 'dart:io';

import 'package:epic_skies/global/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsDialogs {
  static void explainDynamicSwitch(BuildContext context) {
    const content =
        'To turn this setting off, select an image from your device gallery or from the Epic Skies image gallery. Once you select an image, you can go back to the dynamic setting with this switch';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            content: Text(content, style: iOSContentTextStyle),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Got it!'),
              ),
            ],
          )
        : AlertDialog(
            content: const Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Got it!', style: dialogActionTextStyle),
              ),
            ],
          );

    showDialog(context: context, builder: (context) => dialog);
  }

  static void confirmSelectDeviceImage(BuildContext context) {
    const content = 'Select image as Epic Skies background?';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            content: Text(content, style: iOSContentTextStyle),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Select image'),
              ),
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Go back'),
              ),
            ],
          )
        : AlertDialog(
            content: const Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Select image', style: dialogActionTextStyle),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Go back', style: dialogActionTextStyle),
              ),
            ],
          );
    showDialog(context: context, builder: (context) => dialog);
  }
}
