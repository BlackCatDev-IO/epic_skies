// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LocationModel _$$_LocationModelFromJson(Map<String, dynamic> json) =>
    _$_LocationModel(
      subLocality: json['subLocality'] as String,
      administrativeArea: json['administrativeArea'] as String,
      country: json['country'] as String,
      longNameList: (json['longNameList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_LocationModelToJson(_$_LocationModel instance) =>
    <String, dynamic>{
      'subLocality': instance.subLocality,
      'administrativeArea': instance.administrativeArea,
      'country': instance.country,
      'longNameList': instance.longNameList,
    };
