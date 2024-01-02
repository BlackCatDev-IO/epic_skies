// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_update_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppUpdateState _$AppUpdateStateFromJson(Map<String, dynamic> json) {
  return _AppUpdateState.fromJson(json);
}

/// @nodoc
mixin _$AppUpdateState {
  String get currentAppVersion => throw _privateConstructorUsedError;
  String get changeLog => throw _privateConstructorUsedError;
  String get updatedChanges => throw _privateConstructorUsedError;
  AppUpdateStatus get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppUpdateStateCopyWith<AppUpdateState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUpdateStateCopyWith<$Res> {
  factory $AppUpdateStateCopyWith(
          AppUpdateState value, $Res Function(AppUpdateState) then) =
      _$AppUpdateStateCopyWithImpl<$Res, AppUpdateState>;
  @useResult
  $Res call(
      {String currentAppVersion,
      String changeLog,
      String updatedChanges,
      AppUpdateStatus status});
}

/// @nodoc
class _$AppUpdateStateCopyWithImpl<$Res, $Val extends AppUpdateState>
    implements $AppUpdateStateCopyWith<$Res> {
  _$AppUpdateStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentAppVersion = null,
    Object? changeLog = null,
    Object? updatedChanges = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      currentAppVersion: null == currentAppVersion
          ? _value.currentAppVersion
          : currentAppVersion // ignore: cast_nullable_to_non_nullable
              as String,
      changeLog: null == changeLog
          ? _value.changeLog
          : changeLog // ignore: cast_nullable_to_non_nullable
              as String,
      updatedChanges: null == updatedChanges
          ? _value.updatedChanges
          : updatedChanges // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AppUpdateStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppUpdateStateImplCopyWith<$Res>
    implements $AppUpdateStateCopyWith<$Res> {
  factory _$$AppUpdateStateImplCopyWith(_$AppUpdateStateImpl value,
          $Res Function(_$AppUpdateStateImpl) then) =
      __$$AppUpdateStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String currentAppVersion,
      String changeLog,
      String updatedChanges,
      AppUpdateStatus status});
}

/// @nodoc
class __$$AppUpdateStateImplCopyWithImpl<$Res>
    extends _$AppUpdateStateCopyWithImpl<$Res, _$AppUpdateStateImpl>
    implements _$$AppUpdateStateImplCopyWith<$Res> {
  __$$AppUpdateStateImplCopyWithImpl(
      _$AppUpdateStateImpl _value, $Res Function(_$AppUpdateStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentAppVersion = null,
    Object? changeLog = null,
    Object? updatedChanges = null,
    Object? status = null,
  }) {
    return _then(_$AppUpdateStateImpl(
      currentAppVersion: null == currentAppVersion
          ? _value.currentAppVersion
          : currentAppVersion // ignore: cast_nullable_to_non_nullable
              as String,
      changeLog: null == changeLog
          ? _value.changeLog
          : changeLog // ignore: cast_nullable_to_non_nullable
              as String,
      updatedChanges: null == updatedChanges
          ? _value.updatedChanges
          : updatedChanges // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AppUpdateStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppUpdateStateImpl extends _AppUpdateState {
  const _$AppUpdateStateImpl(
      {this.currentAppVersion = '',
      this.changeLog = '',
      this.updatedChanges = '',
      this.status = AppUpdateStatus.firstInstall})
      : super._();

  factory _$AppUpdateStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppUpdateStateImplFromJson(json);

  @override
  @JsonKey()
  final String currentAppVersion;
  @override
  @JsonKey()
  final String changeLog;
  @override
  @JsonKey()
  final String updatedChanges;
  @override
  @JsonKey()
  final AppUpdateStatus status;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUpdateStateImpl &&
            (identical(other.currentAppVersion, currentAppVersion) ||
                other.currentAppVersion == currentAppVersion) &&
            (identical(other.changeLog, changeLog) ||
                other.changeLog == changeLog) &&
            (identical(other.updatedChanges, updatedChanges) ||
                other.updatedChanges == updatedChanges) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, currentAppVersion, changeLog, updatedChanges, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUpdateStateImplCopyWith<_$AppUpdateStateImpl> get copyWith =>
      __$$AppUpdateStateImplCopyWithImpl<_$AppUpdateStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppUpdateStateImplToJson(
      this,
    );
  }
}

abstract class _AppUpdateState extends AppUpdateState {
  const factory _AppUpdateState(
      {final String currentAppVersion,
      final String changeLog,
      final String updatedChanges,
      final AppUpdateStatus status}) = _$AppUpdateStateImpl;
  const _AppUpdateState._() : super._();

  factory _AppUpdateState.fromJson(Map<String, dynamic> json) =
      _$AppUpdateStateImpl.fromJson;

  @override
  String get currentAppVersion;
  @override
  String get changeLog;
  @override
  String get updatedChanges;
  @override
  AppUpdateStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$AppUpdateStateImplCopyWith<_$AppUpdateStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
