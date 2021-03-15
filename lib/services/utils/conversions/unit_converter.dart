class UnitConverter {
  const UnitConverter();

  int convertToCelcius(int temp) => ((temp - 32) * 5 / 9).round();

  int convertToFahrenHeight(int temp) => ((temp * 9 / 5) + 32).round();

  num convertInchesToMillimeters(num inches) => inches * 25.4;

  num convertMillimetersToInches(num mm) => mm / 25.4;
}
