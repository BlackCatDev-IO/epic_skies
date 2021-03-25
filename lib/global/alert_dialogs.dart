import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const dynamicMessage =
    'To turn this setting off, select an image from your device gallery or from the Epic Skies image gallery. Once you select an image, you can go back to the dynamic setting with this switch';

Future<void> showNoConnectionDialog({@required BuildContext context}) async {
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('No Connection Fucko'),
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
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('No Connection Fucko'),
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
    {@required BuildContext context}) async {
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
      context: context,
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
      context: context,
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

Future<void> explainDynamicSwitch({@required BuildContext context}) async {
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
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
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: const MyTextWidget(text: dynamicMessage, color: Colors.black),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const MyTextWidget(text: 'Got it!', color: Colors.black),
          )
        ],
      ),
    );
  }
}

Future<void> confirmDeleteSearch(
    {@required BuildContext context,
    @required SearchSuggestion suggestion}) async {
  final content =
      Text('Delete ${suggestion.description} from your search history?');
  const title = Text('Location turned off');
  const delete = Text('Delete');
  const goBack = Text('Go back');

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
        title: title,
        backgroundColor: Colors.white,
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
