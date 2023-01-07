import 'dart:convert';

import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';

import '../../current_weather_forecast/models/current_weather_model.dart';

class SearchLocalWeatherButtonModel {
  const SearchLocalWeatherButtonModel({
    required this.temp,
    required this.condition,
    required this.isDay,
    required this.tempUnitsMetric,
  });

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

  factory SearchLocalWeatherButtonModel.fromMap(Map<String, dynamic> map) {
    return SearchLocalWeatherButtonModel(
      temp: map['temp'] as int,
      condition: map['condition'] as String,
      isDay: map['isDay'] as bool,
      tempUnitsMetric: map['tempUnitsMetric'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchLocalWeatherButtonModel.fromJson(String source) =>
      SearchLocalWeatherButtonModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  factory SearchLocalWeatherButtonModel.fromWeatherModel({
    required WeatherResponseModel model,
    required UnitSettings unitSettings,
    required bool isDay,
  }) {
    final weatherData = model.currentCondition;
    final currentModel = CurrentWeatherModel.fromWeatherData(
      data: weatherData!,
      unitSettings: unitSettings,
    );

    return SearchLocalWeatherButtonModel(
      temp: currentModel.temp,
      condition: currentModel.condition,
      isDay: isDay,
      tempUnitsMetric: unitSettings.tempUnitsMetric,
    );
  }
}
