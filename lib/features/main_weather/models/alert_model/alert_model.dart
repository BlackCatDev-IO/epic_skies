import 'package:dart_mappable/dart_mappable.dart';

part 'alert_model.mapper.dart';

@MappableEnum()
enum PrecipNoticeType {
  noPrecip,
  currentPrecip,
  forecastedPrecip;

  bool get isNoPrecip => this == PrecipNoticeType.noPrecip;
  bool get isCurrentPrecip => this == PrecipNoticeType.currentPrecip;
  bool get isForecastedPrecip => this == PrecipNoticeType.forecastedPrecip;
}

@MappableClass()
class AlertModel with AlertModelMappable {
  const AlertModel({
    required this.precipAlertType,
    this.precipNoticeIconPath = '',
    this.precipNoticeMessage = '',
    this.weatherAlertMessage = '',
    this.alertSource = '',
    this.alertAreaName = '',
  });

  final PrecipNoticeType precipAlertType;
  final String precipNoticeIconPath;
  final String precipNoticeMessage;
  final String weatherAlertMessage;
  final String alertSource;
  final String alertAreaName;

}
