import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';
import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
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
    required Weather weather,
    required UnitSettings unitSettings,
    required bool isDay,
  }) {
    final currentModel = CurrentWeatherModel.fromWeatherData(
      data: weather.currentWeather,
      unitSettings: unitSettings,
    );

    return LocalWeatherButtonModel(
      temp: currentModel.temp,
      condition:
          WeatherCodeConverter.convertWeatherKitCodes(currentModel.condition),
      isDay: isDay,
      tempUnitsMetric: unitSettings.tempUnitsMetric,
    );
  }
  factory LocalWeatherButtonModel.fromJson(Map<String, dynamic> json) =>
      _$LocalWeatherButtonModelFromJson(json);
}
