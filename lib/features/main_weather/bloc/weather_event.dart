part of 'weather_bloc.dart';

abstract class WeatherEvent {
  const WeatherEvent();
}

class WeatherUpdate extends WeatherEvent {
  const WeatherUpdate({
    required this.lat,
    required this.long,
    required this.searchIsLocal,
  });

  final double lat;
  final double long;
  final bool searchIsLocal;

  @override
  String toString() {
    return 'LocalWeatherUpdated';
  }
}

class WeatherUnitSettingsUpdate extends WeatherEvent {
  const WeatherUnitSettingsUpdate({required this.unitSettings});

  final UnitSettings unitSettings;

  @override
  String toString() {
    return 'UnitSettingsUpdated unitSettings: $unitSettings';
  }
}
