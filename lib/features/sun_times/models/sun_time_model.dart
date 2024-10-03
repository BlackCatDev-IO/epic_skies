import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/daily_data/daily_data_model.dart';

part 'sun_time_model.mapper.dart';

@MappableClass()
class SunTimesModel with SunTimesModelMappable {
  SunTimesModel({
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
    );
  }

  final DateTime? sunriseTime;
  final DateTime? sunsetTime;

  static const fromMap = SunTimesModelMapper.fromMap;
}
