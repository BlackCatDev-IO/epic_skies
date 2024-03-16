enum PrecipAlertType {
  noPrecip,
  currentPrecip,
  forecastedPrecip;

  bool get isPrecip => this != PrecipAlertType.noPrecip;
  bool get isCurrentPrecip => this == PrecipAlertType.currentPrecip;
  bool get isForecastedPrecip => this == PrecipAlertType.forecastedPrecip;
}

class PrecipAlertModel {
  PrecipAlertModel({
    required this.precipAlertType,
    this.precipAlertMessage = '',
    this.precipAlertIconPath = '',
  });

  final PrecipAlertType precipAlertType;
  final String precipAlertMessage;
  final String precipAlertIconPath;
}
