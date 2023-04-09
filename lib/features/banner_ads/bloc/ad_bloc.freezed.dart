// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ad_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AdState _$AdStateFromJson(Map<String, dynamic> json) {
  return _AdState.fromJson(json);
}

/// @nodoc
mixin _$AdState {
  AdFreeStatus get status => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  bool get isFirstInstall => throw _privateConstructorUsedError;
  DateTime? get appInstallDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AdStateCopyWith<AdState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdStateCopyWith<$Res> {
  factory $AdStateCopyWith(AdState value, $Res Function(AdState) then) =
      _$AdStateCopyWithImpl<$Res, AdState>;
  @useResult
  $Res call(
      {AdFreeStatus status,
      String errorMessage,
      bool isFirstInstall,
      DateTime? appInstallDate});
}

/// @nodoc
class _$AdStateCopyWithImpl<$Res, $Val extends AdState>
    implements $AdStateCopyWith<$Res> {
  _$AdStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = null,
    Object? isFirstInstall = null,
    Object? appInstallDate = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AdFreeStatus,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      isFirstInstall: null == isFirstInstall
          ? _value.isFirstInstall
          : isFirstInstall // ignore: cast_nullable_to_non_nullable
              as bool,
      appInstallDate: freezed == appInstallDate
          ? _value.appInstallDate
          : appInstallDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AdStateCopyWith<$Res> implements $AdStateCopyWith<$Res> {
  factory _$$_AdStateCopyWith(
          _$_AdState value, $Res Function(_$_AdState) then) =
      __$$_AdStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AdFreeStatus status,
      String errorMessage,
      bool isFirstInstall,
      DateTime? appInstallDate});
}

/// @nodoc
class __$$_AdStateCopyWithImpl<$Res>
    extends _$AdStateCopyWithImpl<$Res, _$_AdState>
    implements _$$_AdStateCopyWith<$Res> {
  __$$_AdStateCopyWithImpl(_$_AdState _value, $Res Function(_$_AdState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = null,
    Object? isFirstInstall = null,
    Object? appInstallDate = freezed,
  }) {
    return _then(_$_AdState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AdFreeStatus,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      isFirstInstall: null == isFirstInstall
          ? _value.isFirstInstall
          : isFirstInstall // ignore: cast_nullable_to_non_nullable
              as bool,
      appInstallDate: freezed == appInstallDate
          ? _value.appInstallDate
          : appInstallDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AdState implements _AdState {
  _$_AdState(
      {this.status = AdFreeStatus.showAds,
      this.errorMessage = '',
      this.isFirstInstall = true,
      this.appInstallDate});

  factory _$_AdState.fromJson(Map<String, dynamic> json) =>
      _$$_AdStateFromJson(json);

  @override
  @JsonKey()
  final AdFreeStatus status;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  @JsonKey()
  final bool isFirstInstall;
  @override
  final DateTime? appInstallDate;

  @override
  String toString() {
    return 'AdState(status: $status, errorMessage: $errorMessage, isFirstInstall: $isFirstInstall, appInstallDate: $appInstallDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AdState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isFirstInstall, isFirstInstall) ||
                other.isFirstInstall == isFirstInstall) &&
            (identical(other.appInstallDate, appInstallDate) ||
                other.appInstallDate == appInstallDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, errorMessage, isFirstInstall, appInstallDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AdStateCopyWith<_$_AdState> get copyWith =>
      __$$_AdStateCopyWithImpl<_$_AdState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AdStateToJson(
      this,
    );
  }
}

abstract class _AdState implements AdState {
  factory _AdState(
      {final AdFreeStatus status,
      final String errorMessage,
      final bool isFirstInstall,
      final DateTime? appInstallDate}) = _$_AdState;

  factory _AdState.fromJson(Map<String, dynamic> json) = _$_AdState.fromJson;

  @override
  AdFreeStatus get status;
  @override
  String get errorMessage;
  @override
  bool get isFirstInstall;
  @override
  DateTime? get appInstallDate;
  @override
  @JsonKey(ignore: true)
  _$$_AdStateCopyWith<_$_AdState> get copyWith =>
      throw _privateConstructorUsedError;
}
