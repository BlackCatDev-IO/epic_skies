import 'package:dart_mappable/dart_mappable.dart';

part 'weather_image_model.mapper.dart';

@MappableEnum()
enum WeatherImageType {
  clear,
  cloudy,
  rain,
  snow,
  storm;

  bool get isClear => this == WeatherImageType.clear;
  bool get isCloudy => this == WeatherImageType.cloudy;
  bool get isRain => this == WeatherImageType.rain;
  bool get isSnow => this == WeatherImageType.snow;
  bool get isStorm => this == WeatherImageType.storm;
}

@MappableClass()
class WeatherImageModel with WeatherImageModelMappable {
  const WeatherImageModel({
    required this.condition,
    required this.isDay,
    required this.imageUrl,
  });

  final WeatherImageType condition;
  final bool isDay;
  final String imageUrl;
}
