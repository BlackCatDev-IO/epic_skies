import 'package:freezed_annotation/freezed_annotation.dart';

part 'unit_settings_model.freezed.dart';

part 'unit_settings_model.g.dart';

@freezed
class UnitSettings with _$UnitSettings {
  const factory UnitSettings({
    @Default(false) bool tempUnitsMetric,
    @Default(false) bool timeIn24Hrs,
    @Default(false) bool precipInMm,
    @Default(false) bool speedInKph,
  }) = _UnitSettings;

  factory UnitSettings.fromJson(Map<String, Object?> json) =>
      _$UnitSettingsFromJson(json);

  factory UnitSettings.initial() => const UnitSettings();
}
