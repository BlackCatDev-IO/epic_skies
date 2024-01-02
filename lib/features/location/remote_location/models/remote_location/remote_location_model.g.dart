// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RemoteLocationModelImpl _$$RemoteLocationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RemoteLocationModelImpl(
      remoteLat: (json['remoteLat'] as num?)?.toDouble() ?? 0.0,
      remoteLong: (json['remoteLong'] as num?)?.toDouble() ?? 0.0,
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      country: json['country'] as String? ?? '',
      longNameList: (json['longNameList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          null,
    );

Map<String, dynamic> _$$RemoteLocationModelImplToJson(
        _$RemoteLocationModelImpl instance) =>
    <String, dynamic>{
      'remoteLat': instance.remoteLat,
      'remoteLong': instance.remoteLong,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'longNameList': instance.longNameList,
    };
