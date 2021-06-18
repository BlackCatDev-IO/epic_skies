import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/utils/unit_settings_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/view/widgets/general/buttons/home_from_settings_button.dart';
import 'package:epic_skies/view/widgets/general/settings_widgets/settings_header.dart';
import 'package:epic_skies/view/widgets/general/settings_widgets/settings_toggle_widgets.dart';
import 'package:epic_skies/view/widgets/weather_info_display/weather_image_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class UnitsScreen extends GetView<UnitSettingsController> {
  static const id = '/units_screen';
  @override
  Widget build(BuildContext context) => ViewController.to.iPhoneHasNotch
      ? const MainUnitScreen()
      : const SafeArea(child: MainUnitScreen());
}

class MainUnitScreen extends StatelessWidget {
  const MainUnitScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FixedImageContainer(
        image: earthFromSpace,
        child: Column(
          children: [
            const SettingsHeader(title: 'Unit Settings', backButtonShown: true),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeFromSettingsButton(),
                SettingsToggleRow(
                  label: 'Temp Units',
                  child: TempUnitsToggle(),
                ),
                sizedBox5High,
                SettingsToggleRow(
                    label: 'Time Format', child: TimeSettingToggle()),
                sizedBox5High,
                SettingsToggleRow(
                    label: 'Precipitation',
                    child: PrecipitationUnitSettingToggle()),
                sizedBox5High,
                SettingsToggleRow(
                    label: 'Wind Speed', child: WindSpeedUnitSettingToggle()),
              ],
            ).paddingSymmetric(horizontal: 10),
          ],
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
      height: 70,
      child: Row(
        children: [
          Container(
            child: MyTextWidget(text: label, fontSize: 15, fontFamily: 'Roboto')
                .paddingOnly(left: 10),
          ),
          sizedBox10High,
          child,
          sizedBox10Wide,
        ],
      ),
    );
  }
}
