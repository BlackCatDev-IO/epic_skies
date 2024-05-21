import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Unit Conversions', () {
    test('convert fahrenheit to celcius', () {
      expect(UnitConverter.toCelcius(45), 7);
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
      expect(UnitConverter.convertMphToKph(mph: 11), 18);
    });

    test('convert speed converts to metric when speedInKph is true', () {
      const mph = 12;
      const kph = 19;
      expect(UnitConverter.convertSpeed(speedInKph: true, speed: kph), kph);
      expect(UnitConverter.convertSpeed(speedInKph: false, speed: kph), mph);
    });

    test('convert temp units on user unit setting change', () {
      const metricTemp = -10;
      const fahrenheitTemp = 14;
      expect(
        UnitConverter.convertTemp(tempUnitsMetric: true, temp: metricTemp),
        metricTemp,
      );

      expect(
        UnitConverter.convertTemp(tempUnitsMetric: false, temp: metricTemp),
        fahrenheitTemp,
      );
    });

    test('convert precip units on user unit setting change', () {
      const mm = 20.32;
      const inches = 0.8;

      expect(
        UnitConverter.convertPrecipUnits(precipInMm: true, precip: mm),
        mm,
      );

      expect(
        UnitConverter.convertPrecipUnits(precipInMm: false, precip: mm),
        inches,
      );
    });
  });
}
