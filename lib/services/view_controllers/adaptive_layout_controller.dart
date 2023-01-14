import 'package:flutter/material.dart';

import '../../utils/logging/app_debug_log.dart';

class AdaptiveLayout {
  AdaptiveLayout({required this.hasNotch});

  static late double appBarPadding;
  static late double appBarHeight;
  static late double settingsHeaderHeight;

  final bool hasNotch;

  Future<void> setAdaptiveHeights() async {
    if (hasNotch) {
      _setNotchPadding();
    } else {
      appBarHeight = 19;
      appBarPadding = 19.5;
      settingsHeaderHeight = 19;
    }
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
