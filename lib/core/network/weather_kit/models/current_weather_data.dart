import 'package:dart_mappable/dart_mappable.dart';

part 'current_weather_data.mapper.dart';

/// The current weather conditions for the specified location
@MappableClass()
class CurrentWeatherData with CurrentWeatherDataMappable {
  CurrentWeatherData({
    required this.asOf,
    required this.cloudCover,
    required this.conditionCode,
    required this.daylight,
    required this.humidity,
    required this.precipitationIntensity,
    required this.pressure,
    required this.pressureTrend,
    required this.temperature,
    required this.temperatureApparent,
    required this.temperatureDewPoint,
    required this.uvIndex,
    required this.visibility,
    required this.windDirection,
    required this.windGust,
    required this.windSpeed,
  });

  /// The date and time
  final DateTime asOf;

  /// The percentage of the sky covered with clouds during the period,
  /// from 0 to 1
  final double cloudCover;

  /// An enumeration value indicating the condition at the time
  final String conditionCode;

  /// A Boolean value indicating whether there is daylight
  final bool daylight;

  /// The relative humidity, from 0 to 1
  final double humidity;

  /// The precipitation intensity, in millimeters per hour
  final double precipitationIntensity;

  /// The sea level air pressure, in millibars
  final double pressure;

  /// The direction of change of the sea-level air pressure
  final String pressureTrend;

  /// The current temperature, in degrees Celsius
  final double temperature;

  /// The feels-like temperature when factoring wind and humidity
  final double temperatureApparent;

  /// The temperature at which relative humidity is 100%, in Celsius
  final double temperatureDewPoint;

  /// The level of ultraviolet radiation
  final int uvIndex;

  /// The distance at which terrain is visible, in meters
  final double visibility;

  /// The direction of the wind, in degrees
  final int windDirection;

  /// The maximum wind gust speed, in kilometers per hour
  final double windGust;

  /// The wind speed, in kilometers per hour
  final double windSpeed;

  /// Creates a [CurrentWeatherData] object from the provided [Map]
  static const fromMap = CurrentWeatherDataMapper.fromMap;
}
