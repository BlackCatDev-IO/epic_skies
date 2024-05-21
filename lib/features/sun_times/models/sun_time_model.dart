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

  factory SunTimesModel.fromVisualCrossing({
    required WeatherState weatherState,
    required DailyData data,
  }) {
    DateTime initSuntime(num dateTimeEpoch) {
      final offset = Duration(
        milliseconds: weatherState.refTimes.timezoneOffsetInMs,
      );

      return DateTime.fromMillisecondsSinceEpoch(
        dateTimeEpoch.round() * 1000,
      ).toUtc().add(offset);
    }

    final sunriseTime = initSuntime(data.sunriseEpoch!);
    final sunsetTime = initSuntime(data.sunsetEpoch!);

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
