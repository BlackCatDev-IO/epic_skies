import 'package:epic_skies/features/main_weather/models/weather_response_model/hourly_data/hourly_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_data_model.freezed.dart';
part 'daily_data_model.g.dart';

@freezed
class DailyData with _$DailyData {
  factory DailyData({
    required int datetimeEpoch,
    required String conditions,
    required num temp,
    required num feelslike,
    num? windspeed,
    num? tempmax,
    num? tempmin,
    double? feelslikemax,
    double? feelslikemin,
    double? dew,
    double? humidity,
    double? precip,
    double? precipprob,
    double? precipcover,
    List? preciptype,
    num? snow,
    num? snowdepth,
    double? windgust,
    double? winddir,
    double? pressure,
    double? cloudcover,
    double? visibility,
    double? solarradiation,
    double? solarenergy,
    num? uvindex,
    num? severerisk,
    num? sunriseEpoch,
    num? sunsetEpoch,
    double? moonphase,
    String? description,
    String? icon,
    String? source,
    List<HourlyData>? hours,
  }) = _DailyData;

  factory DailyData.fromJson(Map<String, dynamic> json) =>
      _$DailyDataFromJson(json);
}
