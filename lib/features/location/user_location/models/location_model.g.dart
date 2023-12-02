// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationModelImpl _$$LocationModelImplFromJson(Map<String, dynamic> json) =>
    _$LocationModelImpl(
      subLocality: json['subLocality'] as String? ?? '',
      administrativeArea: json['administrativeArea'] as String? ?? '',
      country: json['country'] as String? ?? '',
      longNameList: (json['longNameList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          null,
    );

Map<String, dynamic> _$$LocationModelImplToJson(_$LocationModelImpl instance) =>
    <String, dynamic>{
      'subLocality': instance.subLocality,
      'administrativeArea': instance.administrativeArea,
      'country': instance.country,
      'longNameList': instance.longNameList,
    };
