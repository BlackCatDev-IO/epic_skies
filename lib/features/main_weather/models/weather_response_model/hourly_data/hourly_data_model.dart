import 'package:freezed_annotation/freezed_annotation.dart';

part 'hourly_data_model.freezed.dart';
part 'hourly_data_model.g.dart';

@freezed
class HourlyData with _$HourlyData {
  factory HourlyData({
    required int datetimeEpoch,
    required num temp,
    required num feelslike,
    required String conditions,
    num? windspeed,
    double? humidity,
    double? dew,
    num? precip,
    num? precipprob,
    num? snow,
    double? snowdepth,
    List<dynamic>? preciptype,
    double? windgust,
    double? winddir,
    double? pressure,
    double? visibility,
    double? cloudcover,
    double? solarradiation,
    double? solarenergy,
    num? uvindex,
    num? severerisk,
    String? icon,
    String? source,
  }) = _HourlyData;

  factory HourlyData.fromJson(Map<String, dynamic> json) =>
      _$HourlyDataFromJson(json);
}
