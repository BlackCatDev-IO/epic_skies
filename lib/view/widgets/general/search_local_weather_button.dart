import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/view/screens/settings_screens/drawer_animator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchLocalWeatherWidget extends GetView<ViewController> {
  const SearchLocalWeatherWidget();

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: controller.soloCardColor,
      child: GestureDetector(
        onTap: () {
          Get.to(() => const CustomAnimatedDrawer());
          ViewController.to.tabController.animateTo(0);
          WeatherRepository.to.fetchLocalWeatherData();
        },
        child: Stack(
          children: [
            Positioned(
              top: 5,
              child: Icon(
                Icons.near_me,
                color: Colors.blue[900],
                size: 24.0,
              ).paddingOnly(left: 20),
            ),
            MyTextWidget(
              text: 'Current Location',
              color: Colors.blueGrey[200],
              // fontSize: 22,
            ).center(),
          ],
        ).paddingSymmetric(vertical: 11),
      ),
    ).paddingSymmetric(vertical: 10, horizontal: 10);
  }
}
