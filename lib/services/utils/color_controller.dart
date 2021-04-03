import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global/local_constants.dart';
import 'asset_image_controllers/bg_image_controller.dart';

class ColorController extends GetxController {
  static ColorController get to => Get.find();

  Color bgImageTextColor = Colors.white70;
  Color bgImageFeelsLikeColor = Colors.white70;
  Color bgImageCityColor = Colors.white70;
  Color bgImageStreetColor = Colors.white70;
  Color bgImageConditionColor = Colors.white70;

  Color appBarColor = Colors.black45;

  RxBool textIsDark = false.obs;

  void updateBgText() {
    // TODO: Update this with new images
    // switch (imageString) {
    //   case snowPortrait:
    //     _setTextToDark();
    //     break;
    //   default:
    //     _setTextToLight();
    // }
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
