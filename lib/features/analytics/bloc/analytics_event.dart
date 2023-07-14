part of 'analytics_bloc.dart';

const _location = 'location_info_';
const _weather = 'weather_info_';
const _requested = 'requested';
const _acquired = 'acquired';
const _unitSettings = 'unit_settings_updated';
const _error = 'error';
const _iap = 'iap_';
const _trialEnded = 'trial_ended_';

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
  UnitSettingsUpdate({required this.unitSettings}) : super(name: _unitSettings);

  final UnitSettings unitSettings;

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

/* ------------------------- In App Purchase Events ------------------------- */

abstract class IapAnalyticsEvent extends BaseAnalyticsEvent {
  IapAnalyticsEvent({required this.name}) : super(eventPrefix: _iap);

  final String name;

  String get eventName => '$eventPrefix$name';
  String get baseLogInfo => 'Analytics: $eventName';
}

class IapPurchaseAttempted extends IapAnalyticsEvent {
  IapPurchaseAttempted() : super(name: 'attempted');

  @override
  String toString() {
    return baseLogInfo;
  }
}

class IapRestorePurchaseAttempted extends IapAnalyticsEvent {
  IapRestorePurchaseAttempted() : super(name: 'restore_attempted');

  @override
  String toString() {
    return baseLogInfo;
  }
}

class IapPurchaseSuccess extends IapAnalyticsEvent {
  IapPurchaseSuccess() : super(name: 'success');

  @override
  String toString() {
    return baseLogInfo;
  }
}

class IapPurchaseError extends IapAnalyticsEvent {
  IapPurchaseError(this.error) : super(name: 'error');

  final String error;

  @override
  String toString() {
    return '$baseLogInfo : $error';
  }
}

class IapTrialEnded extends IapAnalyticsEvent {
  IapTrialEnded() : super(name: _trialEnded);

  @override
  String toString() {
    return baseLogInfo;
  }
}

class GeneralLogEvent extends BaseAnalyticsEvent {
  GeneralLogEvent({required super.eventPrefix});

  @override
  String toString() {
    return eventPrefix;
  }
}
