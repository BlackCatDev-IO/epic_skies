import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/screens/home_tab_view.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchLocalWeatherWidget extends StatelessWidget {
  const SearchLocalWeatherWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(HomeTabView());
        Get.find<WeatherRepository>().getAllWeatherData();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.my_location,
            color: Colors.amber,
            size: 24.0,
          ).paddingOnly(left: 20),
          MyTextWidget(
            text: 'Search your local weather',
          ).center().expanded(),
        ],
      ).paddingSymmetric(vertical: 10),
    );
  }
}
