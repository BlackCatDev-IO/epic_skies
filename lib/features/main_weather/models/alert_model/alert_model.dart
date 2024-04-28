import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/features/main_weather/models/alert_model/precip_notice_model.dart';
import 'package:epic_skies/features/main_weather/models/alert_model/weather_alert_model.dart';

part 'alert_model.mapper.dart';

@MappableClass()
class AlertModel with AlertModelMappable {
  const AlertModel({
    required this.precipNotice,
    required this.weatherAlert,
  });

  const AlertModel.none()
      : precipNotice = const PrecipNoticeModel.noPrecip(),
        weatherAlert = const WeatherAlertModel.noAlert();

  final PrecipNoticeModel precipNotice;
  final WeatherAlertModel weatherAlert;
}
