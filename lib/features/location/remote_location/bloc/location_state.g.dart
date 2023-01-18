// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'location_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LocationState _$$_LocationStateFromJson(Map<String, dynamic> json) =>
    _$_LocationState(
      searchHistory: (json['searchHistory'] as List<dynamic>)
          .map((e) => SearchSuggestion.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentSearchList: (json['currentSearchList'] as List<dynamic>)
          .map((e) => SearchSuggestion.fromJson(e as Map<String, dynamic>))
          .toList(),
      data: LocationModel.fromJson(json['data'] as Map<String, dynamic>),
      remoteLocationData: RemoteLocationModel.fromJson(
          json['remoteLocationData'] as Map<String, dynamic>,),
      status: $enumDecode(_$LocationStatusEnumMap, json['status']),
      searchSuggestion: json['searchSuggestion'] == null
          ? null
          : SearchSuggestion.fromJson(
              json['searchSuggestion'] as Map<String, dynamic>,),
      coordinates: json['coordinates'] == null
          ? null
          : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
      searchIsLocal: json['searchIsLocal'] as bool,
    );

Map<String, dynamic> _$$_LocationStateToJson(_$_LocationState instance) =>
    <String, dynamic>{
      'searchHistory': instance.searchHistory,
      'currentSearchList': instance.currentSearchList,
      'data': instance.data,
      'remoteLocationData': instance.remoteLocationData,
      'status': _$LocationStatusEnumMap[instance.status]!,
      'searchSuggestion': instance.searchSuggestion,
      'coordinates': instance.coordinates,
      'searchIsLocal': instance.searchIsLocal,
    };

const _$LocationStatusEnumMap = {
  LocationStatus.initial: 'initial',
  LocationStatus.loading: 'loading',
  LocationStatus.success: 'success',
  LocationStatus.locationDisabled: 'locationDisabled',
  LocationStatus.permissionDenied: 'permissionDenied',
  LocationStatus.error: 'error',
};
