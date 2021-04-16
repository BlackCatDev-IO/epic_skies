import 'package:get/get.dart';

class UnitConverter {
  const UnitConverter();

  int toCelcius(int temp) => ((temp - 32) * 5 / 9).round();

  double convertFeetPerSecondToMph(num feet) =>
      (feet / 1.467).toDouble().toPrecision(2);

  double roundTo2digitsPastDecimal(num precip) {
    if (precip == 0.0 || precip == 0.00 || precip == 0) {
      return 0;
    } else {
      return precip.toDouble().toPrecision(2);
    }
  }

  double convertInchesToMillimeters(num? inches) {
    if (inches == 0.0 || inches == 0) {
      return 0;
    } else {
      return (inches! * 25.4).toDouble().toPrecision(2);
    }
  }

  double convertMilesToKph(num miles) =>
      (miles * 1.609344).toDouble().toPrecision(2);
}
