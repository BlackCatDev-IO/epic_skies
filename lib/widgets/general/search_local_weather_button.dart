import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:epic_skies/services/utils/view_controllers/color_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/screens/settings_screens/settings_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchLocalWeatherWidget extends GetView<ColorController> {
  const SearchLocalWeatherWidget();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const CustomAnimatedDrawer());
        ViewController.to.tabController.animateTo(0);
        WeatherRepository.to.fetchLocalWeatherData();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.my_location,
            color: Colors.amber,
            size: 24.0,
          ).paddingOnly(left: 20),
          MyTextWidget(
            text: 'Search your local weather',
            color: controller.bgImageTextColor,
          ).center().expanded(),
        ],
      ).paddingSymmetric(vertical: 10),
    );
  }
}
