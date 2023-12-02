// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherImageModelImpl _$$WeatherImageModelImplFromJson(
        Map<String, dynamic> json) =>
    _$WeatherImageModelImpl(
      condition: $enumDecode(_$WeatherImageTypeEnumMap, json['condition']),
      isDay: json['isDay'] as bool,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$WeatherImageModelImplToJson(
        _$WeatherImageModelImpl instance) =>
    <String, dynamic>{
      'condition': _$WeatherImageTypeEnumMap[instance.condition]!,
      'isDay': instance.isDay,
      'imageUrl': instance.imageUrl,
    };

const _$WeatherImageTypeEnumMap = {
  WeatherImageType.clear: 'clear',
  WeatherImageType.cloudy: 'cloudy',
  WeatherImageType.rain: 'rain',
  WeatherImageType.snow: 'snow',
  WeatherImageType.storm: 'storm',
};
