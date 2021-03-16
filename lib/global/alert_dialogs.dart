import 'dart:io';

import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//TODO: Button click to direct user to settings

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
        // title: Text('No Connection Fucko'),
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
