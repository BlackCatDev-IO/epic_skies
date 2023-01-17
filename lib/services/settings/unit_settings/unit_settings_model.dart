import 'dart:convert';

import 'package:equatable/equatable.dart';

class UnitSettings extends Equatable {
  const UnitSettings({
    required this.tempUnitsMetric,
    required this.timeIn24Hrs,
    required this.precipInMm,
    required this.speedInKph,
  });

  /// only one global unit settings object so id will always be 1

  final bool tempUnitsMetric;
  final bool timeIn24Hrs;
  final bool precipInMm;
  final bool speedInKph;

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
  String toString() {
    return '''
     tempUnitsMetric: $tempUnitsMetric
     timeIn24Hrs: $timeIn24Hrs
     precipInMm: $precipInMm
     speedInKph: $speedInKph
''';
  }

  @override
  List<Object?> get props => [
        tempUnitsMetric,
        timeIn24Hrs,
        precipInMm,
        speedInKph,
      ];

  Map<String, dynamic> toMap() {
    return {
      'tempUnitsMetric': tempUnitsMetric,
      'timeIn24Hrs': timeIn24Hrs,
      'precipInMm': precipInMm,
      'speedInKph': speedInKph,
    };
  }

  factory UnitSettings.fromMap(Map<String, dynamic> map) {
    return UnitSettings(
      tempUnitsMetric: (map['tempUnitsMetric'] as bool?) ?? false,
      timeIn24Hrs: (map['timeIn24Hrs'] as bool?) ?? false,
      precipInMm: (map['precipInMm'] as bool?) ?? false,
      speedInKph: (map['speedInKph'] as bool?) ?? false,
    );
  }

  String toJson() => json.encode(toMap());
}
