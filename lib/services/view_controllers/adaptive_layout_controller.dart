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
      appBarHeight = 14;
      _setNotchPadding(context: context);
    } else {
      appBarHeight = 18;
      appBarPadding = 18.5;
      settingsHeaderHeight = 18;
    }
  }

  void _setNotchPadding({required BuildContext context}) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight >= 900) {
      appBarPadding = 19.5;
      settingsHeaderHeight = 19;
    } else {
      appBarPadding = 20.5;
      settingsHeaderHeight = 18;
    }
  }
}
