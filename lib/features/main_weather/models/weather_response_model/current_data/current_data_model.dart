import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_data_model.freezed.dart';
part 'current_data_model.g.dart';

@freezed
class CurrentData with _$CurrentData {
  factory CurrentData({
    required int datetimeEpoch,
    required String conditions,
    required num temp,
    required num feelslike,
    num? windspeed,
    double? humidity,
    double? dew,
    num? precip,
    num? precipprob,
    num? snow,
    num? snowdepth,
    List<dynamic>? preciptype,
    num? windgust,
    num? winddir,
    num? pressure,
    num? visibility,
    num? cloudcover,
    num? solarradiation,
    double? solarenergy,
    num? uvindex,
    String? icon,
    String? source,
    String? sunrise,
    num? sunriseEpoch,
    String? sunset,
    num? sunsetEpoch,
    double? moonphase,
  }) = _CurrentData;

  factory CurrentData.fromJson(Map<String, dynamic> json) =>
      _$CurrentDataFromJson(json);
}
