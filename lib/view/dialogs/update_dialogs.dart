import 'dart:io';

import 'package:epic_skies/global/app_theme.dart';
import 'package:epic_skies/view/dialogs/platform_dialog.dart';
import 'package:flutter/material.dart';

class UpdateDialog {
  static void showChangeLogDialog(
    BuildContext context, {
    required List<String> changeLog,
    required String appVersion,
  }) {
    final title = "App updated to version $appVersion \n\nWhat's new:";

    final actions = {
      'Got it!': () => Navigator.of(context).pop(),
    };

    Dialogs.showPlatformDialog(
      context,
      stringContent: '',
      dialogActions: actions,
      title: title,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: changeLog
            .map(
              (appChange) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    const Icon(
                      Icons.circle,
                      size: 10,
                      color: Color.fromARGB(168, 255, 255, 255),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        appChange,
                        style: Platform.isIOS ? iOSContentTextStyle : null,
                        textAlign: TextAlign.left,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
