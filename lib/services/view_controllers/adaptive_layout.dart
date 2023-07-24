import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter/material.dart';
import 'package:iphone_has_notch/iphone_has_notch.dart';

class AdaptiveLayout {
  AdaptiveLayout({bool? hasNotch})
      : _hasNotch = hasNotch ?? IphoneHasNotch.hasNotch;

  late double appBarPadding;
  late double appBarHeight;
  late double settingsHeaderHeight;

  final bool _hasNotch;

  void setAdaptiveHeights() {
    if (_hasNotch) {
      _setNotchPadding();
    } else {
      appBarHeight = 150;
      appBarPadding = 155;
      settingsHeaderHeight = 19;
    }
  }

  void _setNotchPadding() {
    final screenHeight = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.first,
    ).size.height;

    AppDebug.log(
      'screen height: $screenHeight',
      name: 'AdaptiveLayoutController',
    );

    appBarHeight = 14;
    if (screenHeight >= 897) {
      appBarHeight = 150;
      appBarPadding = 155;
      settingsHeaderHeight = 19;
    } else if (screenHeight >= 870 && screenHeight <= 896) {
      appBarHeight = 160;
      appBarPadding = 165;
      settingsHeaderHeight = 19;
    } else if (screenHeight >= 800 && screenHeight <= 869) {
      appBarHeight = 150;
      appBarPadding = 220;
      settingsHeaderHeight = 18;
    } else {
      appBarHeight = 150;
      appBarPadding = 165;
      settingsHeaderHeight = 18;
    }
  }
}
