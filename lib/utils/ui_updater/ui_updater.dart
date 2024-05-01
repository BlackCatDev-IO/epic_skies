import 'package:epic_skies/features/bg_image/bloc/bg_image_bloc.dart';
import 'package:epic_skies/features/current_weather_forecast/cubit/current_weather_cubit.dart';
import 'package:epic_skies/features/daily_forecast/cubit/daily_forecast_cubit.dart';
import 'package:epic_skies/features/hourly_forecast/cubit/hourly_forecast_cubit.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/main_weather/view/cubit/local_weather_button_cubit.dart';
import 'package:epic_skies/global/app_bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UiUpdater {
  static void refreshUI(BuildContext context) {
    context.read<AppBloc>().add(AppNotifyNotLoading());

    final weatherState = context.read<WeatherBloc>().state;

    final currentWeatherCubit = context.read<CurrentWeatherCubit>()
      ..refreshCurrentWeatherData(weatherState: weatherState);

    final hourlyCubit = context.read<HourlyForecastCubit>()
      ..refreshHourlyData(updatedWeatherState: weatherState);

    context.read<DailyForecastCubit>().refreshDailyData(
          updatedWeatherState: weatherState,
          sortedHourlyList: hourlyCubit.state,
          locationState: context.read<LocationBloc>().state,
        );

    final searchLocalButtonCubit = context.read<LocalWeatherButtonCubit>();

    if (weatherState.status.isSuccess) {
      final bgImageBloc = context.read<BgImageBloc>();

      /// Updating app BG Image if settings are `ImageSettings.dynamic`
      if (bgImageBloc.state.imageSettings.isDynamic &&
          !weatherState.status.isError) {
        bgImageBloc.add(
          BgImageUpdateOnRefresh(
            weatherState: weatherState,
          ),
        );
      }

      if (weatherState.searchIsLocal &&
          currentWeatherCubit.state.data != null) {
        searchLocalButtonCubit.updateSearchLocalWeatherButton(
          weatherState: currentWeatherCubit.state.data!,
          isDay: weatherState.isDay,
        );
      }
    }
  }
}
