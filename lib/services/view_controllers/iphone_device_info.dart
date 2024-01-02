import 'dart:developer';

import 'package:epic_skies/repositories/system_info_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class IphoneDeviceInfo {
  static const iPhone3ScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 3',
    modelCode: 'iPhone1,1',
    screenHeight: 480,
    logicalPixelHeight: 480,
    pixelRatio: 1,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone4ScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 4',
    modelCode: 'iPhone1,2',
    screenHeight: 960,
    logicalPixelHeight: 480,
    pixelRatio: 2,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone5ScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 5',
    modelCode: 'iPhone2,1',
    screenHeight: 1136,
    logicalPixelHeight: 568,
    pixelRatio: 2,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhoneSeFirstGenScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone SE 1st Gen',
    modelCode: 'iPhone3,1',
    screenHeight: 1136,
    logicalPixelHeight: 1136,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhoneSecondGenScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 6',
    modelCode: 'iPhone5,1',
    screenHeight: 1334,
    logicalPixelHeight: 667,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone6ScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 6',
    modelCode: 'iPhone7,2',
    screenHeight: 1334,
    logicalPixelHeight: 667,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone7ScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 7',
    modelCode: 'iPhone9,1',
    screenHeight: 1334,
    logicalPixelHeight: 667,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone8ScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 8',
    modelCode: 'iPhone10,1',
    screenHeight: 1334,
    logicalPixelHeight: 667,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone6PlusScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 6 Plus',
    modelCode: 'iPhone7,1',
    screenHeight: 1920,
    logicalPixelHeight: 736,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone7PlusScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 7 Plus',
    modelCode: 'iPhone9,2',
    screenHeight: 1920,
    logicalPixelHeight: 736,
    hasNotch: false,
    hasDynamicIsland: false,
  );

  static const iPhone8PlusScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 8 Plus',
    modelCode: 'iPhone10,2',
    screenHeight: 1920,
    logicalPixelHeight: 736,
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
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhoneXRScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone XR',
    modelCode: 'iPhone11,8',
    screenHeight: 1792,
    logicalPixelHeight: 896,
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
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhone12MiniScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 12 Mini',
    modelCode: 'iPhone13,1',
    screenHeight: 2340,
    logicalPixelHeight: 812,
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhone12ScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 12',
    modelCode: 'iPhone13,2',
    screenHeight: 2532,
    logicalPixelHeight: 844,
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

  static const iPhone14ScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 14',
    modelCode: 'iPhone14,7',
    screenHeight: 2532,
    logicalPixelHeight: 844,
    pixelRatio: 3,
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhone14PlusScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 14 Plus',
    modelCode: 'iPhone14,8',
    screenHeight: 2778,
    logicalPixelHeight: 926,
    hasNotch: true,
    hasDynamicIsland: false,
  );

  static const iPhone14ProScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 14 Pro',
    modelCode: 'iPhone15,2',
    screenHeight: 2556,
    logicalPixelHeight: 852,
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

  static const iPhone15ProScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 15 Pro',
    modelCode: 'iPhone16,1',
    screenHeight: 2556,
    logicalPixelHeight: 852,
    pixelRatio: 3,
    hasNotch: false,
    hasDynamicIsland: true,
  );

  static const iPhone15PlusScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 15 Pro',
    modelCode: 'iPhone16,1',
    screenHeight: 2796,
    logicalPixelHeight: 932,
    pixelRatio: 3,
    hasNotch: false,
    hasDynamicIsland: true,
  );

  static const iPhone15ProMaxScreenModel = IOSScreenInfoModel(
    modelName: 'iPhone 15 Pro Max',
    modelCode: 'iPhone16,2',
    screenHeight: 2796,
    logicalPixelHeight: 932,
    pixelRatio: 3,
    hasNotch: false,
    hasDynamicIsland: true,
  );

  final iPhoneModelList = [
    iPhone3ScreenModel,
    iPhone4ScreenModel,
    iPhone5ScreenModel,
    iPhoneSeFirstGenScreenModel,
    iPhoneSecondGenScreenModel,
    iPhone6ScreenModel,
    iPhone7ScreenModel,
    iPhone8ScreenModel,
    iPhone6PlusScreenModel,
    iPhone7PlusScreenModel,
    iPhone8PlusScreenModel,
    iPhoneXScreenModel,
    iPhoneXSScreenModel,
    iPhoneXRScreenModel,
    iPhoneXSMaxScreenModel,
    iPhone11ScreenModel,
    iPhone11ProScreenModel,
    iPhone11ProMaxScreenModel,
    iPhone12MiniScreenModel,
    iPhone12ScreenModel,
    iPhone12ProScreenModel,
    iPhone12ProMaxScreenModel,
    iPhone13MiniScreenModel,
    iPhone13ScreenModel,
    iPhone13ProScreenModel,
    iPhone13ProMaxScreenModel,
    iPhone14ScreenModel,
    iPhone14PlusScreenModel,
    iPhone14ProScreenModel,
    iPhone14ProMaxScreenModel,
    iPhone15ProScreenModel,
    iPhone15ProMaxScreenModel,
  ];

  final iPhoneCodeToModelMap = {
    'iPhone1,1': 'iPhone',
    'iPhone1,2': 'iPhone 3G',
    'iPhone2,1': 'iPhone 3GS',
    'iPhone3,1': 'iPhone 4',
    'iPhone3,2': 'iPhone 4 GSM Rev A',
    'iPhone3,3': 'iPhone 4 CDMA',
    'iPhone4,1': 'iPhone 4S',
    'iPhone5,1': 'iPhone 5 (GSM)',
    'iPhone5,2': 'iPhone 5 (GSM+CDMA)',
    'iPhone5,3': 'iPhone 5C (GSM)',
    'iPhone5,4': 'iPhone 5C (Global)',
    'iPhone6,1': 'iPhone 5S (GSM)',
    'iPhone6,2': 'iPhone 5S (Global)',
    'iPhone7,1': 'iPhone 6 Plus',
    'iPhone7,2': 'iPhone 6',
    'iPhone8,1': 'iPhone 6s',
    'iPhone8,2': 'iPhone 6s Plus',
    'iPhone8,4': 'iPhone SE (GSM)',
    'iPhone9,1': 'iPhone 7',
    'iPhone9,2': 'iPhone 7 Plus',
    'iPhone9,3': 'iPhone 7',
    'iPhone9,4': 'iPhone 7 Plus',
    'iPhone10,1': 'iPhone 8',
    'iPhone10,2': 'iPhone 8 Plus',
    'iPhone10,3': 'iPhone X Global',
    'iPhone10,4': 'iPhone 8',
    'iPhone10,5': 'iPhone 8 Plus',
    'iPhone10,6': 'iPhone X GSM',
    'iPhone11,2': 'iPhone XS',
    'iPhone11,4': 'iPhone XS Max',
    'iPhone11,6': 'iPhone XS Max Global',
    'iPhone11,8': 'iPhone XR',
    'iPhone12,1': 'iPhone 11',
    'iPhone12,3': 'iPhone 11 Pro',
    'iPhone12,5': 'iPhone 11 Pro Max',
    'iPhone12,8': 'iPhone SE 2nd Gen',
    'iPhone13,1': 'iPhone 12 Mini',
    'iPhone13,2': 'iPhone 12',
    'iPhone13,3': 'iPhone 12 Pro',
    'iPhone13,4': 'iPhone 12 Pro Max',
    'iPhone14,2': 'iPhone 13 Pro',
    'iPhone14,3': 'iPhone 13 Pro Max',
    'iPhone14,4': 'iPhone 13 Mini',
    'iPhone14,5': 'iPhone 13',
    'iPhone14,6': 'iPhone SE 3rd Gen',
    'iPhone14,7': 'iPhone 14',
    'iPhone14,8': 'iPhone 14 Plus',
    'iPhone15,2': 'iPhone 14 Pro',
    'iPhone15,3': 'iPhone 14 Pro Max',
    'iPhone15,4': 'iPhone 15',
    'iPhone15,5': 'iPhone 15 Plus',
    'iPhone16,1': 'iPhone 15 Pro',
    'iPhone16,2': 'iPhone 15 Pro Max',
  };

  bool hasNotchOrDynamicIsland() {
    final flutterView = WidgetsBinding.instance.platformDispatcher.views.first;

    final screenLogicalPixelHeight =
        MediaQueryData.fromView(flutterView).size.height;

    final screenLogicalPixelWidth =
        MediaQueryData.fromView(flutterView).size.width;

    final pixelRatio = MediaQueryData.fromView(flutterView).devicePixelRatio;

    log(
      '''
hasNotchOrIsland: $hasNotchOrDynamicIsland
logicalScreenheight: $screenLogicalPixelHeight 
screenHeight: 
screen width: $screenLogicalPixelWidth
pixelRatio: $pixelRatio
''',
    );

    return iPhoneModelList
        .where((model) => model.hasNotch || model.hasDynamicIsland)
        .any((model) => model.logicalPixelHeight == screenLogicalPixelHeight);
  }

  ({double appBarHeight, double appBarPadding}) iOSAdaptiveHeights({
    required double screenLogicalPixelHeight,
    required double physicalWindowSize,
    required double pixelRatio,
  }) {
    final iOSMatchBySize = iPhoneModelList.firstWhere(
      (model) =>
          model.logicalPixelHeight == screenLogicalPixelHeight &&
          model.pixelRatio == pixelRatio &&
          model.screenHeight == physicalWindowSize,
      orElse: () => iPhoneModelList.first,
    );

    final modelCode = GetIt.I<SystemInfoRepository>().deviceModelName;

    final iOSMatchByName = iPhoneModelList.firstWhere(
      (model) => model.modelCode == modelCode,
      orElse: () => iOSMatchBySize,
    );

    log('iOS model: $iOSMatchByName');

    final iPhonesWithNotchOrDynamicIsland = iPhoneModelList
        .where(
          (iPhone) => iPhone.hasNotch || iPhone.hasDynamicIsland,
        )
        .toList();

    if (iPhonesWithNotchOrDynamicIsland.contains(iOSMatchByName)) {
      switch (iOSMatchByName) {
        case iPhoneXScreenModel:
        case iPhoneXSScreenModel:
        case iPhone11ScreenModel:
        case iPhone11ProScreenModel:
          return (appBarHeight: 130, appBarPadding: 190);
        case iPhone12MiniScreenModel:
        case iPhone13MiniScreenModel:
          return (appBarHeight: 120, appBarPadding: 190);
        case iPhoneXSMaxScreenModel:
        case iPhone11ProMaxScreenModel:
          return (appBarHeight: 130, appBarPadding: 185);
        case iPhone13ScreenModel:
        case iPhone13ProScreenModel:
          return (appBarHeight: 130, appBarPadding: 19);
        case iPhone12ProMaxScreenModel:
          return (appBarHeight: 130, appBarPadding: 188);
        case iPhone12ScreenModel:
        case iPhone12ProScreenModel:
        case iPhone14ScreenModel:
          return (appBarHeight: 130, appBarPadding: 193);
        case iPhone13ProMaxScreenModel:
        case iPhone14PlusScreenModel:
          return (appBarHeight: 130, appBarPadding: 187);
        case iPhone14ProMaxScreenModel:
        case iPhone15ProMaxScreenModel:
          return (appBarHeight: 125, appBarPadding: 195);
        case iPhone14ProScreenModel:
          return (appBarHeight: 125, appBarPadding: 200);
        case iPhone15ProScreenModel:
          return (appBarHeight: 125, appBarPadding: 192);
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
    this.screenWidth = 0,
    this.pixelRatio = 6,
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

/// These values are just here for reference

  // static const iPhone3Height = 480;
  // static const iPhone4Height = 960;
  // static const iPhone5Height = 1136;
  // static const iPhoneSeFirstGenHeight = 1136;
  // static const iPhoneSecondGenHeight = 1334;
  // static const iPhone6Height = 1334;
  // static const iPhone7Height = 1334;
  // static const iPhone8Height = 1334;
  // static const iPhone6PlusHeight = 1920;
  // static const iPhone7PlusHeight = 1920;
  // static const iPhone8PlusHeight = 1920;
  // static const iPhoneXHeight = 2436;
  // static const iPhoneXSHeight = 2436;
  // static const iPhoneXSMaxHeight = 2688;
  // static const iPhoneXRHeight = 1792;
  // static const iPhone11Height = 1792;
  // static const iPhone11ProHeight = 2436;
  // static const iPhone11ProMaxHeight = 2688;
  // static const iPhone12MiniHeight = 2340;
  // static const iPhone12Height = 2532;
  // static const iPhone12ProHeight = 2532;
  // static const iPhone12ProMaxHeight = 2778;
  // static const iPhone13MiniHeight = 2340;
  // static const iPhone13Height = 2532;
  // static const iPhone13ProHeight = 2532;
  // static const iPhone13ProMaxHeight = 2778;
  // static const iPhone14Height = 2532;
  // static const iPhone14PlusHeight = 2778;
  // static const iPhone14ProHeight = 2556;
  // static const iPhone14ProMaxHeight = 2796;
  // static const iPhone3LogicalPixelHeight = 480;
  // static const iPhone4LogicalPixelHeight = 480;
  // static const iPhone5LogicalPixelHeight = 568;
  // static const iPhoneSeFirstGenLogicalPixelHeight = 1136;
  // static const iPhoneSecondGenLogicalPixelHeight = 667;
  // static const iPhone6LogicalPixelHeight = 667;
  // static const iPhone7LogicalPixelHeight = 667;
  // static const iPhone8LogicalPixelHeight = 667;
  // static const iPhone6PlusLogicalPixelHeight = 736;
  // static const iPhone7PlusLogicalPixelHeight = 736;
  // static const iPhone8PlusLogicalPixelHeight = 736;
  // static const iPhoneXLogicalPixelHeight = 812;
  // static const iPhoneXSLogicalPixelHeight = 812;
  // static const iPhoneXRLogicalPixelHeight = 896;
  // static const iPhoneXSMaxLogicalPixelHeight = 896;
  // static const iPhone11LogicalPixelHeight = 896;
  // static const iPhone11ProLogicalPixelHeight = 812;
  // static const iPhone11ProMaxLogicalPixelHeight = 896;
  // static const iPhone12MiniLogicalPixelHeight = 812;
  // static const iPhone12LogicalPixelHeight = 844;
  // static const iPhone12ProLogicalPixelHeight = 844;
  // static const iPhone12ProMaxLogicalPixelHeight = 926;
  // static const iPhone13MiniLogicalPixelHeight = 812;
  // static const iPhone13LogicalPixelHeight = 844;
  // static const iPhone13ProLogicalPixelHeight = 844;
  // static const iPhone13ProMaxLogicalPixelHeight = 926;
  // static const iPhone14LogicalPixelHeight = 844;
  // static const iPhone14PlusLogicalPixelHeight = 926;
  // static const iPhone14ProLogicalPixelHeight = 852;
  // static const iPhone14ProMaxLogicalPixelHeight = 932;