import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/utils/unit_settings_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/view/widgets/general/settings_widgets/settings_header.dart';
import 'package:epic_skies/view/widgets/general/settings_widgets/settings_list_tile.dart';
import 'package:epic_skies/view/widgets/general/settings_widgets/settings_toggle_widgets.dart';
import 'package:epic_skies/view/widgets/weather_info_display/weather_image_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class UnitsScreen extends GetView<UnitSettingsController> {
  static const id = 'units_screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FixedImageContainer(
          image: earthFromSpace,
          child: Column(
            children: [
              const SettingsHeader(title: 'Unit Settings'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingsTile(
                      title: 'Home',
                      onPressed: () =>
                          ViewController.to.goHomeFromNestedSettingsPage(),
                      icon: Icons.home),
                  SettingsToggleRow(
                      label: 'Temp Units', child: TempUnitsToggle()),
                  SettingsToggleRow(
                      label: 'Time Format', child: TimeSettingToggle()),
                  SettingsToggleRow(
                      label: 'Precipitation',
                      child: PrecipitationUnitSettingToggle()),
                  SettingsToggleRow(
                      label: 'Wind Speed', child: WindSpeedUnitSettingToggle()),
                ],
              ).paddingSymmetric(horizontal: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsToggleRow extends StatelessWidget {
  final String label;
  final Widget child;

  const SettingsToggleRow({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: kBlackCustom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextWidget(text: label, fontSize: 15)
              .paddingOnly(left: 10)
              .paddingOnly(bottom: 10),
          child,
        ],
      ).paddingOnly(bottom: 15, top: 10, left: 7, right: 7),
    ).paddingSymmetric(vertical: 10);
  }
}
