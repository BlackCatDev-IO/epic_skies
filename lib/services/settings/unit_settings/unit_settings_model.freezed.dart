// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'unit_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UnitSettings _$UnitSettingsFromJson(Map<String, dynamic> json) {
  return _UnitSettings.fromJson(json);
}

/// @nodoc
mixin _$UnitSettings {
  bool get tempUnitsMetric => throw _privateConstructorUsedError;
  bool get timeIn24Hrs => throw _privateConstructorUsedError;
  bool get precipInMm => throw _privateConstructorUsedError;
  bool get speedInKph => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnitSettingsCopyWith<UnitSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnitSettingsCopyWith<$Res> {
  factory $UnitSettingsCopyWith(
          UnitSettings value, $Res Function(UnitSettings) then) =
      _$UnitSettingsCopyWithImpl<$Res, UnitSettings>;
  @useResult
  $Res call(
      {bool tempUnitsMetric,
      bool timeIn24Hrs,
      bool precipInMm,
      bool speedInKph});
}

/// @nodoc
class _$UnitSettingsCopyWithImpl<$Res, $Val extends UnitSettings>
    implements $UnitSettingsCopyWith<$Res> {
  _$UnitSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tempUnitsMetric = null,
    Object? timeIn24Hrs = null,
    Object? precipInMm = null,
    Object? speedInKph = null,
  }) {
    return _then(_value.copyWith(
      tempUnitsMetric: null == tempUnitsMetric
          ? _value.tempUnitsMetric
          : tempUnitsMetric // ignore: cast_nullable_to_non_nullable
              as bool,
      timeIn24Hrs: null == timeIn24Hrs
          ? _value.timeIn24Hrs
          : timeIn24Hrs // ignore: cast_nullable_to_non_nullable
              as bool,
      precipInMm: null == precipInMm
          ? _value.precipInMm
          : precipInMm // ignore: cast_nullable_to_non_nullable
              as bool,
      speedInKph: null == speedInKph
          ? _value.speedInKph
          : speedInKph // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UnitSettingsCopyWith<$Res>
    implements $UnitSettingsCopyWith<$Res> {
  factory _$$_UnitSettingsCopyWith(
          _$_UnitSettings value, $Res Function(_$_UnitSettings) then) =
      __$$_UnitSettingsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool tempUnitsMetric,
      bool timeIn24Hrs,
      bool precipInMm,
      bool speedInKph});
}

/// @nodoc
class __$$_UnitSettingsCopyWithImpl<$Res>
    extends _$UnitSettingsCopyWithImpl<$Res, _$_UnitSettings>
    implements _$$_UnitSettingsCopyWith<$Res> {
  __$$_UnitSettingsCopyWithImpl(
      _$_UnitSettings _value, $Res Function(_$_UnitSettings) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tempUnitsMetric = null,
    Object? timeIn24Hrs = null,
    Object? precipInMm = null,
    Object? speedInKph = null,
  }) {
    return _then(_$_UnitSettings(
      tempUnitsMetric: null == tempUnitsMetric
          ? _value.tempUnitsMetric
          : tempUnitsMetric // ignore: cast_nullable_to_non_nullable
              as bool,
      timeIn24Hrs: null == timeIn24Hrs
          ? _value.timeIn24Hrs
          : timeIn24Hrs // ignore: cast_nullable_to_non_nullable
              as bool,
      precipInMm: null == precipInMm
          ? _value.precipInMm
          : precipInMm // ignore: cast_nullable_to_non_nullable
              as bool,
      speedInKph: null == speedInKph
          ? _value.speedInKph
          : speedInKph // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UnitSettings implements _UnitSettings {
  const _$_UnitSettings(
      {required this.tempUnitsMetric,
      required this.timeIn24Hrs,
      required this.precipInMm,
      required this.speedInKph});

  factory _$_UnitSettings.fromJson(Map<String, dynamic> json) =>
      _$$_UnitSettingsFromJson(json);

  @override
  final bool tempUnitsMetric;
  @override
  final bool timeIn24Hrs;
  @override
  final bool precipInMm;
  @override
  final bool speedInKph;

  @override
  String toString() {
    return 'UnitSettings(tempUnitsMetric: $tempUnitsMetric, timeIn24Hrs: $timeIn24Hrs, precipInMm: $precipInMm, speedInKph: $speedInKph)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UnitSettings &&
            (identical(other.tempUnitsMetric, tempUnitsMetric) ||
                other.tempUnitsMetric == tempUnitsMetric) &&
            (identical(other.timeIn24Hrs, timeIn24Hrs) ||
                other.timeIn24Hrs == timeIn24Hrs) &&
            (identical(other.precipInMm, precipInMm) ||
                other.precipInMm == precipInMm) &&
            (identical(other.speedInKph, speedInKph) ||
                other.speedInKph == speedInKph));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, tempUnitsMetric, timeIn24Hrs, precipInMm, speedInKph);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UnitSettingsCopyWith<_$_UnitSettings> get copyWith =>
      __$$_UnitSettingsCopyWithImpl<_$_UnitSettings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UnitSettingsToJson(
      this,
    );
  }
}

abstract class _UnitSettings implements UnitSettings {
  const factory _UnitSettings(
      {required final bool tempUnitsMetric,
      required final bool timeIn24Hrs,
      required final bool precipInMm,
      required final bool speedInKph}) = _$_UnitSettings;

  factory _UnitSettings.fromJson(Map<String, dynamic> json) =
      _$_UnitSettings.fromJson;

  @override
  bool get tempUnitsMetric;
  @override
  bool get timeIn24Hrs;
  @override
  bool get precipInMm;
  @override
  bool get speedInKph;
  @override
  @JsonKey(ignore: true)
  _$$_UnitSettingsCopyWith<_$_UnitSettings> get copyWith =>
      throw _privateConstructorUsedError;
}
