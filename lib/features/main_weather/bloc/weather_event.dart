part of 'weather_bloc.dart';

abstract class WeatherEvent {
  const WeatherEvent();
}

class WeatherUpdate extends WeatherEvent {
  const WeatherUpdate({
    required this.coordinates,
    required this.searchIsLocal,
    required this.timezone,
    this.countryCode,
    this.languageCode,
  });

  final Coordinates coordinates;
  final bool searchIsLocal;
  final String timezone;
  final String? countryCode;
  final String? languageCode;

  @override
  String toString() {
    return 'WeatherUpdate';
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

class WeatherBackupRequest extends WeatherEvent {
  const WeatherBackupRequest({
    required this.coordinates,
    required this.searchIsLocal,
  });

  final Coordinates coordinates;
  final bool searchIsLocal;

  @override
  String toString() {
    return 'WeatherBackupRequest';
  }
}
