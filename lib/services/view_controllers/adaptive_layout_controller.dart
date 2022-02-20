import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdaptiveLayoutController extends GetxController {
  static AdaptiveLayoutController get to => Get.find();

  late double appBarPadding, appBarHeight, settingsHeaderHeight;

  Future<void> setAdaptiveHeights({
    required BuildContext context,
    required bool hasNotch,
  }) async {
    if (hasNotch) {
      _setNotchPadding(context: context);
    } else {
      appBarHeight = 19;
      appBarPadding = 19.5;
      settingsHeaderHeight = 19;
    }
  }

  void _setNotchPadding({required BuildContext context}) {
    final screenHeight = MediaQuery.of(context).size.height;
    log('screen height: $screenHeight');
    appBarHeight = 14;
    if (screenHeight >= 897) {
      appBarHeight = 14;
      appBarPadding = 19.5;
      settingsHeaderHeight = 19;
    } else if (screenHeight >= 870 && screenHeight <= 896) {
      appBarHeight = 15;
      appBarPadding = 20.5;
      settingsHeaderHeight = 19;
    } else if (screenHeight >= 800 && screenHeight <= 869) {
      appBarHeight = 14.5;
      appBarPadding = 20.5;
      settingsHeaderHeight = 18;
    } else {
      appBarHeight = 14;
      appBarPadding = 20.5;
      settingsHeaderHeight = 18;
    }
  }
}
