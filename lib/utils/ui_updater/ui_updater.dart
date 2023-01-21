import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/current_weather_forecast/cubit/current_weather_cubit.dart';
import '../../features/daily_forecast/cubit/daily_forecast_cubit.dart';
import '../../features/hourly_forecast/cubit/hourly_forecast_cubit.dart';
import '../../features/main_weather/bloc/weather_bloc.dart';
import '../../global/app_bloc/app_bloc.dart';
import '../../services/asset_controllers/bg_image/bloc/bg_image_bloc.dart';

class UiUpdater {
  static void refreshUI(BuildContext context) {
    context.read<AppBloc>().add(AppNotifyNotLoading());

    final weatherState = context.read<WeatherBloc>().state;

    context
        .read<CurrentWeatherCubit>()
        .refreshCurrentWeatherData(weatherState: weatherState);

    final hourlyCubit = context.read<HourlyForecastCubit>()
      ..refreshHourlyData(updatedWeatherState: weatherState);

    context.read<DailyForecastCubit>().refreshDailyData(
          updatedWeatherState: weatherState,
          sortedHourlyList: hourlyCubit.state.sortedHourlyList,
        );

    if (weatherState.status.isSuccess) {
      final bgImageBloc = context.read<BgImageBloc>();

      /// Updating app BG Image if settings are `ImageSettings.dynamic`
      if (bgImageBloc.state.imageSettings.isDynamic) {
        bgImageBloc.add(
          BgImageUpdateOnRefresh(
            weatherState: weatherState,
          ),
        );
      }
    }
  }
}
