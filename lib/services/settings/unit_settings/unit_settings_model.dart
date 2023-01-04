import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class UnitSettings extends Equatable {
  const UnitSettings({
    this.id = 1,
    required this.tempUnitsMetric,
    required this.timeIn24Hrs,
    required this.precipInMm,
    required this.speedInKph,
  });

  /// only one global unit settings object so id will always be 1
  @Id(assignable: true)
  final int id;
  final bool tempUnitsMetric;
  final bool timeIn24Hrs;
  final bool precipInMm;
  final bool speedInKph;

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
      tempUnitsMetric: map['tempUnitsMetric'] as bool,
      timeIn24Hrs: map['timeIn24Hrs'] as bool,
      precipInMm: map['precipInMm'] as bool,
      speedInKph: map['speedInKph'] as bool,
    );
  }

  UnitSettings copyWith({
    bool? tempUnitsMetric,
    bool? timeIn24Hrs,
    bool? precipInMm,
    bool? speedInKph,
  }) {
    return UnitSettings(
      tempUnitsMetric: tempUnitsMetric ?? this.tempUnitsMetric,
      timeIn24Hrs: timeIn24Hrs ?? this.timeIn24Hrs,
      precipInMm: precipInMm ?? this.precipInMm,
      speedInKph: speedInKph ?? this.speedInKph,
    );
  }

  @override
  List<Object?> get props => [
        tempUnitsMetric,
        timeIn24Hrs,
        precipInMm,
        speedInKph,
      ];
}
