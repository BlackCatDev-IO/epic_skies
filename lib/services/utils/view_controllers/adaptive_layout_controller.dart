import 'package:epic_skies/models/adaptive_layout_model.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdaptiveLayoutController extends GetxController {
  static AdaptiveLayoutController get to => Get.find();

  late double appBarPadding, appBarHeight, settingsHeaderHeight;

  void setAppBarHeight({required bool hasNotch}) {
    if (hasNotch) {
      appBarHeight = 14;
      _setNotchPadding();
    } else {
      appBarHeight = 18;
      appBarPadding = 18.5;
      settingsHeaderHeight = 18;
    }

    final model = AdaptiveLayoutModel(
      appBarPadding: appBarPadding,
      appBarHeight: appBarHeight,
      settingsHeaderHeight: settingsHeaderHeight,
    );

    StorageController.to.storeAdaptiveLayoutValues(model.toMap());
  }

  void _setNotchPadding() {
    final screenHeight = MediaQuery.of(Get.context!).size.height;
    if (screenHeight >= 900) {
      appBarPadding = 19.5;
      settingsHeaderHeight = 19;
    } else {
      appBarPadding = 20.5;
      settingsHeaderHeight = 18;
    }
  }
}
