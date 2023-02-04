// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_weather_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CurrentWeatherState _$CurrentWeatherStateFromJson(Map<String, dynamic> json) {
  return _CurrentWeatherState.fromJson(json);
}

/// @nodoc
mixin _$CurrentWeatherState {
  String get currentTimeString => throw _privateConstructorUsedError;
  CurrentWeatherModel? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CurrentWeatherStateCopyWith<CurrentWeatherState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentWeatherStateCopyWith<$Res> {
  factory $CurrentWeatherStateCopyWith(
          CurrentWeatherState value, $Res Function(CurrentWeatherState) then) =
      _$CurrentWeatherStateCopyWithImpl<$Res, CurrentWeatherState>;
  @useResult
  $Res call({String currentTimeString, CurrentWeatherModel? data});

  $CurrentWeatherModelCopyWith<$Res>? get data;
}

/// @nodoc
class _$CurrentWeatherStateCopyWithImpl<$Res, $Val extends CurrentWeatherState>
    implements $CurrentWeatherStateCopyWith<$Res> {
  _$CurrentWeatherStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentTimeString = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      currentTimeString: null == currentTimeString
          ? _value.currentTimeString
          : currentTimeString // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as CurrentWeatherModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CurrentWeatherModelCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $CurrentWeatherModelCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CurrentWeatherStateCopyWith<$Res>
    implements $CurrentWeatherStateCopyWith<$Res> {
  factory _$$_CurrentWeatherStateCopyWith(_$_CurrentWeatherState value,
          $Res Function(_$_CurrentWeatherState) then) =
      __$$_CurrentWeatherStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String currentTimeString, CurrentWeatherModel? data});

  @override
  $CurrentWeatherModelCopyWith<$Res>? get data;
}

/// @nodoc
class __$$_CurrentWeatherStateCopyWithImpl<$Res>
    extends _$CurrentWeatherStateCopyWithImpl<$Res, _$_CurrentWeatherState>
    implements _$$_CurrentWeatherStateCopyWith<$Res> {
  __$$_CurrentWeatherStateCopyWithImpl(_$_CurrentWeatherState _value,
      $Res Function(_$_CurrentWeatherState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentTimeString = null,
    Object? data = freezed,
  }) {
    return _then(_$_CurrentWeatherState(
      currentTimeString: null == currentTimeString
          ? _value.currentTimeString
          : currentTimeString // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as CurrentWeatherModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CurrentWeatherState implements _CurrentWeatherState {
  const _$_CurrentWeatherState(
      {required this.currentTimeString, required this.data});

  factory _$_CurrentWeatherState.fromJson(Map<String, dynamic> json) =>
      _$$_CurrentWeatherStateFromJson(json);

  @override
  final String currentTimeString;
  @override
  final CurrentWeatherModel? data;

  @override
  String toString() {
    return 'CurrentWeatherState(currentTimeString: $currentTimeString, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CurrentWeatherState &&
            (identical(other.currentTimeString, currentTimeString) ||
                other.currentTimeString == currentTimeString) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, currentTimeString, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CurrentWeatherStateCopyWith<_$_CurrentWeatherState> get copyWith =>
      __$$_CurrentWeatherStateCopyWithImpl<_$_CurrentWeatherState>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CurrentWeatherStateToJson(
      this,
    );
  }
}

abstract class _CurrentWeatherState implements CurrentWeatherState {
  const factory _CurrentWeatherState(
      {required final String currentTimeString,
      required final CurrentWeatherModel? data}) = _$_CurrentWeatherState;

  factory _CurrentWeatherState.fromJson(Map<String, dynamic> json) =
      _$_CurrentWeatherState.fromJson;

  @override
  String get currentTimeString;
  @override
  CurrentWeatherModel? get data;
  @override
  @JsonKey(ignore: true)
  _$$_CurrentWeatherStateCopyWith<_$_CurrentWeatherState> get copyWith =>
      throw _privateConstructorUsedError;
}
