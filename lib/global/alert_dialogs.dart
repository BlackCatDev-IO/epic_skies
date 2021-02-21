import 'dart:io';

import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//TODO: Button click to direct user to settings

Future<void> showNoConnectionDialog({@required BuildContext context}) async {
  if (Platform.isIOS) {
    return await showCupertinoDialog(
      context: context,
      builder: (context) => AlertDialog(
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
        content: MyTextWidget(
            text: 'Please check your network settings'),
        actions: [
          FlatButton(
            child: Text('Go to settings'),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
