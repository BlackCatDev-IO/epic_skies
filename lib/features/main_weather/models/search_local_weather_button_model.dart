import 'dart:convert';

import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:equatable/equatable.dart';

class SearchLocalWeatherButtonModel extends Equatable {
  const SearchLocalWeatherButtonModel({
    this.temp = 0,
    this.condition = '',
    this.isDay = true,
    this.tempUnitsMetric = false,
  });
  factory SearchLocalWeatherButtonModel.fromWeatherModel({
    required WeatherResponseModel model,
    required UnitSettings unitSettings,
    required bool isDay,
  }) {
    final weatherData = model.currentCondition;
    final currentModel = CurrentWeatherModel.fromWeatherData(
      data: weatherData,
      unitSettings: unitSettings,
    );

    return SearchLocalWeatherButtonModel(
      temp: currentModel.temp,
      condition: currentModel.condition,
      isDay: isDay,
      tempUnitsMetric: unitSettings.tempUnitsMetric,
    );
  }

  factory SearchLocalWeatherButtonModel.fromJson(String source) =>
      SearchLocalWeatherButtonModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  factory SearchLocalWeatherButtonModel.fromMap(Map<String, dynamic> map) {
    return SearchLocalWeatherButtonModel(
      temp: map['temp'] as int,
      condition: map['condition'] as String,
      isDay: map['isDay'] as bool,
      tempUnitsMetric: map['tempUnitsMetric'] as bool,
    );
  }

  final int temp;
  final String condition;
  final bool isDay;
  final bool tempUnitsMetric;

  Map<String, dynamic> toMap() {
    return {
      'temp': temp,
      'condition': condition,
      'isDay': isDay,
      'tempUnitsMetric': tempUnitsMetric,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object> get props => [
        temp,
        condition,
        isDay,
        tempUnitsMetric,
      ];
}
