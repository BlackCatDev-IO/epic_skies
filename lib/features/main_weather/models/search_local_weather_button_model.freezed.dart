// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_local_weather_button_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SearchLocalWeatherButtonModel _$SearchLocalWeatherButtonModelFromJson(
    Map<String, dynamic> json) {
  return _SearchLocalWeatherButtonModel.fromJson(json);
}

/// @nodoc
mixin _$SearchLocalWeatherButtonModel {
  int get temp => throw _privateConstructorUsedError;
  String get condition => throw _privateConstructorUsedError;
  bool get isDay => throw _privateConstructorUsedError;
  bool get tempUnitsMetric => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchLocalWeatherButtonModelCopyWith<SearchLocalWeatherButtonModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchLocalWeatherButtonModelCopyWith<$Res> {
  factory $SearchLocalWeatherButtonModelCopyWith(
          SearchLocalWeatherButtonModel value,
          $Res Function(SearchLocalWeatherButtonModel) then) =
      _$SearchLocalWeatherButtonModelCopyWithImpl<$Res,
          SearchLocalWeatherButtonModel>;
  @useResult
  $Res call({int temp, String condition, bool isDay, bool tempUnitsMetric});
}

/// @nodoc
class _$SearchLocalWeatherButtonModelCopyWithImpl<$Res,
        $Val extends SearchLocalWeatherButtonModel>
    implements $SearchLocalWeatherButtonModelCopyWith<$Res> {
  _$SearchLocalWeatherButtonModelCopyWithImpl(this._value, this._then);

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
abstract class _$$_SearchLocalWeatherButtonModelCopyWith<$Res>
    implements $SearchLocalWeatherButtonModelCopyWith<$Res> {
  factory _$$_SearchLocalWeatherButtonModelCopyWith(
          _$_SearchLocalWeatherButtonModel value,
          $Res Function(_$_SearchLocalWeatherButtonModel) then) =
      __$$_SearchLocalWeatherButtonModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int temp, String condition, bool isDay, bool tempUnitsMetric});
}

/// @nodoc
class __$$_SearchLocalWeatherButtonModelCopyWithImpl<$Res>
    extends _$SearchLocalWeatherButtonModelCopyWithImpl<$Res,
        _$_SearchLocalWeatherButtonModel>
    implements _$$_SearchLocalWeatherButtonModelCopyWith<$Res> {
  __$$_SearchLocalWeatherButtonModelCopyWithImpl(
      _$_SearchLocalWeatherButtonModel _value,
      $Res Function(_$_SearchLocalWeatherButtonModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temp = null,
    Object? condition = null,
    Object? isDay = null,
    Object? tempUnitsMetric = null,
  }) {
    return _then(_$_SearchLocalWeatherButtonModel(
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
class _$_SearchLocalWeatherButtonModel
    implements _SearchLocalWeatherButtonModel {
  const _$_SearchLocalWeatherButtonModel(
      {this.temp = 0,
      this.condition = '',
      this.isDay = true,
      this.tempUnitsMetric = false});

  factory _$_SearchLocalWeatherButtonModel.fromJson(
          Map<String, dynamic> json) =>
      _$$_SearchLocalWeatherButtonModelFromJson(json);

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
    return 'SearchLocalWeatherButtonModel(temp: $temp, condition: $condition, isDay: $isDay, tempUnitsMetric: $tempUnitsMetric)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SearchLocalWeatherButtonModel &&
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
  _$$_SearchLocalWeatherButtonModelCopyWith<_$_SearchLocalWeatherButtonModel>
      get copyWith => __$$_SearchLocalWeatherButtonModelCopyWithImpl<
          _$_SearchLocalWeatherButtonModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SearchLocalWeatherButtonModelToJson(
      this,
    );
  }
}

abstract class _SearchLocalWeatherButtonModel
    implements SearchLocalWeatherButtonModel {
  const factory _SearchLocalWeatherButtonModel(
      {final int temp,
      final String condition,
      final bool isDay,
      final bool tempUnitsMetric}) = _$_SearchLocalWeatherButtonModel;

  factory _SearchLocalWeatherButtonModel.fromJson(Map<String, dynamic> json) =
      _$_SearchLocalWeatherButtonModel.fromJson;

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
  _$$_SearchLocalWeatherButtonModelCopyWith<_$_SearchLocalWeatherButtonModel>
      get copyWith => throw _privateConstructorUsedError;
}
