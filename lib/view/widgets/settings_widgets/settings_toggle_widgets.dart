import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TempUnitsToggle extends GetView<UnitSettingsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnitSettingsController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SettingsButton(
            isLeftButton: true,
            onTap: controller.updateTempUnits,
            label: '${degreeSymbol}F',
            borderColor: controller.settings.tempUnitsMetric
                ? controller.unSelectedBorderColor
                : controller.selectedBorderColor,
          ),
          SettingsButton(
            isLeftButton: false,
            onTap: controller.updateTempUnits,
            label: '${degreeSymbol}C',
            borderColor: !controller.settings.tempUnitsMetric
                ? controller.unSelectedBorderColor
                : controller.selectedBorderColor,
          ),
        ],
      ),
    ).expanded();
  }
}

class TimeSettingToggle extends GetView<UnitSettingsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnitSettingsController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SettingsButton(
            isLeftButton: true,
            onTap: controller.updateTimeFormat,
            label: '12 hrs',
            borderColor: controller.settings.timeIn24Hrs
                ? controller.unSelectedBorderColor
                : controller.selectedBorderColor,
          ),
          SettingsButton(
            isLeftButton: false,
            onTap: controller.updateTimeFormat,
            label: '24 hrs',
            borderColor: !controller.settings.timeIn24Hrs
                ? controller.unSelectedBorderColor
                : controller.selectedBorderColor,
          ),
        ],
      ),
    ).expanded();
  }
}

class PrecipitationUnitSettingToggle extends GetView<UnitSettingsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnitSettingsController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SettingsButton(
            isLeftButton: true,
            onTap: controller.updatePrecipUnits,
            label: 'in',
            borderColor: controller.settings.precipInMm
                ? controller.unSelectedBorderColor
                : controller.selectedBorderColor,
          ),
          SettingsButton(
            isLeftButton: false,
            onTap: controller.updatePrecipUnits,
            label: 'mm',
            borderColor: !controller.settings.precipInMm
                ? controller.unSelectedBorderColor
                : controller.selectedBorderColor,
          ),
        ],
      ),
    ).expanded();
  }
}

class WindSpeedUnitSettingToggle extends GetView<UnitSettingsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnitSettingsController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SettingsButton(
            isLeftButton: true,
            onTap: controller.updateSpeedUnits,
            label: 'mph',
            borderColor: controller.settings.speedInKph
                ? controller.unSelectedBorderColor
                : controller.selectedBorderColor,
          ),
          SettingsButton(
            isLeftButton: false,
            onTap: controller.updateSpeedUnits,
            label: 'kph',
            borderColor: !controller.settings.speedInKph
                ? controller.unSelectedBorderColor
                : controller.selectedBorderColor,
          ),
        ],
      ),
    ).expanded();
  }
}

class SettingsButton extends GetView<UnitSettingsController> {
  final Color? borderColor;
  final String label;
  final Function onTap;
  final bool isLeftButton;

  const SettingsButton({
    this.borderColor,
    required this.label,
    required this.onTap,
    required this.isLeftButton,
  });

  @override
  Widget build(BuildContext context) {
    const radius = 30.0;
    return GestureDetector(
      onTap: onTap as void Function(),
      child: PartialRoundedContainer(
        height: 5.h,
        width: 17.w,
        topRight: isLeftButton ? 0 : radius,
        topLeft: isLeftButton ? radius : 0,
        bottomLeft: isLeftButton ? radius : 0,
        bottomRight: isLeftButton ? 0 : radius,
        borderWidth: 0.7,
        borderColor: borderColor,
        child: MyTextWidget(
          text: label,
          fontSize: 10.sp,
          color: Colors.white,
        ).center(),
      ),
    );
  }
}
