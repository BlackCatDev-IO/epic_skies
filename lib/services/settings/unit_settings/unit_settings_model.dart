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

  @Id(assignable: true)
  int id;
  bool tempUnitsMetric;
  bool timeIn24Hrs;
  bool precipInMm;
  bool speedInKph;
}
