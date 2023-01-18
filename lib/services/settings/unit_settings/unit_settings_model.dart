import 'package:freezed_annotation/freezed_annotation.dart';

part 'unit_settings_model.freezed.dart';

part 'unit_settings_model.g.dart';

@freezed
class UnitSettings with _$UnitSettings {
  const factory UnitSettings({
    required bool tempUnitsMetric,
    required bool timeIn24Hrs,
    required bool precipInMm,
    required bool speedInKph,
  }) = _UnitSettings;

  factory UnitSettings.fromJson(Map<String, Object?> json) =>
      _$UnitSettingsFromJson(json);

  factory UnitSettings.initial() => const UnitSettings(
        tempUnitsMetric: false,
        timeIn24Hrs: false,
        precipInMm: false,
        speedInKph: false,
      );
}
