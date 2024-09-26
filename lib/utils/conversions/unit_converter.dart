import 'package:epic_skies/extensions/num_extensions.dart';

class UnitConverter {
  static int convertTemp({required num temp, required bool tempUnitsMetric}) {
    return tempUnitsMetric ? temp.toInt() : toFahrenheight(temp);
  }

  static int convertSpeed({required num speed, required bool speedInKph}) {
    return speedInKph ? speed.toInt() : convertKphToMph(kph: speed);
  }

  static double convertPrecipUnits({
    required num precip,
    required bool precipInMm,
  }) {
    return precipInMm ? precip.toDouble() : convertMmToInches(mm: precip);
  }

  static int toCelcius(num temp) => ((temp - 32) * 5 / 9).round();

  static int toFahrenheight(num temp) => ((temp * 1.8) + 32).toInt();

  static double convertInchesToMillimeters({required num inches}) {
    if (inches == 0.0 || inches == 0) {
      return 0;
    } else {
      return (inches * 25.4).toPrecision(2);
    }
  }

  static double convertMmToInches({required num mm}) {
    if (mm == 0.0 || mm == 0) {
      return 0;
    }

    return mm / 25.4;
  }

  static int convertMphToKph({required num mph}) => (mph * 1.609344).round();

  static int convertKphToMph({required num kph}) =>
      (kph * 0.6213711922).round();
}
