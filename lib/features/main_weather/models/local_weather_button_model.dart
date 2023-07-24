import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_weather_button_model.freezed.dart';
part 'local_weather_button_model.g.dart';

@freezed
class LocalWeatherButtonModel with _$LocalWeatherButtonModel {
  const factory LocalWeatherButtonModel({
    @Default(0) int temp,
    @Default('') String condition,
    @Default(true) bool isDay,
    @Default(false) bool tempUnitsMetric,
  }) = _LocalWeatherButtonModel;

  factory LocalWeatherButtonModel.fromWeatherModel({
    required WeatherResponseModel model,
    required UnitSettings unitSettings,
    required bool isDay,
  }) {
    final weatherData = model.currentCondition;
    final currentModel = CurrentWeatherModel.fromWeatherData(
      data: weatherData,
      unitSettings: unitSettings,
    );

    return LocalWeatherButtonModel(
      temp: currentModel.temp,
      condition: currentModel.condition,
      isDay: isDay,
      tempUnitsMetric: unitSettings.tempUnitsMetric,
    );
  }
  factory LocalWeatherButtonModel.fromJson(Map<String, dynamic> json) =>
      _$LocalWeatherButtonModelFromJson(json);
}
