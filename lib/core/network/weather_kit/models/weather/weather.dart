import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/core/network/weather_kit/models/alerts/weather_alert_collection.dart';
import 'package:epic_skies/core/network/weather_kit/models/current/current_weather_data.dart';
import 'package:epic_skies/core/network/weather_kit/models/daily/forecast_daily.dart';
import 'package:epic_skies/core/network/weather_kit/models/hourly/forecast_hourly.dart';
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
  final ForecastDaily forecastDaily;

  /// The hourly forecast for the requested location.
  final ForecastHourly forecastHourly;

  /// The next hour forecast for the requested location.
  final NextHourForecast? forecastNextHour;

  /// Weather alerts for the requested location.
  final WeatherAlertCollection? weatherAlerts;

  /// Returns a new [Weather] instance from the provided [Map].
  static const fromMap = WeatherMapper.fromMap;
}
