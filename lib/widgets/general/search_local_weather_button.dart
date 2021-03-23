import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/widgets/general/animated_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchLocalWeatherWidget extends StatelessWidget {
  const SearchLocalWeatherWidget();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const CustomAnimatedDrawer());
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
          const MyTextWidget(
            text: 'Search your local weather',
          ).center().expanded(),
        ],
      ).paddingSymmetric(vertical: 10),
    );
  }
}
