// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hourly_vertical_widget_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HourlyVerticalWidgetModel _$HourlyVerticalWidgetModelFromJson(
    Map<String, dynamic> json) {
  return _HourlyVerticalWidgetModel.fromJson(json);
}

/// @nodoc
mixin _$HourlyVerticalWidgetModel {
  int get temp => throw _privateConstructorUsedError;
  String get iconPath => throw _privateConstructorUsedError;
  num get precipitation => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  String? get suntimeString => throw _privateConstructorUsedError;
  bool? get isSunrise => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HourlyVerticalWidgetModelCopyWith<HourlyVerticalWidgetModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HourlyVerticalWidgetModelCopyWith<$Res> {
  factory $HourlyVerticalWidgetModelCopyWith(HourlyVerticalWidgetModel value,
          $Res Function(HourlyVerticalWidgetModel) then) =
      _$HourlyVerticalWidgetModelCopyWithImpl<$Res, HourlyVerticalWidgetModel>;
  @useResult
  $Res call(
      {int temp,
      String iconPath,
      num precipitation,
      String time,
      String? suntimeString,
      bool? isSunrise});
}

/// @nodoc
class _$HourlyVerticalWidgetModelCopyWithImpl<$Res,
        $Val extends HourlyVerticalWidgetModel>
    implements $HourlyVerticalWidgetModelCopyWith<$Res> {
  _$HourlyVerticalWidgetModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temp = null,
    Object? iconPath = null,
    Object? precipitation = null,
    Object? time = null,
    Object? suntimeString = freezed,
    Object? isSunrise = freezed,
  }) {
    return _then(_value.copyWith(
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as int,
      iconPath: null == iconPath
          ? _value.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String,
      precipitation: null == precipitation
          ? _value.precipitation
          : precipitation // ignore: cast_nullable_to_non_nullable
              as num,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      suntimeString: freezed == suntimeString
          ? _value.suntimeString
          : suntimeString // ignore: cast_nullable_to_non_nullable
              as String?,
      isSunrise: freezed == isSunrise
          ? _value.isSunrise
          : isSunrise // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HourlyVerticalWidgetModelCopyWith<$Res>
    implements $HourlyVerticalWidgetModelCopyWith<$Res> {
  factory _$$_HourlyVerticalWidgetModelCopyWith(
          _$_HourlyVerticalWidgetModel value,
          $Res Function(_$_HourlyVerticalWidgetModel) then) =
      __$$_HourlyVerticalWidgetModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int temp,
      String iconPath,
      num precipitation,
      String time,
      String? suntimeString,
      bool? isSunrise});
}

/// @nodoc
class __$$_HourlyVerticalWidgetModelCopyWithImpl<$Res>
    extends _$HourlyVerticalWidgetModelCopyWithImpl<$Res,
        _$_HourlyVerticalWidgetModel>
    implements _$$_HourlyVerticalWidgetModelCopyWith<$Res> {
  __$$_HourlyVerticalWidgetModelCopyWithImpl(
      _$_HourlyVerticalWidgetModel _value,
      $Res Function(_$_HourlyVerticalWidgetModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temp = null,
    Object? iconPath = null,
    Object? precipitation = null,
    Object? time = null,
    Object? suntimeString = freezed,
    Object? isSunrise = freezed,
  }) {
    return _then(_$_HourlyVerticalWidgetModel(
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as int,
      iconPath: null == iconPath
          ? _value.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String,
      precipitation: null == precipitation
          ? _value.precipitation
          : precipitation // ignore: cast_nullable_to_non_nullable
              as num,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      suntimeString: freezed == suntimeString
          ? _value.suntimeString
          : suntimeString // ignore: cast_nullable_to_non_nullable
              as String?,
      isSunrise: freezed == isSunrise
          ? _value.isSunrise
          : isSunrise // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HourlyVerticalWidgetModel implements _HourlyVerticalWidgetModel {
  _$_HourlyVerticalWidgetModel(
      {required this.temp,
      required this.iconPath,
      required this.precipitation,
      required this.time,
      this.suntimeString,
      this.isSunrise});

  factory _$_HourlyVerticalWidgetModel.fromJson(Map<String, dynamic> json) =>
      _$$_HourlyVerticalWidgetModelFromJson(json);

  @override
  final int temp;
  @override
  final String iconPath;
  @override
  final num precipitation;
  @override
  final String time;
  @override
  final String? suntimeString;
  @override
  final bool? isSunrise;

  @override
  String toString() {
    return 'HourlyVerticalWidgetModel(temp: $temp, iconPath: $iconPath, precipitation: $precipitation, time: $time, suntimeString: $suntimeString, isSunrise: $isSunrise)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HourlyVerticalWidgetModel &&
            (identical(other.temp, temp) || other.temp == temp) &&
            (identical(other.iconPath, iconPath) ||
                other.iconPath == iconPath) &&
            (identical(other.precipitation, precipitation) ||
                other.precipitation == precipitation) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.suntimeString, suntimeString) ||
                other.suntimeString == suntimeString) &&
            (identical(other.isSunrise, isSunrise) ||
                other.isSunrise == isSunrise));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, temp, iconPath, precipitation,
      time, suntimeString, isSunrise);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HourlyVerticalWidgetModelCopyWith<_$_HourlyVerticalWidgetModel>
      get copyWith => __$$_HourlyVerticalWidgetModelCopyWithImpl<
          _$_HourlyVerticalWidgetModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HourlyVerticalWidgetModelToJson(
      this,
    );
  }
}

abstract class _HourlyVerticalWidgetModel implements HourlyVerticalWidgetModel {
  factory _HourlyVerticalWidgetModel(
      {required final int temp,
      required final String iconPath,
      required final num precipitation,
      required final String time,
      final String? suntimeString,
      final bool? isSunrise}) = _$_HourlyVerticalWidgetModel;

  factory _HourlyVerticalWidgetModel.fromJson(Map<String, dynamic> json) =
      _$_HourlyVerticalWidgetModel.fromJson;

  @override
  int get temp;
  @override
  String get iconPath;
  @override
  num get precipitation;
  @override
  String get time;
  @override
  String? get suntimeString;
  @override
  bool? get isSunrise;
  @override
  @JsonKey(ignore: true)
  _$$_HourlyVerticalWidgetModelCopyWith<_$_HourlyVerticalWidgetModel>
      get copyWith => throw _privateConstructorUsedError;
}
