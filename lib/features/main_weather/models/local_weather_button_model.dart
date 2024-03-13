// ignore_for_file: sort_constructors_first

import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:get_it/get_it.dart';

part 'local_weather_button_model.mapper.dart';

@MappableClass()
class LocalWeatherButtonModel with LocalWeatherButtonModelMappable {
  const LocalWeatherButtonModel({
    this.temp = 0,
    this.condition = '',
    this.isDay = true,
    this.tempUnitsMetric = false,
  });

  final int temp;
  final String condition;
  final bool isDay;
  final bool tempUnitsMetric;

  factory LocalWeatherButtonModel.fromWeatherState({
    required WeatherState weatherState,
  }) {
    late final CurrentWeatherModel currentModel;

    late final bool isDay;

    if (weatherState.useBackupApi) {
      currentModel = CurrentWeatherModel.fromBackupApi(
        data: weatherState.weatherModel!.currentCondition,
        unitSettings: weatherState.unitSettings,
      );
      isDay = GetIt.I<TimeZoneUtil>().getCurrentIsDay(
        searchIsLocal: weatherState.searchIsLocal,
        refSuntimes: weatherState.refererenceSuntimes,
        refTimeEpochInSeconds:
            weatherState.weatherModel!.currentCondition.datetimeEpoch,
      );
    } else {
      currentModel = CurrentWeatherModel.fromWeatherKit(
        data: weatherState.weather!.currentWeather,
        unitSettings: weatherState.unitSettings,
      );

      isDay = GetIt.I<TimeZoneUtil>().getCurrentIsDayFromWeatherKit(
        searchIsLocal: weatherState.searchIsLocal,
        refSuntimes: weatherState.refererenceSuntimes,
        referenceTime: weatherState.weather!.currentWeather.asOf,
      );
    }

    return LocalWeatherButtonModel(
      temp: currentModel.temp,
      condition:
          WeatherCodeConverter.convertWeatherKitCodes(currentModel.condition),
      isDay: isDay,
      tempUnitsMetric: weatherState.unitSettings.tempUnitsMetric,
    );
  }

  static const fromMap = LocalWeatherButtonModelMapper.fromMap;
}
