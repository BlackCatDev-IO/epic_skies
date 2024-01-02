// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_update_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUpdateStateImpl _$$AppUpdateStateImplFromJson(Map<String, dynamic> json) =>
    _$AppUpdateStateImpl(
      currentAppVersion: json['currentAppVersion'] as String? ?? '',
      changeLog: json['changeLog'] as String? ?? '',
      updatedChanges: json['updatedChanges'] as String? ?? '',
      status: $enumDecodeNullable(_$AppUpdateStatusEnumMap, json['status']) ??
          AppUpdateStatus.firstInstall,
    );

Map<String, dynamic> _$$AppUpdateStateImplToJson(
        _$AppUpdateStateImpl instance) =>
    <String, dynamic>{
      'currentAppVersion': instance.currentAppVersion,
      'changeLog': instance.changeLog,
      'updatedChanges': instance.updatedChanges,
      'status': _$AppUpdateStatusEnumMap[instance.status]!,
    };

const _$AppUpdateStatusEnumMap = {
  AppUpdateStatus.firstInstall: 'firstInstall',
  AppUpdateStatus.notUpdated: 'notUpdated',
  AppUpdateStatus.updated: 'updated',
};
