import 'dart:io';


import 'package:black_cat_lib/widgets/ios_widgets.dart';
import 'package:black_cat_lib/widgets/my_custom_widgets.dart';
import 'package:epic_skies/services/utils/location/location_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const dynamicMessage =
    'To turn this setting off, select an image from your device gallery or from the Epic Skies image gallery. Once you select an image, you can go back to the dynamic setting with this switch';

Future<void> explainDynamicSwitch({required BuildContext? context}) async {
  if (Platform.isIOS) {
    return showCupertinoDialog(
      barrierDismissible: true,
      context: context!,
      builder: (context) => CupertinoAlertDialog(
        content: const IOSDialogTextWidget(text: dynamicMessage),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Get.back();
            },
            child: const IOSDialogTextWidget(
                text: 'Got it!', fontColor: Colors.blue, fontSize: 19),
          )
        ],
      ),
    );
  } else {
    return showDialog(
      barrierDismissible: true,
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
            onPressed: () => LocationController.to.clearSearchHistory(),
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
            onPressed: () => LocationController.to.clearSearchHistory(),
            child: delete,
          ),
        ],
      ),
    );
  }
}
