import 'package:black_cat_lib/constants.dart';
import 'package:black_cat_lib/my_custom_widgets.dart';
import 'package:epic_skies/services/weather/weather_controller.dart';
import 'package:epic_skies/widgets/current_weather_row.dart';
import 'package:epic_skies/widgets/hourly_forecast_row.dart';
import 'package:epic_skies/widgets/weekly_forecast_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../local_constants.dart';

class HomePage extends StatelessWidget {
  static const id = 'home_page';

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return SingleChildScrollView(
      child: PullToRefreshPage2(
        onRefresh: () async {
          await Get.find<WeatherController>().getAllWeatherData();
        },
        child: Column(
          children: [
            const SizedBox(height: 110),
            const CurrentWeatherRow(),
            sizedBox10High,
            sizedBox10High,
            HourlyForecastRow(),
            WeeklyForecastRow(),
            HourlyForecastRow(),
            ElevatedButton(
              onPressed: () async {
                await Get.find<WeatherController>().getAllWeatherData();
              },
              child: const MyTextWidget(
                text: 'Refresh',
              ),
            ),
            // WeeklyForecastRow(),
            sizedBox10High,
          ],
        ).paddingSymmetric(horizontal: 10, vertical: 15),
      ),
    );
  }

  // @override
  // bool get wantKeepAlive => true;
}
