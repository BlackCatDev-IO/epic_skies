import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TempUnitsToggle extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (controller) => Row(
        children: [
          SettingsButton(
            onTap: controller.updateTempUnits,
            label: '12 hrs',
            color: controller.tempUnitsMetric
                ? controller.unSelectedColor
                : controller.selectedColor,
          ),
          SettingsButton(
            onTap: controller.updateTimeFormat,
            label: '24 hrs',
            color: !controller.tempUnitsMetric
                ? controller.unSelectedColor
                : controller.selectedColor,
          ),
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
          SettingsButton(
            onTap: controller.updateTimeFormat,
            label: '12 hrs',
            color: controller.timeIs24Hrs
                ? controller.unSelectedColor
                : controller.selectedColor,
          ),
          SettingsButton(
            onTap: controller.updateTimeFormat,
            label: '24 hrs',
            color: !controller.timeIs24Hrs
                ? controller.unSelectedColor
                : controller.selectedColor,
          ),
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
          SettingsButton(
            onTap: controller.updatePrecipUnits,
            label: 'Inches',
            color: controller.precipInMm
                ? controller.unSelectedColor
                : controller.selectedColor,
          ),
          SettingsButton(
            onTap: controller.updatePrecipUnits,
            label: 'Millimeters',
            color: !controller.precipInMm
                ? controller.unSelectedColor
                : controller.selectedColor,
          ),
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
          SettingsButton(
            onTap: controller.updateSpeedUnits,
            label: 'MPH',
            color: controller.speedInKm
                ? controller.unSelectedColor
                : controller.selectedColor,
          ),
          SettingsButton(
            onTap: controller.updateSpeedUnits,
            label: 'KPH',
            color: !controller.speedInKm
                ? controller.unSelectedColor
                : controller.selectedColor,
          ),
        ],
      ),
    );
  }
}

class SettingsButton extends GetView<SettingsController> {
  final Color color;
  final String label;
  final Function onTap;

  const SettingsButton({
    required this.color,
    required this.label,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap as void Function(),
        child: RoundedContainer(
          height: 35,
          radius: 10,
          borderWidth: 3.0,
          color: color,
          child: MyTextWidget(text: label, fontSize: 17).center(),
        )).paddingSymmetric(horizontal: 5).expanded();
  }
}
