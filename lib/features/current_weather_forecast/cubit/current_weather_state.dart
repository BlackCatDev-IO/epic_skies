import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';

part 'current_weather_state.mapper.dart';

@MappableClass()
class CurrentWeatherState with CurrentWeatherStateMappable {
  CurrentWeatherState({
    required this.currentTimeString,
    this.data,
  });

  factory CurrentWeatherState.initial() => CurrentWeatherState(
        currentTimeString: '',
        data: CurrentWeatherModel.initial(),
      );

  final String currentTimeString;
  final CurrentWeatherModel? data;

  static const fromMap = CurrentWeatherStateMapper.fromMap;
}
