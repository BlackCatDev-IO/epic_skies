import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/features/current_weather_forecast/controllers/current_weather_controller.dart';
import 'package:epic_skies/features/location/remote_location/controllers/remote_location_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../features/main_weather/bloc/weather_bloc.dart';

class RemoteLocationLabel extends StatelessWidget {
  const RemoteLocationLabel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return !state.searchIsLocal
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedContainer(
                    color: Colors.white70,
                    child: GetBuilder<CurrentWeatherController>(
                      builder: (currentWeatherController) {
                        return Text(
                          '${RemoteLocationController.to.data!.city}, ${RemoteLocationController.to.data!.country}',
                        ).paddingSymmetric(horizontal: 10, vertical: 2.5);
                      },
                    ).center(),
                  ).paddingOnly(top: 2.5, bottom: 5),
                ],
              )
            : const SizedBox();
      },
    );
  }
}
