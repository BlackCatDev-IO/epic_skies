import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:objectbox/objectbox.dart';

import '../../utils/logging/app_debug_log.dart';

@Entity()
class AdaptiveLayoutModel {
  AdaptiveLayoutModel({
    this.id = 1,
    required this.appBarPadding,
    required this.appBarHeight,
    required this.settingsHeaderHeight,
  });

  @Id(assignable: true)
  int id;
  final double appBarPadding;
  final double appBarHeight;
  final double settingsHeaderHeight;
}

class AdaptiveLayoutController extends GetxController {
  AdaptiveLayoutController({required this.storage, required this.hasNotch});
  static AdaptiveLayoutController get to => Get.find();

  final StorageController storage;

  late double appBarPadding;
  late double appBarHeight;
  late double settingsHeaderHeight;

  final bool hasNotch;

  AdaptiveLayoutModel? modelFromStorage;
  @override
  void onInit() {
    setAdaptiveHeights();
    super.onInit();
    // modelFromStorage = storage.storedAdaptiveLayoutModel();
    // if (modelFromStorage != null) {
    //   appBarPadding = modelFromStorage!.appBarPadding;
    //   appBarHeight = modelFromStorage!.appBarHeight;
    //   settingsHeaderHeight = modelFromStorage!.settingsHeaderHeight;
    // }
  }

  Future<void> setAdaptiveHeights() async {
    if (hasNotch) {
      _setNotchPadding();
    } else {
      appBarHeight = 19;
      appBarPadding = 19.5;
      settingsHeaderHeight = 19;
    }

    final model = AdaptiveLayoutModel(
      appBarHeight: appBarHeight,
      appBarPadding: appBarPadding,
      settingsHeaderHeight: settingsHeaderHeight,
    );

    storage.storeAdaptiveLayout(data: model);
  }

  void _setNotchPadding() {
    final screenHeight =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
    AppDebug.log(
      'screen height: $screenHeight',
      name: 'AdaptiveLayoutController',
    );
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
      appBarPadding = 21;
      settingsHeaderHeight = 18;
    } else {
      appBarHeight = 14;
      appBarPadding = 20.5;
      settingsHeaderHeight = 18;
    }
  }
}
