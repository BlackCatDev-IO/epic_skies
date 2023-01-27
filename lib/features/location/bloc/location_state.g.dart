// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LocationState _$$_LocationStateFromJson(Map<String, dynamic> json) =>
    _$_LocationState(
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
      status: $enumDecodeNullable(_$LocationStatusEnumMap, json['status']) ??
          LocationStatus.initial,
      coordinates: json['coordinates'] == null
          ? const Coordinates(lat: 0.0, long: 0.0)
          : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
      searchIsLocal: json['searchIsLocal'] as bool? ?? true,
      searchSuggestion: json['searchSuggestion'] == null
          ? null
          : SearchSuggestion.fromJson(
              json['searchSuggestion'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_LocationStateToJson(_$_LocationState instance) =>
    <String, dynamic>{
      'searchHistory': instance.searchHistory,
      'currentSearchList': instance.currentSearchList,
      'data': instance.data,
      'remoteLocationData': instance.remoteLocationData,
      'status': _$LocationStatusEnumMap[instance.status]!,
      'coordinates': instance.coordinates,
      'searchIsLocal': instance.searchIsLocal,
      'searchSuggestion': instance.searchSuggestion,
    };

const _$LocationStatusEnumMap = {
  LocationStatus.initial: 'initial',
  LocationStatus.loading: 'loading',
  LocationStatus.success: 'success',
  LocationStatus.error: 'error',
};
