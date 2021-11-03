import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SearchLocalWeatherButton extends GetView<TabNavigationController> {
  const SearchLocalWeatherButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.searchLocalAndHeadToHomeTab();
        WeatherRepository.to.fetchLocalWeatherData();
      },
      child: GetBuilder<ColorController>(
        builder: (colorController) => RoundedContainer(
          color: colorController.theme.soloCardColor,
          radius: 8,
          height: 60,
          child: Stack(
            children: [
              const Icon(
                Icons.near_me,
                color: Colors.white70,
                size: 24.0,
              ).paddingOnly(left: 20, top: 7),
              MyTextWidget(
                text: 'Search Current Location',
                fontSize: 13.sp,
                color: Colors.blueGrey[200],
              ).center(),
            ],
          ).paddingSymmetric(vertical: 11),
        ),
      ),
    ).paddingSymmetric(vertical: 10);
  }
}
