// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bg_image_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BgImageState _$$_BgImageStateFromJson(Map<String, dynamic> json) =>
    _$_BgImageState(
      imageSettings: $enumDecode(_$ImageSettingsEnumMap, json['imageSettings']),
      bgImagePath: json['bgImagePath'] as String,
      imageFileMap: (json['imageFileMap'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      imageFileList: (json['imageFileList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_BgImageStateToJson(_$_BgImageState instance) =>
    <String, dynamic>{
      'imageSettings': _$ImageSettingsEnumMap[instance.imageSettings]!,
      'bgImagePath': instance.bgImagePath,
      'imageFileMap': instance.imageFileMap,
      'imageFileList': instance.imageFileList,
    };

const _$ImageSettingsEnumMap = {
  ImageSettings.dynamic: 'dynamic',
  ImageSettings.deviceGallery: 'deviceGallery',
  ImageSettings.appGallery: 'appGallery',
};
