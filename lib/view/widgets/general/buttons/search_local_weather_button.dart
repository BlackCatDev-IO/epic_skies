import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SearchLocalWeatherButton extends GetView<ViewController> {
  const SearchLocalWeatherButton();

  void _searchLocalAndHeadToHomeTab() {
    controller.goToHomeTab();
    controller.tabController.animateTo(0);
    WeatherRepository.to.fetchLocalWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _searchLocalAndHeadToHomeTab,
      child: GetBuilder<ViewController>(
        builder: (_) => RoundedContainer(
          color: controller.theme.soloCardColor,
          radius: 8,
          height: 60,
          // borderColor: Colors.white,
          // borderWidth: 0.3,
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
