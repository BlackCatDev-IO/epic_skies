import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/core/network/weather_kit/models/daily/day_weather_conditions.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/daily_data/daily_data_model.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';

part 'sun_time_model.mapper.dart';

@MappableClass()
class SunTimesModel with SunTimesModelMappable {
  SunTimesModel({
    required this.sunriseString,
    required this.sunsetString,
    this.sunriseTime,
    this.sunsetTime,
  });

  factory SunTimesModel.fromDailyData({
    required DailyData data,
    required UnitSettings unitSettings,
    required bool searchIsLocal,
  }) {
    final timezoneUtil = getIt<TimeZoneUtil>();
    final sunriseTime = timezoneUtil.secondsFromEpoch(
      secondsSinceEpoch: data.sunriseEpoch!.round(),
      searchIsLocal: searchIsLocal,
    );

    final sunsetTime = timezoneUtil.secondsFromEpoch(
      secondsSinceEpoch: data.sunsetEpoch!.round(),
      searchIsLocal: searchIsLocal,
    );

    return SunTimesModel(
      sunriseTime: sunriseTime,
      sunsetTime: sunsetTime,
      sunriseString: DateTimeFormatter.formatFullTime(
        time: sunriseTime,
        timeIn24Hrs: unitSettings.timeIn24Hrs,
      ),
      sunsetString: DateTimeFormatter.formatFullTime(
        time: sunsetTime,
        timeIn24Hrs: unitSettings.timeIn24Hrs,
      ),
    );
  }

  factory SunTimesModel.fromWeatherKit({
    required DayWeatherConditions data,
    required UnitSettings unitSettings,
  }) {
    final sunriseTime = data.sunrise!.addTimezoneOffset();
    final sunsetTime = data.sunset!.addTimezoneOffset();

    return SunTimesModel(
      sunriseTime: sunriseTime,
      sunsetTime: sunsetTime,
      sunriseString: DateTimeFormatter.formatFullTime(
        time: sunriseTime,
        timeIn24Hrs: unitSettings.timeIn24Hrs,
      ),
      sunsetString: DateTimeFormatter.formatFullTime(
        time: sunsetTime,
        timeIn24Hrs: unitSettings.timeIn24Hrs,
      ),
    );
  }

  final String sunsetString;
  final String sunriseString;
  final DateTime? sunriseTime;
  final DateTime? sunsetTime;

  static const fromMap = SunTimesModelMapper.fromMap;
}

extension Clone on SunTimesModel {
  SunTimesModel clone() {
    return SunTimesModel(
      sunsetString: sunsetString,
      sunriseString: sunriseString,
      sunriseTime: sunriseTime,
      sunsetTime: sunsetTime,
    );
  }
}
