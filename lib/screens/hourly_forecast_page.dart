import 'package:epic_skies/services/weather/forecast_controller.dart';
import 'package:epic_skies/services/weather/weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class HourlyForecastPage extends StatelessWidget {
  static const id = 'hourly_forecast_page';
  final weatherController = Get.find<WeatherController>();

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return PullToRefreshPage(
      onRefresh: () async {
        await Get.find<WeatherController>().getAllWeatherData();
      },
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 110),
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

  Widget updateInfoButton() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          weatherController.getAllWeatherData();
        },
        child: const Text(
          'Get Local Weather',
          style: TextStyle(
              color: Colors.amber, fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
