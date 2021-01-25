import 'package:black_cat_lib/constants.dart';
import 'package:black_cat_lib/my_custom_widgets.dart';
import 'package:epic_skies/services/weather/weather_controller.dart';
import 'package:epic_skies/widgets/current_weather_row.dart';
import 'package:epic_skies/widgets/hourly_forecast_row.dart';
import 'package:epic_skies/widgets/weekly_forecast_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  static const id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: PullToRefreshPage2(
        onRefresh: () async {
          await Get.find<WeatherController>().getAllWeatherData();
        },
        child: Column(
          children: [
            const SizedBox(height: 110),
            const CurrentWeatherRow(),
         
            HourlyForecastRow(),
            WeeklyForecastRow(),
            HourlyForecastRow(),
            ElevatedButton(
              onPressed: () async {
                // Get.find<ImageController>().backgroundImageString.value =
                //     starryMountainPortrait;
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
}
