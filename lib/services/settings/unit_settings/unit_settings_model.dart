import 'dart:convert';

import 'package:objectbox/objectbox.dart';

@Entity()
class UnitSettings {
  UnitSettings({
    required this.id,
    required this.tempUnitsMetric,
    required this.timeIn24Hrs,
    required this.precipInMm,
    required this.speedInKph,
  });

  /// only one global unit settings object so id will always be 1
  @Id(assignable: true)
  int id;
  bool tempUnitsMetric;
  bool timeIn24Hrs;
  bool precipInMm;
  bool speedInKph;

  String toRawJson() {
    final map = {
      'id': 1,
      'tempUnitsMetric': tempUnitsMetric,
      'timeIn24Hrs': timeIn24Hrs,
      'precipInMm': precipInMm,
      'speedInKph': speedInKph,
    };

    return json.encode(map);
  }

  factory UnitSettings.fromRawJson(String rawJson) {
    final map = json.decode(rawJson) as Map;

    return UnitSettings(
      id: 1,
      tempUnitsMetric: map['tempUnitsMetric'] as bool,
      timeIn24Hrs: map['timeIn24Hrs'] as bool,
      precipInMm: map['precipInMm'] as bool,
      speedInKph: map['speedInKph'] as bool,
    );
  }
}
