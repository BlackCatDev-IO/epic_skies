import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/core/network/weather_kit/models/daily/day_part_forecast.dart';

part 'day_weather_conditions.mapper.dart';

/// The historical or forecasted weather conditions for a specified day
@MappableClass()
class DayWeatherConditions with DayWeatherConditionsMappable {
  DayWeatherConditions({
    required this.conditionCode,
    required this.forecastStart,
    required this.forecastEnd,
    required this.maxUvIndex,
    required this.moonPhase,
    required this.moonrise,
    required this.moonset,
    required this.daytimeForecast,
    required this.overnightForecast,
    required this.precipitationAmount,
    required this.precipitationChance,
    required this.precipitationType,
    required this.snowfallAmount,
    required this.solarMidnight,
    required this.solarNoon,
    required this.sunrise,
    required this.sunriseAstronomical,
    required this.sunriseCivil,
    required this.sunriseNautical,
    required this.sunset,
    required this.sunsetAstronomical,
    required this.sunsetCivil,
    required this.sunsetNautical,
    required this.temperatureMax,
    required this.temperatureMin,
  });

  /// An enumeration value indicating the condition at the time
  final String conditionCode;

  /// The starting date and time of the forecast
  final DateTime forecastStart;

  /// The ending date and time of the forecast
  final DateTime forecastEnd;

  /// The maximum ultraviolet index value during the day
  final int maxUvIndex;

  /// The phase of the moon on the specified day
  final String moonPhase;

  /// The time of moonrise on the specified day
  final DateTime moonrise;

  /// The time of moonset on the specified day
  final DateTime moonset;

  /// The forecast between 7 AM and 7 PM for the day
  final DayPartForecast daytimeForecast;

  /// The day part forecast between 7 PM and 7 AM for the overnight
  final DayPartForecast overnightForecast;

  /// The amount of precipitation forecasted to occur during the day,
  /// in millimeters
  final num precipitationAmount;

  /// The chance of precipitation forecasted to occur during the day
  final num precipitationChance;

  /// The type of precipitation forecasted to occur during the day
  final String precipitationType;

  /// The depth of snow as ice crystals forecasted to occur during the day,
  final num snowfallAmount;

  /// The time when the sun is lowest in the sky
  final DateTime solarMidnight;

  /// The time when the sun is highest in the sky
  final DateTime solarNoon;

  /// The time when the top edge of the sun reaches the horizon in the morning
  final DateTime sunrise;

  /// The time when the sun is 18 degrees below the horizon in the morning
  final DateTime sunriseAstronomical;

  /// The time when the sun is 6 degrees below the horizon in the morning
  final DateTime sunriseCivil;

  /// The time when the sun is 12 degrees below the horizon in the morning
  final DateTime sunriseNautical;

  /// The time when the top edge of the sun reaches the horizon in the evening
  final DateTime sunset;

  /// The time when the sun is 18 degrees below the horizon in the evening
  final DateTime sunsetAstronomical;

  /// The time when the sun is 6 degrees below the horizon in the evening
  final DateTime sunsetCivil;

  /// The time when the sun is 12 degrees below the horizon in the evening
  final DateTime sunsetNautical;

  /// The maximum temperature forecasted to occur during the day,
  /// in degrees Celsius
  final num temperatureMax;

  /// The minimum temperature forecasted to occur during the day,
  final num temperatureMin;

  /// Returns a new [DayWeatherConditions] object from the provided [Map]
  static const fromMap = DayWeatherConditionsMapper.fromMap;
}
