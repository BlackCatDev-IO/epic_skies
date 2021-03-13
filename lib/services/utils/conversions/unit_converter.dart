class UnitConverter {
  const UnitConverter();

  int convertToCelcius(int temp) => ((temp - 32) * 5 / 9).round();

  int convertToFahrenHeight(int temp) => ((temp * 9 / 5) + 32).round();
}
