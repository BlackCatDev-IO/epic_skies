import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void bgImageUpdatedSnackbar() {
  final bar = GetBar(
    messageText: Text(
      'Background Image Updated',
      style: TextStyle(fontFamily: 'Roboto', color: Colors.white, fontSize: 15),
    ),
    duration: Duration(seconds: 3),
  );
  Get.showSnackbar(bar);
}

void dynamicUpdatedSnackbar() {
  final bar = GetBar(
    messageText: Text(
      'Background images will now be updated based on current weather',
      style: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontWeight: FontWeight.w200),
    ),
    duration: Duration(seconds: 5),
  );
  Get.showSnackbar(bar);
}

void tempUnitsUpdateSnackbar() {
  final controller = Get.find<SettingsController>();
  final unit = controller.tempUnitsCelcius.value ? 'Celcius' : 'Fahrenheit';
  final bar = GetBar(
    messageText: Text(
      'Temperature units updated to $unit',
      style: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontWeight: FontWeight.w200),
    ),
    duration: Duration(seconds: 3),
  );
  Get.showSnackbar(bar);
}

void timeUnitsUpdateSnackbar() {
  final controller = Get.find<SettingsController>();
  final unit = controller.timeIs24Hrs.value ? '24 hrs' : '12 hrs';
  final bar = GetBar(
    messageText: Text(
      'Time units updated to $unit',
      style: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontWeight: FontWeight.w200),
    ),
    duration: Duration(seconds: 3),
  );
  Get.showSnackbar(bar);
}

void precipitationUnitsUpdateSnackbar() {
  final controller = Get.find<SettingsController>();
  final unit = controller.precipInCm.value ? 'Centimeters' : 'Inches';
  final bar = GetBar(
    messageText: Text(
      'Precipitation units updated to $unit',
      style: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontWeight: FontWeight.w200),
    ),
    duration: Duration(seconds: 3),
  );
  Get.showSnackbar(bar);
}

void windSpeedUnitsUpdateSnackbar() {
  final controller = Get.find<SettingsController>();
  final unit = controller.speedInKm.value ? 'KPH' : 'MPH';
  final bar = GetBar(
    messageText: Text(
      'Speed units updated to $unit',
      style: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontWeight: FontWeight.w200),
    ),
    duration: Duration(seconds: 3),
  );
  Get.showSnackbar(bar);
}
