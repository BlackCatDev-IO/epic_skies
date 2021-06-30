import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/utils/unit_settings_controller.dart';
import 'package:epic_skies/view/widgets/weather_info_display/hourly_widgets/hourly_detailed_row.dart';
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
            label: '${deg}F',
            borderColor: controller.tempUnitsMetric
                ? controller.unSelectedBorderColor
                : controller.selectedBorderColor,
          ),
          SettingsButton(
            isLeftButton: false,
            onTap: controller.updateTempUnits,
            label: '${deg}C',
            borderColor: !controller.tempUnitsMetric
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
            borderColor: controller.timeIs24Hrs
                ? controller.unSelectedBorderColor
                : controller.selectedBorderColor,
          ),
          SettingsButton(
            isLeftButton: false,
            onTap: controller.updateTimeFormat,
            label: '24 hrs',
            borderColor: !controller.timeIs24Hrs
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
            borderColor: controller.precipInMm
                ? controller.unSelectedBorderColor
                : controller.selectedBorderColor,
          ),
          SettingsButton(
            isLeftButton: false,
            onTap: controller.updatePrecipUnits,
            label: 'mm',
            borderColor: !controller.precipInMm
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
            borderColor: controller.speedInKm
                ? controller.unSelectedBorderColor
                : controller.selectedBorderColor,
          ),
          SettingsButton(
            isLeftButton: false,
            onTap: controller.updateSpeedUnits,
            label: 'kph',
            borderColor: !controller.speedInKm
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
