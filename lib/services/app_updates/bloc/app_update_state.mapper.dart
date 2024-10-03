// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'app_update_state.dart';

class AppUpdateStatusMapper extends EnumMapper<AppUpdateStatus> {
  AppUpdateStatusMapper._();

  static AppUpdateStatusMapper? _instance;
  static AppUpdateStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppUpdateStatusMapper._());
    }
    return _instance!;
  }

  static AppUpdateStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AppUpdateStatus decode(dynamic value) {
    switch (value) {
      case 'firstInstall':
        return AppUpdateStatus.firstInstall;
      case 'notUpdated':
        return AppUpdateStatus.notUpdated;
      case 'updatedNoDialog':
        return AppUpdateStatus.updatedNoDialog;
      case 'updatedShowUpdateDialog':
        return AppUpdateStatus.updatedShowUpdateDialog;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AppUpdateStatus self) {
    switch (self) {
      case AppUpdateStatus.firstInstall:
        return 'firstInstall';
      case AppUpdateStatus.notUpdated:
        return 'notUpdated';
      case AppUpdateStatus.updatedNoDialog:
        return 'updatedNoDialog';
      case AppUpdateStatus.updatedShowUpdateDialog:
        return 'updatedShowUpdateDialog';
    }
  }
}

extension AppUpdateStatusMapperExtension on AppUpdateStatus {
  String toValue() {
    AppUpdateStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AppUpdateStatus>(this) as String;
  }
}

class AppUpdateStateMapper extends ClassMapperBase<AppUpdateState> {
  AppUpdateStateMapper._();

  static AppUpdateStateMapper? _instance;
  static AppUpdateStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppUpdateStateMapper._());
      AppUpdateStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AppUpdateState';

  static String _$currentAppVersion(AppUpdateState v) => v.currentAppVersion;
  static const Field<AppUpdateState, String> _f$currentAppVersion =
      Field('currentAppVersion', _$currentAppVersion);
  static String _$changeLog(AppUpdateState v) => v.changeLog;
  static const Field<AppUpdateState, String> _f$changeLog =
      Field('changeLog', _$changeLog);
  static List<String> _$updatedChanges(AppUpdateState v) => v.updatedChanges;
  static const Field<AppUpdateState, List<String>> _f$updatedChanges =
      Field('updatedChanges', _$updatedChanges);
  static AppUpdateStatus _$status(AppUpdateState v) => v.status;
  static const Field<AppUpdateState, AppUpdateStatus> _f$status =
      Field('status', _$status);
  static int? _$patchVersion(AppUpdateState v) => v.patchVersion;
  static const Field<AppUpdateState, int> _f$patchVersion =
      Field('patchVersion', _$patchVersion, opt: true);

  @override
  final MappableFields<AppUpdateState> fields = const {
    #currentAppVersion: _f$currentAppVersion,
    #changeLog: _f$changeLog,
    #updatedChanges: _f$updatedChanges,
    #status: _f$status,
    #patchVersion: _f$patchVersion,
  };

  static AppUpdateState _instantiate(DecodingData data) {
    return AppUpdateState(
        currentAppVersion: data.dec(_f$currentAppVersion),
        changeLog: data.dec(_f$changeLog),
        updatedChanges: data.dec(_f$updatedChanges),
        status: data.dec(_f$status),
        patchVersion: data.dec(_f$patchVersion));
  }

  @override
  final Function instantiate = _instantiate;

  static AppUpdateState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppUpdateState>(map);
  }

  static AppUpdateState fromJson(String json) {
    return ensureInitialized().decodeJson<AppUpdateState>(json);
  }
}

mixin AppUpdateStateMappable {
  String toJson() {
    return AppUpdateStateMapper.ensureInitialized()
        .encodeJson<AppUpdateState>(this as AppUpdateState);
  }

  Map<String, dynamic> toMap() {
    return AppUpdateStateMapper.ensureInitialized()
        .encodeMap<AppUpdateState>(this as AppUpdateState);
  }

  AppUpdateStateCopyWith<AppUpdateState, AppUpdateState, AppUpdateState>
      get copyWith => _AppUpdateStateCopyWithImpl(
          this as AppUpdateState, $identity, $identity);
  @override
  String toString() {
    return AppUpdateStateMapper.ensureInitialized()
        .stringifyValue(this as AppUpdateState);
  }

  @override
  bool operator ==(Object other) {
    return AppUpdateStateMapper.ensureInitialized()
        .equalsValue(this as AppUpdateState, other);
  }

  @override
  int get hashCode {
    return AppUpdateStateMapper.ensureInitialized()
        .hashValue(this as AppUpdateState);
  }
}

extension AppUpdateStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppUpdateState, $Out> {
  AppUpdateStateCopyWith<$R, AppUpdateState, $Out> get $asAppUpdateState =>
      $base.as((v, t, t2) => _AppUpdateStateCopyWithImpl(v, t, t2));
}

abstract class AppUpdateStateCopyWith<$R, $In extends AppUpdateState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get updatedChanges;
  $R call(
      {String? currentAppVersion,
      String? changeLog,
      List<String>? updatedChanges,
      AppUpdateStatus? status,
      int? patchVersion});
  AppUpdateStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AppUpdateStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppUpdateState, $Out>
    implements AppUpdateStateCopyWith<$R, AppUpdateState, $Out> {
  _AppUpdateStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppUpdateState> $mapper =
      AppUpdateStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
      get updatedChanges => ListCopyWith(
          $value.updatedChanges,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(updatedChanges: v));
  @override
  $R call(
          {String? currentAppVersion,
          String? changeLog,
          List<String>? updatedChanges,
          AppUpdateStatus? status,
          Object? patchVersion = $none}) =>
      $apply(FieldCopyWithData({
        if (currentAppVersion != null) #currentAppVersion: currentAppVersion,
        if (changeLog != null) #changeLog: changeLog,
        if (updatedChanges != null) #updatedChanges: updatedChanges,
        if (status != null) #status: status,
        if (patchVersion != $none) #patchVersion: patchVersion
      }));
  @override
  AppUpdateState $make(CopyWithData data) => AppUpdateState(
      currentAppVersion:
          data.get(#currentAppVersion, or: $value.currentAppVersion),
      changeLog: data.get(#changeLog, or: $value.changeLog),
      updatedChanges: data.get(#updatedChanges, or: $value.updatedChanges),
      status: data.get(#status, or: $value.status),
      patchVersion: data.get(#patchVersion, or: $value.patchVersion));

  @override
  AppUpdateStateCopyWith<$R2, AppUpdateState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AppUpdateStateCopyWithImpl($value, $cast, t);
}
