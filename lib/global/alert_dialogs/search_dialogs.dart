import 'dart:io';
import 'package:black_cat_lib/widgets/ios_widgets.dart';
import 'package:epic_skies/services/utils/location/location_controller.dart';
import 'package:epic_skies/services/utils/location/search_controller.dart';
import 'package:epic_skies/view/widgets/general/buttons/dialog_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void confirmDeleteSearch({required SearchSuggestion suggestion}) {
  final content = 'Delete ${suggestion.description} from your search history?';

  const delete = 'Delete';
  const goBack = 'Go back';

  final dialog = Platform.isIOS
      ? CupertinoAlertDialog(
          content: IOSDialogTextWidget(text: content, fontSize: 17),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Get.back(),
              child: const Text(goBack),
            ),
            CupertinoDialogAction(
              onPressed: () =>
                  LocationController.to.deleteSelectedSearch(suggestion),
              child: const Text(delete, style: TextStyle(color: Colors.red)),
            ),
          ],
        )
      : AlertDialog(
          content: Text(content),
          actions: [
            DialogButton(
              onPressed: () => Get.back(),
              child: const Text(goBack),
            ),
            DialogButton(
              onPressed: () =>
                  LocationController.to.deleteSelectedSearch(suggestion),
              child: const Text(delete, style: TextStyle(color: Colors.red)),
            ),
          ],
        );

  Get.dialog(dialog, barrierDismissible: true);
}

void confirmClearSearchHistory() {
  const content = 'Delete your entire search history?';
  const delete = 'Delete';
  const goBack = 'Go back';

  final dialog = Platform.isIOS
      ? CupertinoAlertDialog(
          content: const IOSDialogTextWidget(text: content, fontSize: 17),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Get.back(),
              child: const Text(goBack),
            ),
            CupertinoDialogAction(
              onPressed: LocationController.to.clearSearchHistory,
              child: const Text(delete, style: TextStyle(color: Colors.red)),
            ),
          ],
        )
      : AlertDialog(
          content: const Text(content),
          actions: [
            DialogButton(
              onPressed: () => Get.back(),
              child: const Text(goBack),
            ),
            DialogButton(
              onPressed: LocationController.to.clearSearchHistory,
              child: const Text(delete, style: TextStyle(color: Colors.red)),
            ),
          ],
        );

  Get.dialog(dialog, barrierDismissible: true);
}

void selectSearchFromListDialog() {
  const content = 'Please select location from list';
  const goBack = 'Got it!';

  final dialog = Platform.isIOS
      ? CupertinoAlertDialog(
          content: const IOSDialogTextWidget(text: content, fontSize: 17),
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
            DialogButton(
              onPressed: () => Get.back(),
              child: const Text(goBack),
            ),
          ],
        );

  Get.dialog(dialog, barrierDismissible: true);
}
