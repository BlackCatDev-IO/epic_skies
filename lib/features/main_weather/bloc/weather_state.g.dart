// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WeatherState _$$_WeatherStateFromJson(Map<String, dynamic> json) =>
    _$_WeatherState(
      weatherModel: json['weatherModel'] == null
          ? null
          : WeatherResponseModel.fromJson(
              json['weatherModel'] as Map<String, dynamic>,
            ),
      status: $enumDecodeNullable(_$WeatherStatusEnumMap, json['status']) ??
          WeatherStatus.initial,
      searchIsLocal: json['searchIsLocal'] as bool? ?? true,
      unitSettings: json['unitSettings'] == null
          ? const UnitSettings()
          : UnitSettings.fromJson(json['unitSettings'] as Map<String, dynamic>),
      searchButtonModel: json['searchButtonModel'] == null
          ? const SearchLocalWeatherButtonModel()
          : SearchLocalWeatherButtonModel.fromJson(
              json['searchButtonModel'] as String,
            ),
      refererenceSuntimes: (json['refererenceSuntimes'] as List<dynamic>?)
              ?.map((e) => SunTimesModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isDay: json['isDay'] as bool? ?? true,
    );

Map<String, dynamic> _$$_WeatherStateToJson(_$_WeatherState instance) =>
    <String, dynamic>{
      'weatherModel': instance.weatherModel,
      'status': _$WeatherStatusEnumMap[instance.status]!,
      'searchIsLocal': instance.searchIsLocal,
      'unitSettings': instance.unitSettings,
      'searchButtonModel': instance.searchButtonModel,
      'refererenceSuntimes': instance.refererenceSuntimes,
      'isDay': instance.isDay,
    };

const _$WeatherStatusEnumMap = {
  WeatherStatus.initial: 'initial',
  WeatherStatus.loading: 'loading',
  WeatherStatus.success: 'success',
  WeatherStatus.unitSettingsUpdate: 'unitSettingsUpdate',
  WeatherStatus.error: 'error',
};
