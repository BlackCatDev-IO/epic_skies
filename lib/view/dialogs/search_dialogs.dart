import 'dart:io';

import 'package:epic_skies/features/location/remote_location/controllers/remote_location_controller.dart';
import 'package:epic_skies/features/location/remote_location/models/search_suggestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global/app_theme.dart';

class SearchDialogs {
  static void confirmDeleteSearch({required SearchSuggestion suggestion}) {
    final content =
        'Delete ${suggestion.description} from your search history?';
    const delete = 'Delete';
    const goBack = 'Go back';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            content: Text(content, style: iOSContentTextStyle),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Get.back(),
                child: const Text(goBack),
              ),
              CupertinoDialogAction(
                onPressed: () => RemoteLocationController.to
                    .deleteSelectedSearch(suggestion),
                isDestructiveAction: true,
                child: const Text(delete),
              ),
            ],
          )
        : AlertDialog(
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text(goBack, style: dialogActionTextStyle),
              ),
              TextButton(
                onPressed: () => RemoteLocationController.to
                    .deleteSelectedSearch(suggestion),
                child: Text(
                  delete,
                  style: dialogActionTextStyle.copyWith(color: Colors.red),
                ),
              ),
            ],
          );

    Get.dialog(dialog, barrierDismissible: true);
  }

  static void confirmClearSearchHistory() {
    const content = 'Delete your entire search history?';
    const delete = 'Delete';
    const goBack = 'Go back';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            content: Text(
              content,
              style: iOSContentTextStyle,
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Get.back(),
                child: const Text(goBack),
              ),
              CupertinoDialogAction(
                onPressed: RemoteLocationController.to.clearSearchHistory,
                isDestructiveAction: true,
                child: const Text(delete),
              ),
            ],
          )
        : AlertDialog(
            content: const Text(content),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const  Text(goBack, style: dialogActionTextStyle),
              ),
              TextButton(
                onPressed: RemoteLocationController.to.clearSearchHistory,
                child: Text(
                  delete,
                  style: dialogActionTextStyle.copyWith(color: Colors.red),
                ),
              ),
            ],
          );

    Get.dialog(dialog, barrierDismissible: true);
  }

  static void selectSearchFromListDialog() {
    const content = 'Please select location from list';
    const goBack = 'Got it!';

    final dialog = Platform.isIOS
        ? CupertinoAlertDialog(
            content: Text(content, style: iOSContentTextStyle),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Get.back(),
                child: const Text(goBack),
              ),
            ],
          )
        : AlertDialog(
            content: const Text(content),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const  Text(goBack, style: dialogActionTextStyle),
              ),
            ],
          );

    Get.dialog(dialog, barrierDismissible: true);
  }
}
