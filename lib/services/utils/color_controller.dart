import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'image_controller.dart';

class ColorController extends GetxController {

  //TODO Write function that watches BG image string and updates accordingly


void updateBgText() {
Get.find<ImageController>().backgroundImageString.stream.forEach((data) {
  // switch (data) {
  //   case :
      
  //     break;
  //   default:
  // }
});


}

  Color bgImageTextColor = Colors.white70;
  Color bgImageFeelsLikeColor = Colors.white70;
  Color bgImageCityColor = Colors.white70;
  Color bgImageStreetColor = Colors.white70;
  Color bgImageConditionColor = Colors.white70;

  RxBool textIsDark = false.obs;


  void setTextToDark() {
    bgImageTextColor = Colors.black54;
    bgImageFeelsLikeColor = Colors.black54;
    bgImageCityColor = Colors.black54;
    bgImageStreetColor = Colors.black54;
    bgImageConditionColor = Colors.black54;
    textIsDark.value = true;
    update();
  }

  void setTextToLight() {
    bgImageTextColor = Colors.white70;
    bgImageFeelsLikeColor = Colors.white70;
    bgImageCityColor = Colors.white70;
    bgImageStreetColor = Colors.white70;
    bgImageConditionColor = Colors.white70;
    textIsDark.value = false;
    update();
  }
}
