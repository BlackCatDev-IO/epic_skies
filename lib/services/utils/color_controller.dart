import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../local_constants.dart';
import 'image_controller.dart';

class ColorController extends GetxController {
  Color bgImageTextColor = Colors.white70;
  Color bgImageFeelsLikeColor = Colors.white70;
  Color bgImageCityColor = Colors.white70;
  Color bgImageStreetColor = Colors.white70;
  Color bgImageConditionColor = Colors.white70;

  RxBool textIsDark = false.obs;

  void updateBgText() {
    final imageString = Get.find<ImageController>().backgroundImageString;

    switch (imageString.value) {
      case snowPortrait:
        _setTextToDark();
        break;
      default:
        _setTextToLight();
    }

    // imageController.stream.forEach((data) {
  }

  void _setTextToDark() {
    bgImageTextColor = Colors.black;
    bgImageFeelsLikeColor = Colors.black;
    bgImageCityColor = Colors.black;
    bgImageStreetColor = Colors.black;
    bgImageConditionColor = Colors.black;
    textIsDark.value = true;
    update();
  }

  void _setTextToLight() {
    bgImageTextColor = Colors.white70;
    bgImageFeelsLikeColor = Colors.white70;
    bgImageCityColor = Colors.white70;
    bgImageStreetColor = Colors.white70;
    bgImageConditionColor = Colors.white70;
    textIsDark.value = false;
    update();
  }
}
