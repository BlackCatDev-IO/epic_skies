import 'package:dart_mappable/dart_mappable.dart';

part 'unit_settings_model.mapper.dart';

@MappableClass()
class UnitSettings with UnitSettingsMappable {
  const UnitSettings({
    this.tempUnitsMetric = false,
    this.timeIn24Hrs = false,
    this.precipInMm = false,
    this.speedInKph = false,
  });

  final bool tempUnitsMetric;
  final bool timeIn24Hrs;
  final bool precipInMm;
  final bool speedInKph;

  static const fromMap = UnitSettingsMapper.fromMap;
}
