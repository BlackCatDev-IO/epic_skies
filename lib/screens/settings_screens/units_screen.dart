import 'package:epic_skies/global/snackbars.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/utils/view_controller.dart';
import 'package:epic_skies/widgets/general/animated_drawer.dart';
import 'package:epic_skies/widgets/general/my_app_bar.dart';
import 'package:epic_skies/widgets/general/settings_widgets/settings_toggle_widgets.dart';
import 'package:epic_skies/widgets/weather_info_display/weather_image_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

import '../../local_constants.dart';

class UnitsScreen extends GetView<SettingsController> {
  static const id = 'units_screen';
  final viewController = Get.find<ViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FixedImageContainer(
        image: earthFromSpacePortrait,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            settingsAppBar(label: 'Unit Settings'),
            CustomListTile(
                    title: 'Home',
                    onPressed: () {
                      goHomeFromNestedSettingPage();
                    },
                    icon: Icons.home)
                .paddingOnly(bottom: 15),
            SettingsToggleRow(label: 'Temp Units', child: TempUnitsToggle()),
            SettingsToggleRow(label: 'Time Format', child: TimeSettingToggle()),
            SettingsToggleRow(
                label: 'Precipitation',
                child: PrecipitationUnitSettingToggle()),
            SettingsToggleRow(
                label: 'Wind Speed', child: WindSpeedUnitSettingToggle()),
          ],
        ).paddingSymmetric(horizontal: 10),
      ),
    );
  }
}

class SettingsToggleRow extends StatelessWidget {
  final String label;
  final Widget child;

  const SettingsToggleRow({@required this.label, @required this.child});
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: blackCustom,
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
