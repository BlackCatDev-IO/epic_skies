import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/services/weather/forecast_controller.dart';
import 'package:epic_skies/services/weather/weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class DailyForecastPage extends StatefulWidget {
  static const id = 'daily_forecast_page';

  @override
  _DailyForecastPage createState() => _DailyForecastPage();
}

class _DailyForecastPage extends State<DailyForecastPage>
    with AutomaticKeepAliveClientMixin {
  final weatherController = Get.find<WeatherController>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final searchIsLocal = Get.find<SearchController>().searchIsLocal;
    super.build(context);
    return PullToRefreshPage(
      onRefresh: () async {
        if (searchIsLocal) {
          await Get.find<WeatherController>().getAllWeatherData();
        } else
          Get.find<SearchController>().searchSelectedLocation();
      },
      child: Column(
        children: [
          GetX<ForecastController>(
            builder: (controller) {
              return ListView.builder(
                itemCount: controller.dayDetailedWidgetList.length,
                itemBuilder: (context, index) {
                  return controller.dayDetailedWidgetList[index];
                },
              ).expanded();
            },
          ),
        ],
      ).paddingSymmetric(horizontal: 5, vertical: 5),
    );
  }
}
