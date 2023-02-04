// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_weather_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CurrentWeatherModel _$CurrentWeatherModelFromJson(Map<String, dynamic> json) {
  return _CurrentWeatherModel.fromJson(json);
}

/// @nodoc
mixin _$CurrentWeatherModel {
  int get temp => throw _privateConstructorUsedError;
  int get feelsLike => throw _privateConstructorUsedError;
  int get windSpeed => throw _privateConstructorUsedError;
  String get tempUnit => throw _privateConstructorUsedError;
  String get condition => throw _privateConstructorUsedError;
  String get speedUnit => throw _privateConstructorUsedError;
  UnitSettings get unitSettings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CurrentWeatherModelCopyWith<CurrentWeatherModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentWeatherModelCopyWith<$Res> {
  factory $CurrentWeatherModelCopyWith(
          CurrentWeatherModel value, $Res Function(CurrentWeatherModel) then) =
      _$CurrentWeatherModelCopyWithImpl<$Res, CurrentWeatherModel>;
  @useResult
  $Res call(
      {int temp,
      int feelsLike,
      int windSpeed,
      String tempUnit,
      String condition,
      String speedUnit,
      UnitSettings unitSettings});

  $UnitSettingsCopyWith<$Res> get unitSettings;
}

/// @nodoc
class _$CurrentWeatherModelCopyWithImpl<$Res, $Val extends CurrentWeatherModel>
    implements $CurrentWeatherModelCopyWith<$Res> {
  _$CurrentWeatherModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temp = null,
    Object? feelsLike = null,
    Object? windSpeed = null,
    Object? tempUnit = null,
    Object? condition = null,
    Object? speedUnit = null,
    Object? unitSettings = null,
  }) {
    return _then(_value.copyWith(
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as int,
      feelsLike: null == feelsLike
          ? _value.feelsLike
          : feelsLike // ignore: cast_nullable_to_non_nullable
              as int,
      windSpeed: null == windSpeed
          ? _value.windSpeed
          : windSpeed // ignore: cast_nullable_to_non_nullable
              as int,
      tempUnit: null == tempUnit
          ? _value.tempUnit
          : tempUnit // ignore: cast_nullable_to_non_nullable
              as String,
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String,
      speedUnit: null == speedUnit
          ? _value.speedUnit
          : speedUnit // ignore: cast_nullable_to_non_nullable
              as String,
      unitSettings: null == unitSettings
          ? _value.unitSettings
          : unitSettings // ignore: cast_nullable_to_non_nullable
              as UnitSettings,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UnitSettingsCopyWith<$Res> get unitSettings {
    return $UnitSettingsCopyWith<$Res>(_value.unitSettings, (value) {
      return _then(_value.copyWith(unitSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CurrentWeatherModelCopyWith<$Res>
    implements $CurrentWeatherModelCopyWith<$Res> {
  factory _$$_CurrentWeatherModelCopyWith(_$_CurrentWeatherModel value,
          $Res Function(_$_CurrentWeatherModel) then) =
      __$$_CurrentWeatherModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int temp,
      int feelsLike,
      int windSpeed,
      String tempUnit,
      String condition,
      String speedUnit,
      UnitSettings unitSettings});

  @override
  $UnitSettingsCopyWith<$Res> get unitSettings;
}

/// @nodoc
class __$$_CurrentWeatherModelCopyWithImpl<$Res>
    extends _$CurrentWeatherModelCopyWithImpl<$Res, _$_CurrentWeatherModel>
    implements _$$_CurrentWeatherModelCopyWith<$Res> {
  __$$_CurrentWeatherModelCopyWithImpl(_$_CurrentWeatherModel _value,
      $Res Function(_$_CurrentWeatherModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temp = null,
    Object? feelsLike = null,
    Object? windSpeed = null,
    Object? tempUnit = null,
    Object? condition = null,
    Object? speedUnit = null,
    Object? unitSettings = null,
  }) {
    return _then(_$_CurrentWeatherModel(
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as int,
      feelsLike: null == feelsLike
          ? _value.feelsLike
          : feelsLike // ignore: cast_nullable_to_non_nullable
              as int,
      windSpeed: null == windSpeed
          ? _value.windSpeed
          : windSpeed // ignore: cast_nullable_to_non_nullable
              as int,
      tempUnit: null == tempUnit
          ? _value.tempUnit
          : tempUnit // ignore: cast_nullable_to_non_nullable
              as String,
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String,
      speedUnit: null == speedUnit
          ? _value.speedUnit
          : speedUnit // ignore: cast_nullable_to_non_nullable
              as String,
      unitSettings: null == unitSettings
          ? _value.unitSettings
          : unitSettings // ignore: cast_nullable_to_non_nullable
              as UnitSettings,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CurrentWeatherModel implements _CurrentWeatherModel {
  const _$_CurrentWeatherModel(
      {required this.temp,
      required this.feelsLike,
      required this.windSpeed,
      required this.tempUnit,
      required this.condition,
      required this.speedUnit,
      required this.unitSettings});

  factory _$_CurrentWeatherModel.fromJson(Map<String, dynamic> json) =>
      _$$_CurrentWeatherModelFromJson(json);

  @override
  final int temp;
  @override
  final int feelsLike;
  @override
  final int windSpeed;
  @override
  final String tempUnit;
  @override
  final String condition;
  @override
  final String speedUnit;
  @override
  final UnitSettings unitSettings;

  @override
  String toString() {
    return 'CurrentWeatherModel(temp: $temp, feelsLike: $feelsLike, windSpeed: $windSpeed, tempUnit: $tempUnit, condition: $condition, speedUnit: $speedUnit, unitSettings: $unitSettings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CurrentWeatherModel &&
            (identical(other.temp, temp) || other.temp == temp) &&
            (identical(other.feelsLike, feelsLike) ||
                other.feelsLike == feelsLike) &&
            (identical(other.windSpeed, windSpeed) ||
                other.windSpeed == windSpeed) &&
            (identical(other.tempUnit, tempUnit) ||
                other.tempUnit == tempUnit) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.speedUnit, speedUnit) ||
                other.speedUnit == speedUnit) &&
            (identical(other.unitSettings, unitSettings) ||
                other.unitSettings == unitSettings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, temp, feelsLike, windSpeed,
      tempUnit, condition, speedUnit, unitSettings);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CurrentWeatherModelCopyWith<_$_CurrentWeatherModel> get copyWith =>
      __$$_CurrentWeatherModelCopyWithImpl<_$_CurrentWeatherModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CurrentWeatherModelToJson(
      this,
    );
  }
}

abstract class _CurrentWeatherModel implements CurrentWeatherModel {
  const factory _CurrentWeatherModel(
      {required final int temp,
      required final int feelsLike,
      required final int windSpeed,
      required final String tempUnit,
      required final String condition,
      required final String speedUnit,
      required final UnitSettings unitSettings}) = _$_CurrentWeatherModel;

  factory _CurrentWeatherModel.fromJson(Map<String, dynamic> json) =
      _$_CurrentWeatherModel.fromJson;

  @override
  int get temp;
  @override
  int get feelsLike;
  @override
  int get windSpeed;
  @override
  String get tempUnit;
  @override
  String get condition;
  @override
  String get speedUnit;
  @override
  UnitSettings get unitSettings;
  @override
  @JsonKey(ignore: true)
  _$$_CurrentWeatherModelCopyWith<_$_CurrentWeatherModel> get copyWith =>
      throw _privateConstructorUsedError;
}
