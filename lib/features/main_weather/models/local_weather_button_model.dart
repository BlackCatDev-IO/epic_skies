import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
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
      isDay = TimeZoneUtil.getCurrentIsDay(
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

      isDay = TimeZoneUtil.getCurrentIsDayFromWeatherKit(
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
  factory LocalWeatherButtonModel.fromJson(Map<String, dynamic> json) =>
      _$LocalWeatherButtonModelFromJson(json);
}
