import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/view/screens/settings_screens/drawer_animator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchLocalWeatherButton extends GetView<ViewController> {
  const SearchLocalWeatherButton();

  void _searchLocalAndHeadToHomeTab() {
    Get.to(() => const CustomAnimatedDrawer());
    controller.tabController.animateTo(0);
    WeatherRepository.to.fetchLocalWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _searchLocalAndHeadToHomeTab(),
      child: RoundedContainer(
        color: controller.soloCardColor,
        radius: 8,
        height: 60,
        child: Stack(
          children: [
            Icon(
              Icons.near_me,
              color: Colors.blue[900],
              size: 24.0,
            ).paddingOnly(left: 20, top: 7),
            MyTextWidget(
              text: 'Search Current Location',
              color: Colors.blueGrey[200],
            ).center(),
          ],
        ).paddingSymmetric(vertical: 11),
      ),
    ).paddingSymmetric(vertical: 10);
  }
}
