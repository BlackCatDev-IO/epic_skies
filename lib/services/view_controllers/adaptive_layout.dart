import 'dart:io';
import 'dart:ui';

import 'package:epic_skies/services/view_controllers/iphone_device_info.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter/material.dart';

class AdaptiveLayout {
  AdaptiveLayout({IphoneDeviceInfo? iphoneDeviceInfo})
      : _iphoneDeviceInfo = iphoneDeviceInfo ?? IphoneDeviceInfo() {
    _setAdaptiveHeights();
  }

  double appBarPadding = 195;
  double appBarHeight = 150;

  bool hasNotchOrDynamicIsland = false;

  late double _screenLogicalPixelHeight;
  late double _pixelRatio;

  late FlutterView _flutterView;

  final IphoneDeviceInfo _iphoneDeviceInfo;

  void _setAdaptiveHeights() {
    _flutterView = WidgetsBinding.instance.platformDispatcher.views.first;
    _screenLogicalPixelHeight =
        MediaQueryData.fromView(_flutterView).size.height;

    _pixelRatio = MediaQueryData.fromView(_flutterView).devicePixelRatio;

    hasNotchOrDynamicIsland = _iphoneDeviceInfo.hasNotchOrDynamicIsland();

    var screenHeightAppBarPortion = Platform.isIOS ? 6.5 : 6.0;

    if (_screenLogicalPixelHeight >= 850 && Platform.isIOS) {
      screenHeightAppBarPortion = 7.0;
    }

    if ((!hasNotchOrDynamicIsland || Platform.isAndroid) &&
        _screenLogicalPixelHeight <= 750) {
      screenHeightAppBarPortion = 5.0;
    }
 
    appBarHeight = _screenLogicalPixelHeight / screenHeightAppBarPortion;

    _logAdaptiveLayout(
      '''
appBarHeight: $appBarHeight 
_screenLogicalPixelHeight: $_screenLogicalPixelHeight
pixelRatio: $_pixelRatio
screenHeightAppBarPortion: $screenHeightAppBarPortion
''',
    );
  }

  void setAppBarPadding(double appBarMaxHeight) {
    appBarPadding = appBarMaxHeight + 5;
  }

  void _logAdaptiveLayout(String message) {
    AppDebug.log(
      message,
      name: 'AdaptiveLayout',
    );
  }
}
