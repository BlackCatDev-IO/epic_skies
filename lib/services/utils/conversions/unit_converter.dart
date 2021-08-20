import 'package:get/get.dart';

class UnitConverter {
  static int toCelcius(int temp) => ((temp - 32) * 5 / 9).round();

  static double convertFeetPerSecondToMph({required num feetPerSecond}) =>
      (feetPerSecond / 1.467).toDouble().toPrecision(1);

  static double convertInchesToMillimeters({required num inches}) {
    if (inches == 0.0 || inches == 0) {
      return 0;
    } else {
      return (inches * 25.4).toDouble().toPrecision(2);
    }
  }

  static int convertMilesToKph({required num miles}) =>
      (miles * 1.609344).round();
}
