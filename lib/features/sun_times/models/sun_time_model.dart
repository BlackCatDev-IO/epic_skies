import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/daily_data/daily_data_model.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';

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
    required WeatherState weatherState,
    required DailyData data,
  }) {
    final offset =
        Duration(milliseconds: weatherState.refTimes.timezoneOffsetInMs);
    final sunriseTime =
        DateTime.fromMillisecondsSinceEpoch(data.sunriseEpoch!.round() * 1000)
            .add(offset);
    final sunsetTime =
        DateTime.fromMillisecondsSinceEpoch(data.sunsetEpoch!.round() * 1000)
            .add(offset);

    return SunTimesModel(
      sunriseTime: sunriseTime,
      sunsetTime: sunsetTime,
      sunriseString: DateTimeFormatter.formatFullTime(
        time: sunriseTime,
        timeIn24Hrs: weatherState.unitSettings.timeIn24Hrs,
      ),
      sunsetString: DateTimeFormatter.formatFullTime(
        time: sunsetTime,
        timeIn24Hrs: weatherState.unitSettings.timeIn24Hrs,
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
