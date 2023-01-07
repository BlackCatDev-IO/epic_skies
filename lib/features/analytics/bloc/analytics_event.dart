part of 'analytics_bloc.dart';

const _location = 'location_info_';
const _weather = 'weather_info_';
const _requested = 'requested';
const _acquired = 'acquired';
const _unitSettings = 'unit_settings_updated';
const _error = 'error';

abstract class BaseAnalyticsEvent {
  BaseAnalyticsEvent({required this.eventPrefix});

  final String eventPrefix;
}

abstract class LocationAnalyticsEvent extends BaseAnalyticsEvent {
  LocationAnalyticsEvent({required this.name}) : super(eventPrefix: _location);

  final String name;

  String get eventName => '$eventPrefix$name';
  String get baseLogInfo => 'Analytics: $eventName';
}

class LocationRequested extends LocationAnalyticsEvent {
  LocationRequested() : super(name: _requested);

  @override
  String toString() {
    return baseLogInfo;
  }
}

class LocalLocationAcquired extends LocationAnalyticsEvent {
  LocalLocationAcquired() : super(name: _acquired);

  @override
  String toString() {
    return baseLogInfo;
  }
}

class LocalLocationError extends LocationAnalyticsEvent {
  LocalLocationError() : super(name: _error);

  @override
  String toString() {
    return baseLogInfo;
  }
}

abstract class WeatherAnalyticsEvent extends BaseAnalyticsEvent {
  WeatherAnalyticsEvent({required this.name}) : super(eventPrefix: _weather);

  final String name;

  String get eventName => '$eventPrefix$name';
  String get baseLogInfo => 'Analytics: $eventName';
}

class WeatherInfoRequested extends WeatherAnalyticsEvent {
  WeatherInfoRequested() : super(name: 'requested');

  @override
  String toString() {
    return baseLogInfo;
  }
}

class WeatherInfoAcquired extends WeatherAnalyticsEvent {
  WeatherInfoAcquired({required this.condition}) : super(name: _acquired);

  final String condition;

  @override
  String toString() {
    return baseLogInfo;
  }
}

class UnitSettingsUpdate extends WeatherAnalyticsEvent {
  UnitSettingsUpdate() : super(name: _unitSettings);

  @override
  String toString() {
    return baseLogInfo;
  }
}

class WeatherInfoError extends WeatherAnalyticsEvent {
  WeatherInfoError() : super(name: _error);

  @override
  String toString() {
    return baseLogInfo;
  }
}
