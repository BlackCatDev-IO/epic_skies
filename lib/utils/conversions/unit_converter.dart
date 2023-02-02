import 'package:black_cat_lib/black_cat_lib.dart';

class UnitConverter {
  static int convertTemp({required num temp, required bool tempUnitsMetric}) {
    return tempUnitsMetric ? toCelcius(temp: temp) : temp.toInt();
  }

  static int convertSpeed({required num speed, required bool speedInKph}) {
    return speedInKph ? convertMphToKph(mph: speed) : speed.toInt();
  }

  static double convertPrecipUnits({
    required num precip,
    required bool precipInMm,
  }) {
    return precipInMm
        ? convertInchesToMillimeters(inches: precip)
        : convertMmToInches(mm: precip);
  }

  static int toCelcius({required num temp}) => ((temp - 32) * 5 / 9).round();

  static int toFahrenheight({required num temp}) => ((temp * 1.8) + 32).round();

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

    return (mm / 25.4).toPrecision(2);
  }

  static int convertMphToKph({required num mph}) => (mph * 1.609344).round();

  static int convertKphToMph({required num kph}) =>
      (kph * 0.6213711922).round();
}
