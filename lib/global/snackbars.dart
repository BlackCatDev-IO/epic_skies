import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'local_constants.dart';

void bgImageUpdatedSnackbar() {
  final bar = GetBar(
    messageText: const Text(
      'Background Image Updated',
      style: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontSize: 17,
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
          fontSize: 17,
          color: Colors.white,
          fontWeight: FontWeight.w200),
    ),
    duration: const Duration(seconds: 5),
  );
  Get.showSnackbar(bar);
}

void tempUnitsUpdateSnackbar() {
  final tempUnitsMetric =
      StorageController.to.settingsMap[tempUnitsMetricKey] as bool;
  final unit = tempUnitsMetric ? 'Celcius' : 'Fahrenheit';
  final bar = GetBar(
    messageText: Text(
      'Temperature units updated to $unit',
      style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 17,
          color: Colors.white,
          fontWeight: FontWeight.w200),
    ),
    duration: const Duration(seconds: 2),
  );
  Get.showSnackbar(bar);
}

void timeUnitsUpdateSnackbar() {
  final timeIs24Hrs = StorageController.to.settingsMap[timeIs24HrsKey] as bool;

  final unit = timeIs24Hrs ? '24 hrs' : '12 hrs';
  final snackBar = GetBar(
    messageText: Text(
      'Time units updated to $unit',
      style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 17,
          color: Colors.white,
          fontWeight: FontWeight.w200),
    ),
    duration: const Duration(seconds: 3),
  );
  Get.showSnackbar(snackBar);
}

void precipitationUnitsUpdateSnackbar() {
  final precipInMm = StorageController.to.settingsMap[precipInMmKey] as bool;

  final unit = precipInMm ? 'Millimeters' : 'Inches';
  final bar = GetBar(
    messageText: Text(
      'Precipitation units updated to $unit',
      style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 17,
          color: Colors.white,
          fontWeight: FontWeight.w200),
    ),
    duration: const Duration(seconds: 3),
  );
  Get.showSnackbar(bar);
}

void windSpeedUnitsUpdateSnackbar() {
  final speedInKm = StorageController.to.settingsMap[speedInKphKey] as bool;

  final unit = speedInKm ? 'KPH' : 'MPH';
  final bar = GetBar(
    messageText: Text(
      'Speed units updated to $unit',
      style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 17,
          color: Colors.white,
          fontWeight: FontWeight.w200),
    ),
    duration: const Duration(seconds: 3),
  );
  Get.showSnackbar(bar);
}
