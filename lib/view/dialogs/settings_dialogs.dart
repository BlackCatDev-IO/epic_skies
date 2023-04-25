import 'package:epic_skies/view/dialogs/platform_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsDialogs {
  static void explainDynamicSwitch(BuildContext context) {
    const content =
        '''To turn this setting off, select an image from your device gallery or from the Epic Skies image gallery. Once you select an image, you can go back to the dynamic setting with this switch''';

    final actions = {
      'Got it!': () => Navigator.of(context).pop(),
    };

    Dialogs.showPlatformDialog(
      context,
      content: content,
      dialogActions: actions,
    );
  }

  static void confirmSelectDeviceImage(BuildContext context) {
    const content = 'Select image as Epic Skies background?';

    final actions = {
      'Select image': () => Navigator.of(context).pop(),
      'Go back': () => Navigator.of(context).pop(),
    };

    Dialogs.showPlatformDialog(
      context,
      content: content,
      dialogActions: actions,
    );
  }
}
