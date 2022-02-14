import 'package:black_cat_lib/widgets/my_custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Snackbars {
  static void bgImageUpdatedSnackbar() {
    final bar = GetSnackBar(
      messageText: MyTextWidget(
        text: 'Background Image Updated',
        fontFamily: 'Roboto',
        color: Colors.white,
        fontSize: 12.sp,
        fontWeight: FontWeight.w200,
      ),
      duration: const Duration(seconds: 3),
    );
    Get.showSnackbar(bar);
  }

  static void dynamicUpdatedSnackbar() {
    final bar = GetSnackBar(
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

  static void tempUnitsUpdateSnackbar({required bool tempUnitsMetric}) {
    final unit = tempUnitsMetric ? 'Celcius' : 'Fahrenheit';
    final bar = GetSnackBar(
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

  static void timeUnitsUpdateSnackbar({required bool timeIn24hrs}) {
    final unit = timeIn24hrs ? '24 hrs' : '12 hrs';
    final snackBar = GetSnackBar(
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

  static void precipitationUnitsUpdateSnackbar({required bool precipInMm}) {
    final unit = precipInMm ? 'Millimeters' : 'Inches';
    final bar = GetSnackBar(
      messageText: MyTextWidget(
        text: 'Precipitation units updated to $unit',
        fontSize: 12.sp,
        color: Colors.white,
        fontWeight: FontWeight.w200,
      ),
      duration: const Duration(seconds: 3),
    );
    Get.showSnackbar(bar);
  }

  static void windSpeedUnitsUpdateSnackbar({required bool speedInKph}) {
    final unit = speedInKph ? 'KPH' : 'MPH';
    final bar = GetSnackBar(
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
}
