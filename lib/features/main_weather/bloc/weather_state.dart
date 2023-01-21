import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../services/settings/unit_settings/unit_settings_model.dart';
import '../../sun_times/models/sun_time_model.dart';
import '../models/search_local_weather_button_model.dart';
import '../models/weather_response_model/weather_data_model.dart';

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
    @Default(false) bool isLoading,
    @Default(true) bool searchIsLocal,
    @Default(UnitSettings()) UnitSettings unitSettings,
    @Default(SearchLocalWeatherButtonModel())
        SearchLocalWeatherButtonModel searchButtonModel,
    @Default([]) List<SunTimesModel> refererenceSuntimes,
    @Default(true) bool isDay,
    @JsonKey(ignore: true) Exception? exception,
  }) = _WeatherState;

  factory WeatherState.error({
    required Exception exception,
  }) =>
      WeatherState(
        status: WeatherStatus.error,
        exception: exception,
      );

  factory WeatherState.fromJson(Map<String, dynamic> json) =>
      _$WeatherStateFromJson(json);
}
