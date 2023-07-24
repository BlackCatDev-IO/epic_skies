import 'dart:io';

import 'package:epic_skies/extensions/widget_extensions.dart';
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
    final actions = _getActionsFromMap(dialogActions);

    final titleWidget = title != null
        ? Text(
            title,
            style: const TextStyle(fontSize: 22),
          )
        : null;

    if (_dialogShowing(context)) {
      Navigator.of(context).pop();
    }

    if (Platform.isIOS) {
      final titleWidget = title == null
          ? null
          : Text(
              title,
              style: const TextStyle(fontSize: 22),
            ).paddingSymmetric(vertical: 5);

      showCupertinoDialog<void>(
        context: context,
        builder: (context) {
          return Theme(
            data: ThemeData.dark(),
            child: CupertinoAlertDialog(
              title: titleWidget,
              content: Text(content, style: iOSContentTextStyle)
                  .paddingSymmetric(vertical: 10),
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
          backgroundColor: Colors.grey[900],
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
                  ).paddingSymmetric(vertical: 7.5),
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

  static bool _dialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;
}
