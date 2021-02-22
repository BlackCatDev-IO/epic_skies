import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/utils/view_controller.dart';
import 'package:epic_skies/widgets/general/animated_drawer.dart';
import 'package:epic_skies/widgets/general/my_app_bar.dart';
import 'package:epic_skies/widgets/weather_info_display/weather_image_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

import '../../local_constants.dart';
import '../home_tab_view.dart';

class UnitsScreen extends GetView<SettingsController> {
  static const id = 'units_screen';
  final viewController = Get.find<ViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WeatherImageContainer(
        image: earthFromSpacePortrait,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            settingsAppBar(label: 'Unit Settings'),
            CustomListTile(
              title: 'Temp Units',
              onPressed: () {},
              icon: Icons.add,
              settingsSwitch:
                  ObxToggleSwitch(settingsBool: controller.tempUnitsCelcius),
            ),
            CustomListTile(
                title: 'Time Format',
                onPressed: () {},
                icon: Icons.access_time),
            CustomListTile(
                title: 'Precipitation', onPressed: () {}, icon: Icons.add),
            CustomListTile(
                title: 'Wind Speed', onPressed: () {}, icon: Icons.add),
          ],
        ).paddingSymmetric(horizontal: 10),
      ),
    );
  }
}
