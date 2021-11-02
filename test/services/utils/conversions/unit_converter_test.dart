import 'package:epic_skies/services/utils/conversions/unit_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Unit Conversions', () {
    test('convert fahrenheit to celcius', () {
      expect(UnitConverter.toCelcius(temp: 45), 7);
    });

    test('convert Feet Per Second To Mph', () {
      expect(
        UnitConverter.convertFeetPerSecondToMph(feetPerSecond: 4.47),
        3.0,
      );
    });

    test('convert Inches To Millimeters', () {
      expect(UnitConverter.convertInchesToMillimeters(inches: 6.5), 165.1);
    });

    test('convertInchesToMillimeters returns 0 when give 0.0', () {
      expect(UnitConverter.convertInchesToMillimeters(inches: 0.0), 0);
    });

    test('convertInchesToMillimeters returns 0 when give 0', () {
      expect(UnitConverter.convertInchesToMillimeters(inches: 0), 0);
    });

    test('convert Miles To Kph', () {
      expect(UnitConverter.convertMilesToKph(miles: 11), 18);
    });
  });
}
