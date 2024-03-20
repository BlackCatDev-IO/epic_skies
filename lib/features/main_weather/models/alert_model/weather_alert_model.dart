import 'package:dart_mappable/dart_mappable.dart';

part 'weather_alert_model.mapper.dart';

@MappableClass()
class WeatherAlertModel with WeatherAlertModelMappable {
  const WeatherAlertModel({
    required this.weatherAlertMessage,
    required this.alertSource,
    required this.alertAreaName,
    required this.detailsUrl,
  });

  const WeatherAlertModel.noAlert()
      : weatherAlertMessage = '',
        alertSource = '',
        alertAreaName = '',
        detailsUrl = '';

  final String weatherAlertMessage;
  final String alertSource;
  final String alertAreaName;
  final String detailsUrl;
}
