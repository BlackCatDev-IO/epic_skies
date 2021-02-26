import 'package:flutter/material.dart';
import 'package:get/get.dart';

void bgImageUpdatedSnackbar() {
  final bar = GetBar(
    messageText: Text(
      'Background Image Updated',
      style: TextStyle(fontFamily: 'Roboto', color: Colors.white, fontSize: 15),
    ),
    duration: Duration(seconds: 3),
  );
  Get.showSnackbar(bar);
}

void dynamicUpdatedSnackbar() {
  final bar = GetBar(
    messageText: Text(
      'Background images will now be updated based on current weather',
      style: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontWeight: FontWeight.w200),
    ),
    duration: Duration(seconds: 5),
  );
  Get.showSnackbar(bar);
}
