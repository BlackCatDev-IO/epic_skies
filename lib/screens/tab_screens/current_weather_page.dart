import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:black_cat_lib/my_custom_widgets.dart';
import 'package:epic_skies/services/utils/master_getx_controller.dart';
import 'package:epic_skies/services/network/weather_repository.dart';
import 'package:epic_skies/widgets/general/my_circular_progress_indicator.dart';
import 'package:epic_skies/widgets/weather_info_display/current_weather_row.dart';
import 'package:epic_skies/widgets/weather_info_display/hourly_forecast_widgets.dart';
import 'package:epic_skies/widgets/weather_info_display/weekly_forecast_row.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentWeatherPage extends StatefulWidget {
  static const id = 'current_weather_page';

  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

List<Widget> homeWidgetList = <Widget>[
  const CurrentWeatherRow(),
  HourlyForecastRow(),
  WeeklyForecastRow(),
];

class _CurrentWeatherPageState extends State<CurrentWeatherPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PullToRefreshPage(
      onRefresh: () async {
        MasterController.to.onRefresh();
      },
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 150),
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: homeWidgetList.length,
                itemBuilder: (context, index) {
                  return homeWidgetList[index];
                },
              ).expanded()
            ],
          ).paddingSymmetric(horizontal: 5, vertical: 15),
          Obx(
            () => WeatherRepository.to.isLoading.value
                ? const MyCircularProgressIndicator()
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
