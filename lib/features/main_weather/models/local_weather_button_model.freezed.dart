// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_weather_button_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LocalWeatherButtonModel _$LocalWeatherButtonModelFromJson(
    Map<String, dynamic> json) {
  return _LocalWeatherButtonModel.fromJson(json);
}

/// @nodoc
mixin _$LocalWeatherButtonModel {
  int get temp => throw _privateConstructorUsedError;
  String get condition => throw _privateConstructorUsedError;
  bool get isDay => throw _privateConstructorUsedError;
  bool get tempUnitsMetric => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocalWeatherButtonModelCopyWith<LocalWeatherButtonModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalWeatherButtonModelCopyWith<$Res> {
  factory $LocalWeatherButtonModelCopyWith(LocalWeatherButtonModel value,
          $Res Function(LocalWeatherButtonModel) then) =
      _$LocalWeatherButtonModelCopyWithImpl<$Res, LocalWeatherButtonModel>;
  @useResult
  $Res call({int temp, String condition, bool isDay, bool tempUnitsMetric});
}

/// @nodoc
class _$LocalWeatherButtonModelCopyWithImpl<$Res,
        $Val extends LocalWeatherButtonModel>
    implements $LocalWeatherButtonModelCopyWith<$Res> {
  _$LocalWeatherButtonModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temp = null,
    Object? condition = null,
    Object? isDay = null,
    Object? tempUnitsMetric = null,
  }) {
    return _then(_value.copyWith(
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as int,
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String,
      isDay: null == isDay
          ? _value.isDay
          : isDay // ignore: cast_nullable_to_non_nullable
              as bool,
      tempUnitsMetric: null == tempUnitsMetric
          ? _value.tempUnitsMetric
          : tempUnitsMetric // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LocalWeatherButtonModelCopyWith<$Res>
    implements $LocalWeatherButtonModelCopyWith<$Res> {
  factory _$$_LocalWeatherButtonModelCopyWith(_$_LocalWeatherButtonModel value,
          $Res Function(_$_LocalWeatherButtonModel) then) =
      __$$_LocalWeatherButtonModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int temp, String condition, bool isDay, bool tempUnitsMetric});
}

/// @nodoc
class __$$_LocalWeatherButtonModelCopyWithImpl<$Res>
    extends _$LocalWeatherButtonModelCopyWithImpl<$Res,
        _$_LocalWeatherButtonModel>
    implements _$$_LocalWeatherButtonModelCopyWith<$Res> {
  __$$_LocalWeatherButtonModelCopyWithImpl(_$_LocalWeatherButtonModel _value,
      $Res Function(_$_LocalWeatherButtonModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temp = null,
    Object? condition = null,
    Object? isDay = null,
    Object? tempUnitsMetric = null,
  }) {
    return _then(_$_LocalWeatherButtonModel(
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as int,
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String,
      isDay: null == isDay
          ? _value.isDay
          : isDay // ignore: cast_nullable_to_non_nullable
              as bool,
      tempUnitsMetric: null == tempUnitsMetric
          ? _value.tempUnitsMetric
          : tempUnitsMetric // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LocalWeatherButtonModel implements _LocalWeatherButtonModel {
  const _$_LocalWeatherButtonModel(
      {this.temp = 0,
      this.condition = '',
      this.isDay = true,
      this.tempUnitsMetric = false});

  factory _$_LocalWeatherButtonModel.fromJson(Map<String, dynamic> json) =>
      _$$_LocalWeatherButtonModelFromJson(json);

  @override
  @JsonKey()
  final int temp;
  @override
  @JsonKey()
  final String condition;
  @override
  @JsonKey()
  final bool isDay;
  @override
  @JsonKey()
  final bool tempUnitsMetric;

  @override
  String toString() {
    return 'LocalWeatherButtonModel(temp: $temp, condition: $condition, isDay: $isDay, tempUnitsMetric: $tempUnitsMetric)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocalWeatherButtonModel &&
            (identical(other.temp, temp) || other.temp == temp) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.isDay, isDay) || other.isDay == isDay) &&
            (identical(other.tempUnitsMetric, tempUnitsMetric) ||
                other.tempUnitsMetric == tempUnitsMetric));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, temp, condition, isDay, tempUnitsMetric);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocalWeatherButtonModelCopyWith<_$_LocalWeatherButtonModel>
      get copyWith =>
          __$$_LocalWeatherButtonModelCopyWithImpl<_$_LocalWeatherButtonModel>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LocalWeatherButtonModelToJson(
      this,
    );
  }
}

abstract class _LocalWeatherButtonModel implements LocalWeatherButtonModel {
  const factory _LocalWeatherButtonModel(
      {final int temp,
      final String condition,
      final bool isDay,
      final bool tempUnitsMetric}) = _$_LocalWeatherButtonModel;

  factory _LocalWeatherButtonModel.fromJson(Map<String, dynamic> json) =
      _$_LocalWeatherButtonModel.fromJson;

  @override
  int get temp;
  @override
  String get condition;
  @override
  bool get isDay;
  @override
  bool get tempUnitsMetric;
  @override
  @JsonKey(ignore: true)
  _$$_LocalWeatherButtonModelCopyWith<_$_LocalWeatherButtonModel>
      get copyWith => throw _privateConstructorUsedError;
}
