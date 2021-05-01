import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void bgImageUpdatedSnackbar() {
  final bar = GetBar(
    messageText: const Text(
      'Background Image Updated',
      style: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontWeight: FontWeight.w200),
    ),
    duration: const Duration(seconds: 3),
  );
  Get.showSnackbar(bar);
}

void dynamicUpdatedSnackbar() {
  final bar = GetBar(
    messageText: const Text(
      'Background images will now be updated based on current weather',
      style: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontWeight: FontWeight.w200),
    ),
    duration: const Duration(seconds: 5),
  );
  Get.showSnackbar(bar);
}

void tempUnitsUpdateSnackbar() {
  final unit =
      SettingsController.to.tempUnitsMetric ? 'Celcius' : 'Fahrenheit';
  final bar = GetBar(
    messageText: Text(
      'Temperature units updated to $unit',
      style: const TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontWeight: FontWeight.w200),
    ),
    duration: const Duration(seconds: 2),
  );
  Get.showSnackbar(bar);
}

void timeUnitsUpdateSnackbar() {
  final unit = SettingsController.to.timeIs24Hrs ? '24 hrs' : '12 hrs';
  final bar = GetBar(
    messageText: Text(
      'Time units updated to $unit',
      style: const TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontWeight: FontWeight.w200),
    ),
    duration: const Duration(seconds: 3),
  );
  Get.showSnackbar(bar);
}

void precipitationUnitsUpdateSnackbar() {
  final unit =
      SettingsController.to.precipInMm ? 'Millimeters' : 'Inches';
  final bar = GetBar(
    messageText: Text(
      'Precipitation units updated to $unit',
      style: const TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontWeight: FontWeight.w200),
    ),
    duration: const Duration(seconds: 3),
  );
  Get.showSnackbar(bar);
}

void windSpeedUnitsUpdateSnackbar() {
  final unit = SettingsController.to.speedInKm ? 'KPH' : 'MPH';
  final bar = GetBar(
    messageText: Text(
      'Speed units updated to $unit',
      style: const TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontWeight: FontWeight.w200),
    ),
    duration: const Duration(seconds: 3),
  );
  Get.showSnackbar(bar);
}

void goHomeFromNestedSettingPage() {
  if (Get.isSnackbarOpen!) {
    Get.back();
    Get.back();
    ViewController.to.animationController.forward();
  } else {
    Get.back();
    ViewController.to.animationController.forward();
  }
}
