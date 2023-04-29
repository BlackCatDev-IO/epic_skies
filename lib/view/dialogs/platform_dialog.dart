import 'dart:io';

import 'package:epic_skies/global/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static void showPlatformDialog(
    BuildContext context, {
    required String content,
    required Map<String, void Function()> dialogActions,
    String? title,
  }) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkModeEnabled = brightness == Brightness.dark;

    final actions = _getActionsFromMap(dialogActions);
      
    final titleWidget = title != null
        ? Text(
            title,
            style: const TextStyle(fontSize: 22),
          )
        : null;

    if (Platform.isIOS) {
      showCupertinoDialog<void>(
        context: context,
        builder: (context) {
          return Theme(
            data: isDarkModeEnabled ? ThemeData.dark() : ThemeData.light(),
            child: CupertinoAlertDialog(
              title: titleWidget,
              content: Text(content, style: iOSContentTextStyle),
              actions: actions,
            ),
          );
        },
        barrierDismissible: true,
      );
    } else {
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: titleWidget,
          content: Text(
            content,
          ),
          actions: actions,
        ),
      );
    }
  }

  static List<Widget> _getActionsFromMap(Map<String, void Function()> actions) {
    return actions.entries
        .map(
          (e) => Platform.isIOS
              ? CupertinoDialogAction(
                  onPressed: e.value,
                  child: Text(
                    e.key,
                    style: _getActionButtonTextStyle(e.key) ??
                        const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                  ),
                )
              : TextButton(
                  onPressed: e.value,
                  child: Text(
                    e.key,
                    style: dialogActionTextStyle.copyWith(
                      color: _getActionButtonTextStyle(e.key)?.color,
                    ),
                  ),
                ),
        )
        .toList();
  }

  static TextStyle? _getActionButtonTextStyle(String action) {
    switch (action) {
      case 'Continue with ads':
      case 'No thanks':
      case 'Delete':
        return const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        );
    }
    return null;
  }
}
