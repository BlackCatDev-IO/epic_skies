import 'package:epic_skies/view/dialogs/platform_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateDialog {
  static void showChangeLogDialog(
    BuildContext context, {
    required String changeLog,
    required String appVersion,
  }) {
    final title = 'App updated to version $appVersion';

    final actions = {
      'Got it!': () => Navigator.of(context).pop(),
    };

    Dialogs.showPlatformDialog(
      context,
      content: changeLog,
      dialogActions: actions,
      title: title,
    );
  }
}
