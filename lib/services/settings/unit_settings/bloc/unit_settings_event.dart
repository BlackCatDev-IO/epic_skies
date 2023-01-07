part of 'unit_settings_bloc.dart';

abstract class UnitSettingsEvent {
  const UnitSettingsEvent();
}

class TempUnitUpdated extends UnitSettingsEvent {}

class TimeIn24HoursUpdated extends UnitSettingsEvent {}

class PrecipInMmUpdated extends UnitSettingsEvent {}

class SpeedInKphUpdated extends UnitSettingsEvent {}
