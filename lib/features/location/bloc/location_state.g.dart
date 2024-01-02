// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationStateImpl _$$LocationStateImplFromJson(Map<String, dynamic> json) =>
    _$LocationStateImpl(
      searchHistory: (json['searchHistory'] as List<dynamic>?)
              ?.map((e) => SearchSuggestion.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      currentSearchList: (json['currentSearchList'] as List<dynamic>?)
              ?.map((e) => SearchSuggestion.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      data: json['data'] == null
          ? const LocationModel()
          : LocationModel.fromJson(json['data'] as Map<String, dynamic>),
      remoteLocationData: json['remoteLocationData'] == null
          ? const RemoteLocationModel()
          : RemoteLocationModel.fromJson(
              json['remoteLocationData'] as Map<String, dynamic>),
      coordinates: json['coordinates'] == null
          ? const Coordinates(lat: 0, long: 0)
          : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
      searchIsLocal: json['searchIsLocal'] as bool? ?? true,
      languageCode: json['languageCode'] as String?,
      countryCode: json['countryCode'] as String?,
      searchSuggestion: json['searchSuggestion'] == null
          ? null
          : SearchSuggestion.fromJson(
              json['searchSuggestion'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LocationStateImplToJson(_$LocationStateImpl instance) =>
    <String, dynamic>{
      'searchHistory': instance.searchHistory,
      'currentSearchList': instance.currentSearchList,
      'data': instance.data,
      'remoteLocationData': instance.remoteLocationData,
      'coordinates': instance.coordinates,
      'searchIsLocal': instance.searchIsLocal,
      'languageCode': instance.languageCode,
      'countryCode': instance.countryCode,
      'searchSuggestion': instance.searchSuggestion,
    };
