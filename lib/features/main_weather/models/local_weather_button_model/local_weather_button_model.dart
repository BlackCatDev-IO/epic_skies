// ignore_for_file: sort_constructors_first

import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';

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

  factory LocalWeatherButtonModel.fromCurrentWeather({
    required CurrentWeatherModel currentWeatherModel,
    required bool isDay,
  }) {
    return LocalWeatherButtonModel(
      temp: currentWeatherModel.temp,
      condition: currentWeatherModel.condition,
      isDay: isDay,
      tempUnitsMetric: currentWeatherModel.unitSettings.tempUnitsMetric,
    );
  }

  static const fromMap = LocalWeatherButtonModelMapper.fromMap;
}
