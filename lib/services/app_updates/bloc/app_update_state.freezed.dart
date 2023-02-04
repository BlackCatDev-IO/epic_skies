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
  String get previousAppVersion => throw _privateConstructorUsedError;
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
      String previousAppVersion,
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
    Object? previousAppVersion = null,
    Object? changeLog = null,
    Object? updatedChanges = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      currentAppVersion: null == currentAppVersion
          ? _value.currentAppVersion
          : currentAppVersion // ignore: cast_nullable_to_non_nullable
              as String,
      previousAppVersion: null == previousAppVersion
          ? _value.previousAppVersion
          : previousAppVersion // ignore: cast_nullable_to_non_nullable
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
abstract class _$$_AppUpdateStateCopyWith<$Res>
    implements $AppUpdateStateCopyWith<$Res> {
  factory _$$_AppUpdateStateCopyWith(
          _$_AppUpdateState value, $Res Function(_$_AppUpdateState) then) =
      __$$_AppUpdateStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String currentAppVersion,
      String previousAppVersion,
      String changeLog,
      String updatedChanges,
      AppUpdateStatus status});
}

/// @nodoc
class __$$_AppUpdateStateCopyWithImpl<$Res>
    extends _$AppUpdateStateCopyWithImpl<$Res, _$_AppUpdateState>
    implements _$$_AppUpdateStateCopyWith<$Res> {
  __$$_AppUpdateStateCopyWithImpl(
      _$_AppUpdateState _value, $Res Function(_$_AppUpdateState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentAppVersion = null,
    Object? previousAppVersion = null,
    Object? changeLog = null,
    Object? updatedChanges = null,
    Object? status = null,
  }) {
    return _then(_$_AppUpdateState(
      currentAppVersion: null == currentAppVersion
          ? _value.currentAppVersion
          : currentAppVersion // ignore: cast_nullable_to_non_nullable
              as String,
      previousAppVersion: null == previousAppVersion
          ? _value.previousAppVersion
          : previousAppVersion // ignore: cast_nullable_to_non_nullable
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
class _$_AppUpdateState implements _AppUpdateState {
  const _$_AppUpdateState(
      {this.currentAppVersion = '',
      this.previousAppVersion = '',
      this.changeLog = '',
      this.updatedChanges = '',
      this.status = AppUpdateStatus.notUpdated});

  factory _$_AppUpdateState.fromJson(Map<String, dynamic> json) =>
      _$$_AppUpdateStateFromJson(json);

  @override
  @JsonKey()
  final String currentAppVersion;
  @override
  @JsonKey()
  final String previousAppVersion;
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
  String toString() {
    return 'AppUpdateState(currentAppVersion: $currentAppVersion, previousAppVersion: $previousAppVersion, changeLog: $changeLog, updatedChanges: $updatedChanges, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppUpdateState &&
            (identical(other.currentAppVersion, currentAppVersion) ||
                other.currentAppVersion == currentAppVersion) &&
            (identical(other.previousAppVersion, previousAppVersion) ||
                other.previousAppVersion == previousAppVersion) &&
            (identical(other.changeLog, changeLog) ||
                other.changeLog == changeLog) &&
            (identical(other.updatedChanges, updatedChanges) ||
                other.updatedChanges == updatedChanges) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, currentAppVersion,
      previousAppVersion, changeLog, updatedChanges, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppUpdateStateCopyWith<_$_AppUpdateState> get copyWith =>
      __$$_AppUpdateStateCopyWithImpl<_$_AppUpdateState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppUpdateStateToJson(
      this,
    );
  }
}

abstract class _AppUpdateState implements AppUpdateState {
  const factory _AppUpdateState(
      {final String currentAppVersion,
      final String previousAppVersion,
      final String changeLog,
      final String updatedChanges,
      final AppUpdateStatus status}) = _$_AppUpdateState;

  factory _AppUpdateState.fromJson(Map<String, dynamic> json) =
      _$_AppUpdateState.fromJson;

  @override
  String get currentAppVersion;
  @override
  String get previousAppVersion;
  @override
  String get changeLog;
  @override
  String get updatedChanges;
  @override
  AppUpdateStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$_AppUpdateStateCopyWith<_$_AppUpdateState> get copyWith =>
      throw _privateConstructorUsedError;
}
