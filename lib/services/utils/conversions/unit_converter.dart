import 'package:get/get.dart';

class UnitConverter {
  const UnitConverter();

  int toCelcius(int temp) => ((temp - 32) * 5 / 9).round();

  double convertFeetPerSecondToMph(num feet) =>
      (feet / 1.467).toDouble().toPrecision(1);

  double convertInchesToMillimeters(num? inches) {
    if (inches == 0.0 || inches == 0) {
      return 0;
    } else {
      return (inches! * 25.4).toDouble().toPrecision(2);
    }
  }

  int convertMilesToKph(num miles) => (miles * 1.609344).round();
}
