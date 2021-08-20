import 'package:black_cat_lib/widgets/my_custom_widgets.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../global/local_constants.dart';

void bgImageUpdatedSnackbar() {
  final bar = GetBar(
    messageText: MyTextWidget(
        text: 'Background Image Updated',
        fontFamily: 'Roboto',
        color: Colors.white,
        fontSize: 12.sp,
        fontWeight: FontWeight.w200),
    duration: const Duration(seconds: 3),
  );
  Get.showSnackbar(bar);
}

void dynamicUpdatedSnackbar() {
  final bar = GetBar(
    messageText: MyTextWidget(
      text: 'Background images will now be updated based on current weather',
      fontFamily: 'Roboto',
      fontSize: 12.sp,
      color: Colors.white,
      fontWeight: FontWeight.w200,
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
    messageText: MyTextWidget(
      text: 'Temperature units updated to $unit',
      fontFamily: 'Roboto',
      fontSize: 12.sp,
      color: Colors.white,
      fontWeight: FontWeight.w200,
    ),
    duration: const Duration(seconds: 2),
  );
  Get.showSnackbar(bar);
}

void timeUnitsUpdateSnackbar() {
  final timeIs24Hrs = StorageController.to.settingsMap[timeIs24HrsKey] as bool;

  final unit = timeIs24Hrs ? '24 hrs' : '12 hrs';
  final snackBar = GetBar(
    messageText: MyTextWidget(
      text: 'Time units updated to $unit',
      fontFamily: 'Roboto',
      fontSize: 12.sp,
      color: Colors.white,
      fontWeight: FontWeight.w200,
    ),
    duration: const Duration(seconds: 3),
  );
  Get.showSnackbar(snackBar);
}

void precipitationUnitsUpdateSnackbar() {
  final precipInMm = StorageController.to.settingsMap[precipInMmKey] as bool;

  final unit = precipInMm ? 'Millimeters' : 'Inches';
  final bar = GetBar(
    messageText: MyTextWidget(
        text: 'Precipitation units updated to $unit',
        fontSize: 12.sp,
        color: Colors.white,
        fontWeight: FontWeight.w200),
    duration: const Duration(seconds: 3),
  );
  Get.showSnackbar(bar);
}

void windSpeedUnitsUpdateSnackbar() {
  final speedInKm = StorageController.to.settingsMap[speedInKphKey] as bool;

  final unit = speedInKm ? 'KPH' : 'MPH';
  final bar = GetBar(
    messageText: MyTextWidget(
      text: 'Speed units updated to $unit',
      fontSize: 12.sp,
      color: Colors.white,
      fontWeight: FontWeight.w200,
    ),
    duration: const Duration(seconds: 3),
  );
  Get.showSnackbar(bar);
}
