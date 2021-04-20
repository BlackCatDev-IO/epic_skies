import 'dart:io';
import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:black_cat_lib/widgets/ios_widgets.dart';
import 'package:epic_skies/services/utils/location/search_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> confirmDeleteSearch(
    {required BuildContext context,
    required SearchSuggestion suggestion}) async {
  final content = MyTextWidget(
      text: 'Delete ${suggestion.description} from your search history?',
      fontFamily: 'Roboto',
      color: Colors.white70,
      fontWeight: FontWeight.w300,
      fontSize: 17);

  const delete = MyTextWidget(text: 'Delete', color: Colors.blue, fontSize: 17);
  const goBack =
      MyTextWidget(text: 'Go back', color: Colors.blue, fontSize: 17);

  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        content: content,
        actions: [
          CupertinoDialogAction(
            onPressed: () => Get.back(),
            child: goBack,
          ),
          CupertinoDialogAction(
            onPressed: () =>
                SearchController.to.deleteSelectedSearch(suggestion),
            child: delete,
          ),
        ],
      ),
    );
  } else {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[850],
        content: content,
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: goBack,
          ),
          TextButton(
            onPressed: () =>
                SearchController.to.deleteSelectedSearch(suggestion),
            child: delete,
          ),
        ],
      ),
    );
  }
}

Future<void> confirmClearSearchHistory({
  required BuildContext context,
}) async {
  const content = MyTextWidget(
      text: 'Delete your entire search history?',
      fontFamily: 'Roboto',
      color: Colors.white70,
      fontWeight: FontWeight.w300,
      fontSize: 17);

  const delete = MyTextWidget(
    text: 'Delete',
    color: Colors.red,
    fontSize: 17,
    fontFamily: 'Roboto',
  );
  const goBack = MyTextWidget(
    text: 'Go back',
    color: Colors.blue,
    fontSize: 17,
    fontFamily: 'Roboto',
  );

  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        content: content,
        actions: [
          CupertinoDialogAction(
            onPressed: () => Get.back(),
            child: goBack,
          ),
          CupertinoDialogAction(
            onPressed: () => SearchController.to.clearSearchHistory(),
            child: delete,
          ),
        ],
      ),
    );
  } else {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[850],
        content: content,
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: goBack,
          ),
          TextButton(
            onPressed: () => SearchController.to.clearSearchHistory(),
            child: delete,
          ),
        ],
      ),
    );
  }
}

Future<void> selectSearchFromListDialog({
  required BuildContext context,
}) async {
  const textContent = 'Please search location from list';
  const content = MyTextWidget(
      text: 'Please search location from list',
      fontFamily: 'Roboto',
      color: Colors.white70,
      fontWeight: FontWeight.w300,
      fontSize: 17);

  const goBack = MyTextWidget(
    text: 'Got it!',
    color: Colors.blue,
    fontSize: 17,
    fontFamily: 'Roboto',
  );

  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        content: const IOSDialogTextWidget(text: textContent),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Get.back(),
            child: const IOSDialogTextWidget(
                text: 'Got it!', fontColor: Colors.blue, fontSize: 19),
          ),
        ],
      ),
    );
  } else {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[850],
        content: content,
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: goBack,
          ),
        ],
      ),
    );
  }
}
