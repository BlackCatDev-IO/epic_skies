import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global/local_constants.dart';

class ColorController extends GetxController {
  static ColorController get to => Get.find();

  Color bgImageTextColor = Colors.white70;
  Color bgImageFeelsLikeColor = Colors.white70;
  Color bgImageCityColor = Colors.white70;
  Color bgImageStreetColor = Colors.white70;
  Color bgImageConditionColor = Colors.white70;
  Color borderTextColor = Colors.white70;

  Color appBarColor = Colors.black45;

  bool textIsDark = false;

  bool textBorder = false;

  void updateBgTextColor(File file) {
    // TODO: Update this with new images
    final path = file.path;

    if (path.endsWith(clearNight1)) {
      _setTextToLight();
      debugPrint(clearNight1);
    } else if (path.endsWith(clearDay1)) {
      _setTextToLight();
      debugPrint(clearDay1);
    } else if (path.endsWith(earthFromSpace)) {
      _setTextToLight();
      debugPrint(earthFromSpace);
    } else if (path.endsWith(clearNight1)) {
      _setTextToLight();
      debugPrint(clearNight1);
    } else if (path.endsWith(cloudyDay1)) {
      _setTextToLight();
      debugPrint(cloudyDay1);
    } else if (path.endsWith(cloudyDaySunset2)) {
      _setTextToLight();
      debugPrint(cloudyDaySunset2);
    } else if (path.endsWith(cloudyDayPalmTree3)) {
      _setTextToLight();
      debugPrint(cloudyDayPalmTree3);
    } else if (path.endsWith(rainDay1)) {
      _setTextToLight();
      debugPrint(rainDay1);
    } else if (path.endsWith(rainSadFace2)) {
      _setTextToLight();
      debugPrint(rainSadFace2);
    } else if (path.endsWith(snowDay1)) {
      _setTextToLight();
      debugPrint(snowDay1);
      _setTextToDark();
    } else if (path.endsWith(snowNight1)) {
      _setTextToLight();
      debugPrint(snowNight1);
    } else if (path.endsWith(stormNight1)) {
      _setTextToLight();
      debugPrint(stormNight1);
    }
  }

  void _setTextToDark() {
    textBorder = true;
    borderTextColor = Colors.white70;

    bgImageTextColor = Colors.black;
    bgImageFeelsLikeColor = Colors.black;
    bgImageCityColor = Colors.black;
    bgImageStreetColor = Colors.black;
    bgImageConditionColor = Colors.black;
    textIsDark = true;
    update();
  }

  void _setTextToLight() {
    textBorder = false;
    bgImageTextColor = Colors.white70;
    bgImageFeelsLikeColor = Colors.white70;
    bgImageCityColor = Colors.white70;
    bgImageStreetColor = Colors.white70;
    bgImageConditionColor = Colors.white70;
    textIsDark = false;
    update();
  }
}
