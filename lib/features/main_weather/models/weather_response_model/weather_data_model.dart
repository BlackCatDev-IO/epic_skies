import 'package:epic_skies/features/main_weather/models/weather_response_model/current_data/current_data_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/daily_data/daily_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_data_model.freezed.dart';
part 'weather_data_model.g.dart';

@freezed
class WeatherResponseModel with _$WeatherResponseModel {
  factory WeatherResponseModel({
    required CurrentData currentCondition,
    required List<DailyData> days,
    required String description,
    num? queryCost,
    double? latitude,
    double? longitude,
    String? resolvedAddress,
    String? address,
    String? timezone,
    int? tzoffset,
  }) = _WeatherResponseModel;

  factory WeatherResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseModelFromJson(json);

  factory WeatherResponseModel.fromResponse({
    required Map<String, dynamic> response,
  }) {
    return WeatherResponseModel(
      queryCost: response['queryCost'] as num?,
      latitude: (response['latitude'] as num?)?.toDouble(),
      longitude: (response['longitude'] as num?)?.toDouble(),
      resolvedAddress: response['resolvedAddress'] as String?,
      address: response['address'] as String,
      timezone: response['timezone'] as String,
      tzoffset: (response['tzoffset'] as num?)?.toInt(),
      description: response['description'] as String,
      days: (response['days'] as List)
          .map(
            (dayMap) => DailyData.fromJson(
              dayMap as Map<String, dynamic>,
            ),
          )
          .toList(),
      currentCondition: CurrentData.fromJson(
        response['currentConditions'] as Map<String, dynamic>,
      ),
    );
  }
}
