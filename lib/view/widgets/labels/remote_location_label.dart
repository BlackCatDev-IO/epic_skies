import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/location/remote_location_controller.dart';
import 'package:epic_skies/services/weather_forecast/current_weather_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RemoteLocationLabel extends StatelessWidget {
  const RemoteLocationLabel();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherRepository>(
      builder: (controller) => !controller.searchIsLocal
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedContainer(
                  color: Colors.white70,
                  child: GetBuilder<CurrentWeatherController>(
                    builder: (currentWeatherController) {
                      return Text(
                        '${RemoteLocationController.to.data.city}, ${RemoteLocationController.to.data.country}',
                      ).paddingSymmetric(horizontal: 10, vertical: 2.5);
                    },
                  ).center(),
                ).paddingOnly(top: 2.5, bottom: 5),
              ],
            )
          : const SizedBox(),
    );
  }
}
