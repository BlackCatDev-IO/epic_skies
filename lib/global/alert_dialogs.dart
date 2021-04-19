import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:epic_skies/services/utils/location/search_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const dynamicMessage =
    'To turn this setting off, select an image from your device gallery or from the Epic Skies image gallery. Once you select an image, you can go back to the dynamic setting with this switch';

Future<void> showNoConnectionDialog({required BuildContext? context}) async {
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context!,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('No Network Connection'),
        content: const MyTextWidget(text: 'Please check your network settings'),
        actions: [
          CupertinoDialogAction(
            onPressed: () {},
            child: const MyTextWidget(text: 'Go to settings'),
          )
        ],
      ),
    );
  } else {
    return showDialog(
      context: context!,
      builder: (context) => AlertDialog(
        title: const Text('No Network Connection'),
        backgroundColor: Colors.white,
        content: const MyTextWidget(text: 'Please check your network settings'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Go to settings'),
          )
        ],
      ),
    );
  }
}

Future<void> showLocationTurnedOffDialog(
    {required BuildContext? context}) async {
  const content = Text(
      'Please turn on location to allow Epic Skies to fetch your local weather conditions');
  const title = Text('Location turned off');
  const goToSettings = Text('Go to location settings');
  const tryAgain = Text('Try Again');

  void retryLocation() {
    Get.back();
    WeatherRepository.to.fetchLocalWeatherData();
  }

  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context!,
      builder: (context) => CupertinoAlertDialog(
        title: title,
        content: content,
        actions: [
          CupertinoDialogAction(
            onPressed: () => AppSettings.openLocationSettings(),
            child: goToSettings,
          ),
          CupertinoDialogAction(
            onPressed: () => retryLocation(),
            child: tryAgain,
          ),
        ],
      ),
    );
  } else {
    return showDialog(
      context: context!,
      builder: (context) => AlertDialog(
        title: title,
        backgroundColor: Colors.white,
        content: content,
        actions: [
          TextButton(
            onPressed: () => AppSettings.openLocationSettings(),
            child: goToSettings,
          ),
          TextButton(
            onPressed: () => retryLocation(),
            child: tryAgain,
          ),
        ],
      ),
    );
  }
}

Future<void> explainDynamicSwitch({required BuildContext? context}) async {
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context!,
      builder: (context) => CupertinoAlertDialog(
        content: const MyTextWidget(text: dynamicMessage, color: Colors.black),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Get.back();
            },
            child: const MyTextWidget(text: 'Got it!', color: Colors.black),
          )
        ],
      ),
    );
  } else {
    return showDialog(
      context: context!,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[850],
        content: const MyTextWidget(
            text: dynamicMessage,
            fontFamily: 'Roboto',
            color: Colors.white70,
            fontWeight: FontWeight.w300,
            fontSize: 17),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const MyTextWidget(
                text: 'Got it!',
                fontFamily: 'Roboto',
                color: Colors.blueGrey,
                fontSize: 17),
          )
        ],
        elevation: 30,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}

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

Future<void> confirmSelectDeviceImage({
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
    color: Colors.blue,
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
