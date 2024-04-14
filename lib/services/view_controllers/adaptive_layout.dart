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

  late double _physicalWindowSize;
  late double _screenLogicalPixelHeight;
  late double _pixelRatio;

  late FlutterView _flutterView;

  final IphoneDeviceInfo _iphoneDeviceInfo;

  void _setAdaptiveHeights() {
    _flutterView = WidgetsBinding.instance.platformDispatcher.views.first;
    _physicalWindowSize = _flutterView.physicalSize.height;
    _screenLogicalPixelHeight =
        MediaQueryData.fromView(_flutterView).size.height;
    _pixelRatio = MediaQueryData.fromView(_flutterView).devicePixelRatio;

    hasNotchOrDynamicIsland = _iphoneDeviceInfo.hasNotchOrDynamicIsland();

    if (Platform.isAndroid) {
      return _setAndroidHeights();
    }

    final iPhoneHeights = _iphoneDeviceInfo.iOSAdaptiveHeights(
      screenLogicalPixelHeight: _screenLogicalPixelHeight,
      physicalWindowSize: _physicalWindowSize,
      pixelRatio: _pixelRatio,
    );

    appBarHeight = iPhoneHeights.appBarHeight;
    appBarPadding = iPhoneHeights.appBarPadding;

    _logAdaptiveLayout(
      'appBarHeight: $appBarHeight, appBarPadding: $appBarPadding',
    );
  }

  void _setAndroidHeights() {
    if (_screenLogicalPixelHeight <= 600) {
      appBarHeight = 150;
      appBarPadding = 180;
    }

    if (_screenLogicalPixelHeight > 600 && _screenLogicalPixelHeight <= 800) {
      appBarHeight = 150;
      appBarPadding = 180;
    }
  }

  void _logAdaptiveLayout(String message) {
    AppDebug.log(
      message,
      name: 'AdaptiveLayoutController',
    );
  }
}
