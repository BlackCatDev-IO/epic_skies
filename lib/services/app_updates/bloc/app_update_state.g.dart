// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_update_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUpdateState _$$_AppUpdateStateFromJson(Map<String, dynamic> json) =>
    _$_AppUpdateState(
      currentAppVersion: json['currentAppVersion'] as String? ?? '',
      changeLog: json['changeLog'] as String? ?? '',
      updatedChanges: json['updatedChanges'] as String? ?? '',
      status: $enumDecodeNullable(_$AppUpdateStatusEnumMap, json['status']) ??
          AppUpdateStatus.notUpdated,
    );

Map<String, dynamic> _$$_AppUpdateStateToJson(_$_AppUpdateState instance) =>
    <String, dynamic>{
      'currentAppVersion': instance.currentAppVersion,
      'changeLog': instance.changeLog,
      'updatedChanges': instance.updatedChanges,
      'status': _$AppUpdateStatusEnumMap[instance.status]!,
    };

const _$AppUpdateStatusEnumMap = {
  AppUpdateStatus.updated: 'updated',
  AppUpdateStatus.notUpdated: 'notUpdated',
};
