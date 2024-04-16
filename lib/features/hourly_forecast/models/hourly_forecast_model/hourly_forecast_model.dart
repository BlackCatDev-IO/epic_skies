import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/core/network/weather_kit/models/hourly/hour_weather_conditions.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/hourly_data/hourly_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/conversions/weather_code_converter.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:get_it/get_it.dart';

part 'hourly_forecast_model.mapper.dart';

@MappableClass()
class HourlyForecastModel with HourlyForecastModelMappable {
  HourlyForecastModel({
    required this.temp,
    required this.feelsLike,
    required this.precipitationAmount,
    required this.precipitationProbability,
    required this.windSpeed,
    required this.iconPath,
    required this.time,
    required this.precipitationType,
    required this.condition,
    this.suntimeString,
    this.isSunrise,
  });

  factory HourlyForecastModel.fromWeatherKitData({
    required String iconPath,
    required UnitSettings unitSettings,
    required bool searchIsLocal,
    required HourWeatherConditions hourlyData,
  }) {
    final time = GetIt.I<TimeZoneUtil>().localOrOffsetTime(
      dateTime: hourlyData.forecastStart,
      searchIsLocal: searchIsLocal,
    );

    return HourlyForecastModel(
      temp: UnitConverter.convertTemp(
        temp: hourlyData.temperature,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      feelsLike: UnitConverter.convertTemp(
        temp: hourlyData.temperatureApparent,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      precipitationAmount: hourlyData.precipitationAmount?.round() ?? 0,
      precipitationProbability: (hourlyData.precipitationChance * 100).toInt(),
      windSpeed: UnitConverter.convertSpeed(
        speed: hourlyData.windSpeed,
        speedInKph: unitSettings.speedInKph,
      ),
      iconPath: iconPath,
      time: time,
      precipitationType: hourlyData.precipitationType,
      condition:
          WeatherCodeConverter.convertWeatherKitCodes(hourlyData.conditionCode),
    );
  }

  factory HourlyForecastModel.fromWeatherData({
    required HourlyData data,
    required String iconPath,
    required UnitSettings unitSettings,
    required bool searchIsLocal,
  }) {
    final time = GetIt.I<TimeZoneUtil>().secondsFromEpoch(
      secondsSinceEpoch: data.datetimeEpoch,
      searchIsLocal: searchIsLocal,
    );

    var condition = data.conditions;

    /// condition string from API can have more than one word
    if (condition.contains(',')) {
      final commaIndex = condition.indexOf(',');
      condition = condition.substring(0, commaIndex);
    }

    return HourlyForecastModel(
      temp: UnitConverter.convertTemp(
        temp: data.temp,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      feelsLike: UnitConverter.convertTemp(
        temp: data.feelslike,
        tempUnitsMetric: unitSettings.tempUnitsMetric,
      ),
      precipitationAmount: data.precip?.round() ?? 0,
      precipitationProbability: data.precipprob?.round() ?? 0,
      windSpeed: UnitConverter.convertSpeed(
        speed: data.windspeed!,
        speedInKph: unitSettings.speedInKph,
      ),
      iconPath: iconPath,
      time: time,
      precipitationType: data.preciptype?[0] as String? ?? '',
      condition: condition,
    );
  }

  final int temp;
  final int feelsLike;
  final num precipitationAmount;
  final num precipitationProbability;
  final int windSpeed;
  final String iconPath;
  final DateTime time;
  final String precipitationType;
  final String condition;
  final String? suntimeString;
  final bool? isSunrise;
}
