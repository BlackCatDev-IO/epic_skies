import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/core/network/weather_kit/models/alerts/weather_alert_summary.dart';
import 'package:epic_skies/core/network/weather_kit/models/current/current_weather_data.dart';
import 'package:epic_skies/core/network/weather_kit/models/daily/day_part_forecast.dart';
import 'package:epic_skies/core/network/weather_kit/models/hourly/hour_weather_conditions.dart';
import 'package:epic_skies/core/network/weather_kit/models/hourly/next_hour_forecast.dart';

part 'weather.mapper.dart';

@MappableClass()
class Weather with WeatherMappable {
  Weather({
    required this.currentWeather,
    required this.forecastDaily,
    required this.forecastHourly,
    this.forecastNextHour,
    this.weatherAlerts,
  });

  /// The current weather for the requested location.
  final CurrentWeatherData currentWeather;

  /// The daily forecast for the requested location.
  final List<DayPartForecast> forecastDaily;

  /// The hourly forecast for the requested location.
  final List<HourWeatherConditions> forecastHourly;

  /// The next hour forecast for the requested location.
  final NextHourForecast? forecastNextHour;

  /// Weather alerts for the requested location.
  final WeatherAlertSummary? weatherAlerts;

  @override
  String toString() {
    return '''Weather(currentWeather: $currentWeather, forecastDaily: $forecastDaily, forecastHourly: $forecastHourly, forecastNextHour: $forecastNextHour, weatherAlerts: $weatherAlerts)''';
  }
}
