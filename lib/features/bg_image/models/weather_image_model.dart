import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_image_model.freezed.dart';
part 'weather_image_model.g.dart';

enum WeatherImageType {
  clear,
  cloudy,
  rain,
  snow,
  storm,
}

extension WeatherImageTypedX on WeatherImageType {
  bool get isClear => this == WeatherImageType.clear;
  bool get isCloudy => this == WeatherImageType.cloudy;
  bool get isRain => this == WeatherImageType.rain;
  bool get isSnow => this == WeatherImageType.snow;
  bool get isStorm => this == WeatherImageType.storm;
}

@freezed
class WeatherImageModel with _$WeatherImageModel {
  const factory WeatherImageModel({
    required WeatherImageType condition,
    required bool isDay,
    required String imageUrl,
  }) = _WeatherImageModel;

  factory WeatherImageModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherImageModelFromJson(json);
}
