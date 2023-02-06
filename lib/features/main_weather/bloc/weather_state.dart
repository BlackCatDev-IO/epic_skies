// ignore_for_file: invalid_annotation_target

import 'package:epic_skies/core/error_handling/error_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_state.freezed.dart';
part 'weather_state.g.dart';

enum WeatherStatus { initial, loading, success, unitSettingsUpdate, error }

extension WeatherStatusX on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isUnitSettingsUpdate => this == WeatherStatus.unitSettingsUpdate;
  bool get isError => this == WeatherStatus.error;
}

@freezed
class WeatherState with _$WeatherState {
  const factory WeatherState({
    WeatherResponseModel? weatherModel,
    @Default(WeatherStatus.initial) WeatherStatus status,
    @Default(true) bool searchIsLocal,
    @Default(UnitSettings()) UnitSettings unitSettings,
    @Default([]) List<SunTimesModel> refererenceSuntimes,
    @Default(true) bool isDay,
    @JsonKey(ignore: true) ErrorModel? errorModel,
  }) = _WeatherState;

  factory WeatherState.error({
    required Exception exception,
  }) =>
      WeatherState(
        status: WeatherStatus.error,
        errorModel: ErrorModel.fromException(exception),
      );

  factory WeatherState.fromJson(Map<String, dynamic> json) =>
      _$WeatherStateFromJson(json);
}
