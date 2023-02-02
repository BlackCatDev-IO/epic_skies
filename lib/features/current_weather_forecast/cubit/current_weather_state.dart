import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_weather_state.freezed.dart';
part 'current_weather_state.g.dart';

@freezed
class CurrentWeatherState with _$CurrentWeatherState {
  const factory CurrentWeatherState({
    required String currentTimeString,
    required CurrentWeatherModel? data,
  }) = _CurrentWeatherState;

  factory CurrentWeatherState.fromJson(Map<String, Object?> json) =>
      _$CurrentWeatherStateFromJson(json);

  factory CurrentWeatherState.initial() => CurrentWeatherState(
        currentTimeString: '',
        data: CurrentWeatherModel.initial(),
      );
}
