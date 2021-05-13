import 'package:black_cat_lib/widgets/my_custom_widgets.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:epic_skies/view/widgets/weather_info_display/weekly_forecast_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForecastPage extends StatelessWidget {
  static const id = 'forecast_page';

  @override
  Widget build(BuildContext context) {
    return PullToRefreshPage(
      onRefresh: () async {
        await WeatherRepository.to.fetchLocalWeatherData();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 110,
          ),
          WeeklyForecastRow(),
          updateInfoButton(),
        ],
      ).paddingSymmetric(horizontal: 15, vertical: 30),
    );
  }

  Widget updateInfoButton() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          WeatherRepository.to.fetchLocalWeatherData();
        },
        child: const Text(
          'Get Local Weather',
          style: TextStyle(
              color: Colors.amber, fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
