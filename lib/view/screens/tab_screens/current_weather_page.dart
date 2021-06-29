import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/view/widgets/general/my_circular_progress_indicator.dart';
import 'package:epic_skies/view/widgets/weather_info_display/current_weather_row.dart';
import 'package:epic_skies/view/widgets/weather_info_display/hourly_widgets/hourly_forecast_row.dart';
import 'package:epic_skies/view/widgets/weather_info_display/weekly_forecast_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentWeatherPage extends StatefulWidget {
  static const id = 'current_weather_page';

  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage>
    with AutomaticKeepAliveClientMixin {
  List<Widget> homeWidgetList = <Widget>[
    const CurrentWeatherRow(),
    const SizedBox(height: 2),
    HourlyForecastRow(),
    WeeklyForecastRow(),
  ];

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PullToRefreshPage(
      onRefresh: () async {
        WeatherRepository.to.refreshWeatherData();
      },
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 135.h),
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: homeWidgetList.length,
                itemBuilder: (context, index) {
                  return homeWidgetList[index];
                },
              ).expanded()
            ],
          ).paddingSymmetric(horizontal: 2.5, vertical: 1),
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
