import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/current_data/current_data.dart';

import 'package:epic_skies/features/main_weather/models/weather_response_model/daily_data/daily_data_model.dart';

part 'weather_data_model.mapper.dart';

@MappableClass()
class WeatherResponseModel with WeatherResponseModelMappable {
  WeatherResponseModel({
    required this.currentCondition,
    required this.days,
    required this.description,
    this.queryCost,
    this.latitude,
    this.longitude,
    this.resolvedAddress,
    this.address,
    this.timezone,
    this.tzoffset,
  });

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
            (dayMap) => DailyData.fromMap(
              dayMap as Map<String, dynamic>,
            ),
          )
          .toList(),
      currentCondition: CurrentData.fromMap(
        response['currentConditions'] as Map<String, dynamic>,
      ),
    );
  }

  final CurrentData currentCondition;
  final List<DailyData> days;
  final num? queryCost;
  final double? latitude;
  final double? longitude;
  final String? resolvedAddress;
  final String? address;
  final String? timezone;
  final int? tzoffset;
  final String description;
}
