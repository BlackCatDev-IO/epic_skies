import 'dart:developer';

import 'package:epic_skies/repositories/system_info_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class IphoneDeviceInfo {
  static const iPhone15ProMaxScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 15 Pro Max',
    modelCode: 'iPhone16,2',
    screenHeight: 2796,
    logicalPixelHeight: 932,
    pixelRatio: 3,
    hasNotch: false,
    hasDynamicIsland: true,
  );

  static const iPhone15PlusScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 15 Plus',
    modelCode: 'iPhone15,5',
    screenHeight: 2796,
    screenWidth: 430,
    logicalPixelHeight: 932,
    pixelRatio: 3,
    hasNotch: false,
    hasDynamicIsland: true,
  );

  static const iPhone15ProScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 15 Pro',
    modelCode: 'iPhone16,1',
    screenHeight: 2556,
    logicalPixelHeight: 852,
    screenWidth: 393,
    pixelRatio: 3,
    hasNotch: false,
    hasDynamicIsland: true,
  );

  static const iPhone15ScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 15',
    modelCode: 'iPhone15,4',
    screenHeight: 2556,
    screenWidth: 393,
    logicalPixelHeight: 852,
    pixelRatio: 3,
    hasNotch: false,
    hasDynamicIsland: true,
  );

  static const iPhone14ProMaxScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 14 Pro Max',
    modelCode: 'iPhone15,3',
    screenHeight: 2796,
    logicalPixelHeight: 932,
    pixelRatio: 3,
    hasNotch: false,
    hasDynamicIsland: true,
  );

  static const iPhone14ProScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 14 Pro',
    modelCode: 'iPhone15,2',
    screenHeight: 2556,
    logicalPixelHeight: 852,
    pixelRatio: 3,
    hasNotch: false,
    hasDynamicIsland: true,
  );

  static const iPhone14PlusScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 14 Plus',
    modelCode: 'iPhone14,8',
    screenHeight: 2778,
    logicalPixelHeight: 926,
    pixelRatio: 3,
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhone14ScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 14',
    modelCode: 'iPhone14,7',
    screenHeight: 2532,
    logicalPixelHeight: 844,
    pixelRatio: 3,
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhone13MiniScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 13 Mini',
    modelCode: 'iPhone14,4',
    screenHeight: 2340,
    logicalPixelHeight: 812,
    pixelRatio: 3,
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhone13ScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 13',
    modelCode: 'iPhone14,5',
    screenHeight: 2532,
    logicalPixelHeight: 844,
    pixelRatio: 3,
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhone13ProScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 13 Pro',
    modelCode: 'iPhone14,2',
    screenHeight: 2532,
    screenWidth: 390,
    logicalPixelHeight: 844,
    pixelRatio: 3,
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhone13ProMaxScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 13 Pro Max',
    modelCode: 'iPhone14,3',
    screenHeight: 2778,
    logicalPixelHeight: 926,
    pixelRatio: 3,
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhoneSeFirstGenScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone SE 1st Gen',
    modelCode: 'iPhone3,1',
    screenHeight: 1136,
    logicalPixelHeight: 1136,
    pixelRatio: 2,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhoneSecondGenScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 6',
    modelCode: 'iPhone5,1',
    screenHeight: 1334,
    logicalPixelHeight: 667,
    pixelRatio: 2,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone7ScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 7',
    modelCode: 'iPhone9,1',
    screenHeight: 1334,
    logicalPixelHeight: 667,
    pixelRatio: 2,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone8ScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 8',
    modelCode: 'iPhone10,1',
    screenHeight: 1334,
    logicalPixelHeight: 667,
    pixelRatio: 2,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone7PlusScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 7 Plus',
    modelCode: 'iPhone9,2',
    screenHeight: 1920,
    logicalPixelHeight: 736,
    pixelRatio: 3,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone8PlusScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 8 Plus',
    modelCode: 'iPhone10,2',
    screenHeight: 1920,
    logicalPixelHeight: 736,
    pixelRatio: 3,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhoneXScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone X',
    modelCode: 'iPhone10,3',
    screenHeight: 2436,
    screenWidth: 375,
    logicalPixelHeight: 812,
    pixelRatio: 3,
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhoneXSScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone XS',
    modelCode: 'iPhone11,2',
    screenHeight: 2436,
    logicalPixelHeight: 812,
    pixelRatio: 3,
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhoneXRScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone XR',
    modelCode: 'iPhone11,8',
    screenHeight: 1792,
    logicalPixelHeight: 896,
    pixelRatio: 2,
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhoneXSMaxScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone XS Max',
    modelCode: 'iPhone11,4',
    screenHeight: 2688,
    logicalPixelHeight: 896,
    pixelRatio: 3,
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhone11ScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 11',
    modelCode: 'iPhone12,1',
    screenHeight: 1792,
    logicalPixelHeight: 896,
    pixelRatio: 2,
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhone11ProScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 11 Pro',
    modelCode: 'iPhone12,3',
    screenHeight: 2436,
    logicalPixelHeight: 812,
    pixelRatio: 3,
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhone11ProMaxScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 11 Pro Max',
    modelCode: 'iPhone12,5',
    screenHeight: 2688,
    logicalPixelHeight: 896,
    pixelRatio: 3,
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhone12MiniScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 12 Mini',
    modelCode: 'iPhone13,1',
    screenHeight: 2340,
    logicalPixelHeight: 812,
    pixelRatio: 3,
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhone12ScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 12',
    modelCode: 'iPhone13,2',
    screenHeight: 2532,
    logicalPixelHeight: 844,
    pixelRatio: 3,
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhone12ProScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 12 Pro',
    modelCode: 'iPhone13,3',
    screenHeight: 2532,
    logicalPixelHeight: 844,
    pixelRatio: 3,
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhone12ProMaxScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 12 Pro Max',
    modelCode: 'iPhone13,4',
    screenHeight: 2778,
    logicalPixelHeight: 926,
    pixelRatio: 3,
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhone6sPlusScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 6s Plus',
    modelCode: 'iPhone8,2',
    screenHeight: 1334,
    screenWidth: 414,
    logicalPixelHeight: 736,
    pixelRatio: 3,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone6sScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 6s',
    modelCode: 'iPhone8,1',
    screenHeight: 1334,
    screenWidth: 375,
    logicalPixelHeight: 667,
    pixelRatio: 2,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone6PlusScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 6 Plus',
    modelCode: 'iPhone7,1',
    screenHeight: 1920,
    screenWidth: 414,
    logicalPixelHeight: 736,
    pixelRatio: 3,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone6ScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 6',
    modelCode: 'iPhone7,2',
    screenHeight: 1334,
    screenWidth: 375,
    logicalPixelHeight: 667,
    pixelRatio: 2,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone5sScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 5',
    modelCode: 'iPhone6,1',
    screenHeight: 1136,
    screenWidth: 320,
    logicalPixelHeight: 568,
    pixelRatio: 2,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone5cScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 5',
    modelCode: 'iPhone5,3',
    screenHeight: 1136,
    screenWidth: 320,
    logicalPixelHeight: 568,
    pixelRatio: 2,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone5ScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 5',
    modelCode: 'iPhone5,1',
    screenHeight: 1136,
    screenWidth: 320,
    logicalPixelHeight: 568,
    pixelRatio: 2,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone4sScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 4',
    modelCode: 'iPhone4,1',
    screenHeight: 480,
    screenWidth: 320,
    logicalPixelHeight: 480,
    pixelRatio: 2,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone4ScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 4',
    modelCode: 'iPhone3,1',
    screenHeight: 480,
    screenWidth: 320,
    logicalPixelHeight: 480,
    pixelRatio: 2,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone3gSScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 3',
    modelCode: 'iPhone1,2',
    screenHeight: 480,
    logicalPixelHeight: 480,
    pixelRatio: 1,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone3gScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 3',
    modelCode: 'iPhone1,2',
    screenHeight: 480,
    logicalPixelHeight: 480,
    pixelRatio: 1,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone1stGenScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone',
    modelCode: 'iPhone1,1',
    screenHeight: 480,
    screenWidth: 320,
    logicalPixelHeight: 480,
    pixelRatio: 1,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  final iPhoneCodeToModelMap = <String, IOSScreenInfoModel>{
    'iPhone1,1': iPhone1stGenScreenModel,
    'iPhone1,2': iPhone3gScreenModel,
    'iPhone2,1': iPhone3gSScreenModel,
    'iPhone3,1': iPhone4ScreenModel,
    'iPhone3,2': iPhone4ScreenModel,
    'iPhone3,3': iPhone4ScreenModel,
    'iPhone4,1': iPhone4sScreenModel,
    'iPhone5,1': iPhone5ScreenModel,
    'iPhone5,2': iPhone5ScreenModel,
    'iPhone5,3': iPhone5cScreenModel,
    'iPhone5,4': iPhone5cScreenModel,
    'iPhone6,1': iPhone5sScreenModel,
    'iPhone6,2': iPhone5sScreenModel,
    'iPhone7,2': iPhone6ScreenModel,
    'iPhone7,1': iPhone6PlusScreenModel,
    'iPhone8,1': iPhone6sScreenModel,
    'iPhone8,2': iPhone6sPlusScreenModel,
    // 'iPhone8,4': 'iPhone SE (GSM)',
    // 'iPhone9,1': 'iPhone 7',
    'iPhone9,2': iPhone7PlusScreenModel,
    // 'iPhone9,3': 'iPhone 7',
    // 'iPhone9,4': 'iPhone 7 Plus',
    // 'iPhone10,1': 'iPhone 8',
    // 'iPhone10,3': 'iPhone X Global',
    // 'iPhone10,4': 'iPhone 8',
    // 'iPhone10,5': 'iPhone 8 Plus',
    'iPhone10,2': iPhone8PlusScreenModel,
    'iPhone10,6': iPhoneXScreenModel,
    'iPhone11,2': iPhoneXSScreenModel,
    'iPhone11,4': iPhoneXSMaxScreenModel,
    'iPhone11,6': iPhoneXSMaxScreenModel,
    'iPhone11,8': iPhoneXRScreenModel,
    'iPhone12,1': iPhone11ScreenModel,
    'iPhone12,3': iPhone11ProScreenModel,
    'iPhone12,5': iPhone11ProMaxScreenModel,
    'iPhone12,8': iPhoneSecondGenScreenModel,
    'iPhone13,1': iPhone12MiniScreenModel,
    'iPhone13,2': iPhone12ScreenModel,
    'iPhone13,3': iPhone12ProScreenModel,
    'iPhone13,4': iPhone12ProMaxScreenModel,
    'iPhone14,4': iPhone13MiniScreenModel,
    'iPhone14,5': iPhone13ScreenModel,
    'iPhone14,2': iPhone13ProScreenModel,
    'iPhone14,3': iPhone13ProMaxScreenModel,
    'iPhone14,7': iPhone14ScreenModel,
    'iPhone14,8': iPhone14PlusScreenModel,
    'iPhone15,2': iPhone14ProScreenModel,
    'iPhone15,3': iPhone14ProMaxScreenModel,
    'iPhone15,4': iPhone15ScreenModel,
    'iPhone15,5': iPhone15PlusScreenModel,
    'iPhone16,1': iPhone15ProScreenModel,
    'iPhone16,2': iPhone15ProMaxScreenModel,
  };

  bool hasNotchOrDynamicIsland() {
    final flutterView = WidgetsBinding.instance.platformDispatcher.views.first;

    final screenLogicalPixelHeight =
        MediaQueryData.fromView(flutterView).size.height;

    final screenLogicalPixelWidth =
        MediaQueryData.fromView(flutterView).size.width;

    final pixelRatio = MediaQueryData.fromView(flutterView).devicePixelRatio;

    final systemInfo = GetIt.I<SystemInfoRepository>();

    final hasNotchOrDynamicIsland = iPhoneCodeToModelMap.values
        .where((model) => model.hasNotch || model.hasDynamicIsland)
        .any((model) => model.modelCode == systemInfo.iOsModelCode);

    log(
      '''
hasNotchOrIsland: $hasNotchOrDynamicIsland
logicalScreenheight: $screenLogicalPixelHeight 
screenHeight: 
screen width: $screenLogicalPixelWidth
pixelRatio: $pixelRatio
''',
    );

    return hasNotchOrDynamicIsland;
  }

  ({double appBarHeight, double appBarPadding}) iOSAdaptiveHeights({
    required double screenLogicalPixelHeight,
    required double physicalWindowSize,
    required double pixelRatio,
  }) {
    final modelCode = GetIt.I<SystemInfoRepository>().iOsModelCode;

    final iOSMatchByName = iPhoneCodeToModelMap[modelCode];

    log('iOS model: $iOSMatchByName');

    final iPhonesWithNotchOrDynamicIsland = iPhoneCodeToModelMap.values
        .where(
          (iPhone) => iPhone.hasNotch || iPhone.hasDynamicIsland,
        )
        .toList();

    if (iPhonesWithNotchOrDynamicIsland.contains(iOSMatchByName)) {
      switch (iOSMatchByName) {
        case iPhoneXScreenModel:
        case iPhoneXSScreenModel:
          return (appBarHeight: 133, appBarPadding: 185);
        case iPhoneXSMaxScreenModel:
          return (appBarHeight: 133, appBarPadding: 178);
        case iPhone11ScreenModel:
          return (appBarHeight: 133, appBarPadding: 183);
        case iPhone11ProScreenModel:
          return (appBarHeight: 130, appBarPadding: 182);
        case iPhone12MiniScreenModel:
        case iPhone13MiniScreenModel:
          return (appBarHeight: 130, appBarPadding: 190);
        case iPhone11ProMaxScreenModel:
          return (appBarHeight: 130, appBarPadding: 175);
        case iPhone12ProMaxScreenModel:
          return (appBarHeight: 130, appBarPadding: 177);
        case iPhone12ScreenModel:
        case iPhone12ProScreenModel:
        case iPhone14ScreenModel:
          return (appBarHeight: 130, appBarPadding: 182);
        case iPhone13ScreenModel:
        case iPhone13ProScreenModel:
          return (appBarHeight: 130, appBarPadding: 182);
        case iPhone13ProMaxScreenModel:
        case iPhone14PlusScreenModel:
          return (appBarHeight: 130, appBarPadding: 178);
        case iPhone14ProMaxScreenModel:
        case iPhone15ProMaxScreenModel:
          return (appBarHeight: 125, appBarPadding: 185);
        case iPhone14ProScreenModel:
          return (appBarHeight: 125, appBarPadding: 192);
        case iPhone15ScreenModel:
        case iPhone15ProScreenModel:
          return (appBarHeight: 125, appBarPadding: 192);
        case iPhone15PlusScreenModel:
          return (appBarHeight: 130, appBarPadding: 190);
        default:
          return (appBarHeight: 130, appBarPadding: 190);
      }
    }
    return (appBarHeight: 130, appBarPadding: 190);
  }
}

class IOSScreenInfoModel {
  const IOSScreenInfoModel({
    required this.modelName,
    required this.modelCode,
    required this.screenHeight,
    required this.logicalPixelHeight,
    required this.hasNotch,
    required this.hasDynamicIsland,
    required this.pixelRatio,
    this.screenWidth = 0,
  });

  final String modelName;
  final String modelCode;
  final int screenHeight;
  final int screenWidth;
  final int logicalPixelHeight;
  final double pixelRatio;
  final bool hasNotch;
  final bool hasDynamicIsland;

  @override
  String toString() {
    return '''
modelName: $modelName
modelCode: $modelCode
screenHeight: $screenHeight
logicalPixelHeight: $logicalPixelHeight
pixelRatio: $pixelRatio
hasNotch: $hasNotch
hasDynamicIsland: $hasDynamicIsland
''';
  }
}
