import 'package:epic_skies/services/weather/forecast_controller.dart';
import 'package:epic_skies/services/weather/weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class HourlyForecastPage extends StatefulWidget {
  static const id = 'hourly_forecast_page';

  @override
  _HourlyForecastPageState createState() => _HourlyForecastPageState();
}

class _HourlyForecastPageState extends State<HourlyForecastPage>
    with AutomaticKeepAliveClientMixin {
  final weatherController = Get.find<WeatherController>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PullToRefreshPage(
      onRefresh: () async {
        await Get.find<WeatherController>().getAllWeatherData();
      },
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // const SizedBox(height: 110),
          GetX<ForecastController>(
            builder: (controller) {
              return ListView.builder(
                itemCount: controller.hourRowList.length,
                itemBuilder: (context, index) {
                  return controller.hourRowList[index];
                },
              ).expanded();
            },
          ),
        ],
      ).paddingSymmetric(horizontal: 5, vertical: 5),
    );
  }


}
