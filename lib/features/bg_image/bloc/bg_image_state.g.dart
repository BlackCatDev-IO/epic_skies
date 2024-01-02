// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bg_image_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BgImageStateImpl _$$BgImageStateImplFromJson(Map<String, dynamic> json) =>
    _$BgImageStateImpl(
      status: $enumDecodeNullable(_$BgImageStatusEnumMap, json['status']) ??
          BgImageStatus.initial,
      bgImageList: (json['bgImageList'] as List<dynamic>?)
              ?.map(
                  (e) => WeatherImageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      imageSettings:
          $enumDecodeNullable(_$ImageSettingsEnumMap, json['imageSettings']) ??
              ImageSettings.dynamic,
      bgImagePath: json['bgImagePath'] as String? ?? '',
    );

Map<String, dynamic> _$$BgImageStateImplToJson(_$BgImageStateImpl instance) =>
    <String, dynamic>{
      'status': _$BgImageStatusEnumMap[instance.status]!,
      'bgImageList': instance.bgImageList,
      'imageSettings': _$ImageSettingsEnumMap[instance.imageSettings]!,
      'bgImagePath': instance.bgImagePath,
    };

const _$BgImageStatusEnumMap = {
  BgImageStatus.initial: 'initial',
  BgImageStatus.loading: 'loading',
  BgImageStatus.loaded: 'loaded',
  BgImageStatus.error: 'error',
};

const _$ImageSettingsEnumMap = {
  ImageSettings.dynamic: 'dynamic',
  ImageSettings.deviceGallery: 'deviceGallery',
  ImageSettings.appGallery: 'appGallery',
};
