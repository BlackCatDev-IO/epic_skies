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
    return await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('No Connection Fucko'),
        content: MyTextWidget(text: 'Please check your network settings'),
        actions: [
          CupertinoDialogAction(
            child: MyTextWidget(text: 'Go to settings'),
            onPressed: () {},
          )
        ],
      ),
    );
  } else {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('No Connection Fucko'),
        backgroundColor: Colors.white,
        content: MyTextWidget(text: 'Please check your network settings'),
        actions: [
          TextButton(
            child: Text('Go to settings'),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

Future<void> explainDynamicSwitch({@required BuildContext context}) async {
  if (Platform.isIOS) {
    return await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: MyTextWidget(text: dynamicMessage, color: Colors.black),
        actions: [
          CupertinoDialogAction(
            child: MyTextWidget(text: 'Got it!', color: Colors.black),
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),
    );
  } else {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // title: Text('No Connection Fucko'),
        backgroundColor: Colors.white,
        content: MyTextWidget(text: dynamicMessage, color: Colors.black),
        actions: [
          TextButton(
            child: MyTextWidget(text: 'Got it!', color: Colors.black),
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),
    );
  }
}
