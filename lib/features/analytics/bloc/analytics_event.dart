part of 'analytics_bloc.dart';

const _location = 'location_info_';
const _remoteLocation = 'remote_search';
const _weather = 'weather_info_';
const _acquired = 'acquired';
const _alert = 'alert';
const _disabled = 'disabled';
const _noPermission = 'no_permission';
const _unitSettings = 'unit_settings_updated';
const _error = 'error';
const _formatError = '_format_error';

abstract class BaseAnalyticsEvent {
  BaseAnalyticsEvent({required this.eventPrefix});

  final String eventPrefix;
}

/* ----------------------------- Location Events ---------------------------- */

abstract class LocationAnalyticsEvent extends BaseAnalyticsEvent {
  LocationAnalyticsEvent({required this.name}) : super(eventPrefix: _location);

  final String name;

  String get eventName => '$eventPrefix$name';
  String get baseLogInfo => 'Analytics: $eventName';
}

class RemoteLocationRequested extends LocationAnalyticsEvent {
  RemoteLocationRequested({required this.searchSuggestion})
      : super(name: _remoteLocation);

  final SearchSuggestion searchSuggestion;

  @override
  String toString() {
    return _remoteLocation;
  }
}

class LocalLocationAcquired extends LocationAnalyticsEvent {
  LocalLocationAcquired({
    required this.locationModel,
  }) : super(name: _acquired);

  final LocationModel locationModel;

  @override
  String toString() {
    return baseLogInfo;
  }
}

class LocationDisabled extends LocationAnalyticsEvent {
  LocationDisabled() : super(name: _disabled);

  @override
  String toString() {
    return baseLogInfo;
  }
}

class LocationNoPermission extends LocationAnalyticsEvent {
  LocationNoPermission() : super(name: _noPermission);

  @override
  String toString() {
    return baseLogInfo;
  }
}

class LocalLocationError extends LocationAnalyticsEvent {
  LocalLocationError({required this.error}) : super(name: _error);

  final String error;

  @override
  String toString() {
    return baseLogInfo;
  }
}

class LocationAddressFormatError extends LocationAnalyticsEvent {
  LocationAddressFormatError({required this.locationModel})
      : super(name: _formatError);

  final LocationModel locationModel;

  @override
  String toString() {
    return baseLogInfo;
  }
}

/* ----------------------------- Weather Events ----------------------------- */

abstract class WeatherAnalyticsEvent extends BaseAnalyticsEvent {
  WeatherAnalyticsEvent({required this.name}) : super(eventPrefix: _weather);

  final String name;

  String get eventName => '$eventPrefix$name';
  String get baseLogInfo => 'Analytics: $eventName';
}

class WeatherInfoAcquired extends WeatherAnalyticsEvent {
  WeatherInfoAcquired({required this.condition}) : super(name: _acquired);

  final String condition;

  @override
  String toString() {
    return baseLogInfo;
  }
}

class WeatherAlertProvided extends WeatherAnalyticsEvent {
  WeatherAlertProvided({
    required this.weather,
    required this.alertModel,
  }) : super(name: _alert);

  final Weather weather;
  final AlertModel alertModel;

  @override
  String toString() {
    return baseLogInfo;
  }
}

class UnitSettingsUpdate extends WeatherAnalyticsEvent {
  UnitSettingsUpdate({required this.unitSettings}) : super(name: _unitSettings);

  final UnitSettings unitSettings;

  @override
  String toString() {
    return baseLogInfo;
  }
}

class WeatherInfoError extends WeatherAnalyticsEvent {
  WeatherInfoError({required this.errorMessage}) : super(name: _error);

  final String errorMessage;

  @override
  String toString() {
    return baseLogInfo;
  }
}

abstract class BgImageAnalyticsEvent extends BaseAnalyticsEvent {
  BgImageAnalyticsEvent({required this.name}) : super(eventPrefix: 'bg_image_');

  final String name;

  String get eventName => '$eventPrefix$name';
  String get baseLogInfo => 'Analytics: $eventName';
}

class NavigationEvent extends BaseAnalyticsEvent {
  NavigationEvent({required this.route}) : super(eventPrefix: 'navigation_');

  final String route;

  String get eventName => '$eventPrefix$route';

  @override
  String toString() {
    return eventName;
  }
}
