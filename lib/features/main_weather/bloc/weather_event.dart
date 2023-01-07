part of 'weather_bloc.dart';

abstract class WeatherEvent {
  const WeatherEvent();
}

class LocalWeatherUpdated extends WeatherEvent {
  @override
  String toString() {
    return 'LocalWeatherUpdated';
  }
}

class RemoteWeatherUpdated extends WeatherEvent {
  const RemoteWeatherUpdated({required this.searchSuggestion});

  final SearchSuggestion searchSuggestion;
  @override
  String toString() {
    return 'RemoteWeatherUpdated: SearchSuggestion: $searchSuggestion';
  }
}

class UnitSettingsUpdated extends WeatherEvent {
  const UnitSettingsUpdated({required this.unitSettings});

  final UnitSettings unitSettings;

  @override
  String toString() {
    return 'UnitSettingsUpdated unitSettings: $unitSettings';
  }
}

class RefreshWeatherData extends WeatherEvent {
  @override
  String toString() {
    return 'RefreshWeatherData';
  }
}
