import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/snackbars.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TempUnitsToggle extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (controller) => Row(
        children: [
          GestureDetector(
            onTap: () {
              controller.tempUnitsMetric.toggle();
              tempUnitsUpdateSnackbar();
            },
            child: RoundedContainer(
              height: 35,
              radius: 10,
              borderWidth: 3.0,
              color: controller.tempUnitsMetric.value
                  ? controller.unSelectedColor
                  : controller.selectedColor,
              child: const MyTextWidget(text: 'Fahrenheight', fontSize: 17)
                  .center(),
            ),
          ).paddingSymmetric(horizontal: 5).expanded(),
          GestureDetector(
            onTap: () {
              controller.tempUnitsMetric.toggle();
              tempUnitsUpdateSnackbar();
            },
            child: RoundedContainer(
              height: 35,
              radius: 10,
              borderWidth: 3.0,
              color: !controller.tempUnitsMetric.value
                  ? controller.unSelectedColor
                  : controller.selectedColor,
              child: const MyTextWidget(text: 'Celcius', fontSize: 17).center(),
            ),
          ).paddingSymmetric(horizontal: 5).expanded(),
        ],
      ),
    );
  }
}

class TimeSettingToggle extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (controller) => Row(
        children: [
          GestureDetector(
            onTap: () {
              controller.timeIs24Hrs.toggle();
              timeUnitsUpdateSnackbar();
            },
            child: RoundedContainer(
              height: 35,
              radius: 10,
              borderWidth: 3.0,
              color: controller.timeIs24Hrs.value
                  ? controller.unSelectedColor
                  : controller.selectedColor,
              child: const MyTextWidget(text: '12 hrs', fontSize: 17).center(),
            ),
          ).paddingSymmetric(horizontal: 5).expanded(),
          GestureDetector(
            onTap: () {
              controller.timeIs24Hrs.toggle();
              timeUnitsUpdateSnackbar();
            },
            child: RoundedContainer(
              height: 35,
              radius: 10,
              borderWidth: 3.0,
              color: !controller.timeIs24Hrs.value
                  ? controller.unSelectedColor
                  : controller.selectedColor,
              child: const MyTextWidget(text: '24 hrs', fontSize: 17).center(),
            ),
          ).paddingSymmetric(horizontal: 5).expanded(),
        ],
      ),
    );
  }
}

class PrecipitationUnitSettingToggle extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (controller) => Row(
        children: [
          GestureDetector(
            onTap: () {
              controller.precipInMm.toggle();
              precipitationUnitsUpdateSnackbar();
            },
            child: RoundedContainer(
              height: 35,
              radius: 10,
              borderWidth: 3.0,
              color: controller.precipInMm.value
                  ? controller.unSelectedColor
                  : controller.selectedColor,
              child: const MyTextWidget(text: 'Inches', fontSize: 17).center(),
            ),
          ).paddingSymmetric(horizontal: 5).expanded(),
          GestureDetector(
            onTap: () {
              controller.precipInMm.toggle();
              precipitationUnitsUpdateSnackbar();
            },
            child: RoundedContainer(
              height: 35,
              radius: 10,
              borderWidth: 3.0,
              color: !controller.precipInMm.value
                  ? controller.unSelectedColor
                  : controller.selectedColor,
              child: const MyTextWidget(text: 'Millimeters', fontSize: 17)
                  .center(),
            ),
          ).paddingSymmetric(horizontal: 5).expanded(),
        ],
      ),
    );
  }
}

class WindSpeedUnitSettingToggle extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (controller) => Row(
        children: [
          GestureDetector(
            onTap: () {
              controller.speedInKm.toggle();
              windSpeedUnitsUpdateSnackbar();
            },
            child: RoundedContainer(
              height: 35,
              radius: 10,
              borderWidth: 3.0,
              color: controller.speedInKm.value
                  ? controller.unSelectedColor
                  : controller.selectedColor,
              child: const MyTextWidget(text: 'mph', fontSize: 17).center(),
            ),
          ).paddingSymmetric(horizontal: 5).expanded(),
          GestureDetector(
            onTap: () {
              controller.speedInKm.toggle();
              windSpeedUnitsUpdateSnackbar();
            },
            child: RoundedContainer(
              height: 35,
              radius: 10,
              borderWidth: 3.0,
              color: !controller.speedInKm.value
                  ? controller.unSelectedColor
                  : controller.selectedColor,
              child:const MyTextWidget(text: 'kph', fontSize: 17).center(),
            ),
          ).paddingSymmetric(horizontal: 5).expanded(),
        ],
      ),
    );
  }
}
