import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_local_weather_button_model.freezed.dart';
part 'search_local_weather_button_model.g.dart';

@freezed
class SearchLocalWeatherButtonModel with _$SearchLocalWeatherButtonModel {
  const factory SearchLocalWeatherButtonModel({
    @Default(0) int temp,
    @Default('') String condition,
    @Default(true) bool isDay,
    @Default(false) bool tempUnitsMetric,
  }) = _SearchLocalWeatherButtonModel;

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

  factory SearchLocalWeatherButtonModel.fromJson(Map<String, dynamic> json) =>
      _$SearchLocalWeatherButtonModelFromJson(json);
}
