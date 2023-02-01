// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sun_time_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SunTimesModel _$SunTimesModelFromJson(Map<String, dynamic> json) {
  return _SunTimesModel.fromJson(json);
}

/// @nodoc
mixin _$SunTimesModel {
  String get sunsetString => throw _privateConstructorUsedError;
  String get sunriseString => throw _privateConstructorUsedError;
  DateTime? get sunriseTime => throw _privateConstructorUsedError;
  DateTime? get sunsetTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SunTimesModelCopyWith<SunTimesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SunTimesModelCopyWith<$Res> {
  factory $SunTimesModelCopyWith(
          SunTimesModel value, $Res Function(SunTimesModel) then) =
      _$SunTimesModelCopyWithImpl<$Res, SunTimesModel>;
  @useResult
  $Res call(
      {String sunsetString,
      String sunriseString,
      DateTime? sunriseTime,
      DateTime? sunsetTime});
}

/// @nodoc
class _$SunTimesModelCopyWithImpl<$Res, $Val extends SunTimesModel>
    implements $SunTimesModelCopyWith<$Res> {
  _$SunTimesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sunsetString = null,
    Object? sunriseString = null,
    Object? sunriseTime = freezed,
    Object? sunsetTime = freezed,
  }) {
    return _then(_value.copyWith(
      sunsetString: null == sunsetString
          ? _value.sunsetString
          : sunsetString // ignore: cast_nullable_to_non_nullable
              as String,
      sunriseString: null == sunriseString
          ? _value.sunriseString
          : sunriseString // ignore: cast_nullable_to_non_nullable
              as String,
      sunriseTime: freezed == sunriseTime
          ? _value.sunriseTime
          : sunriseTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sunsetTime: freezed == sunsetTime
          ? _value.sunsetTime
          : sunsetTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SunTimesModelCopyWith<$Res>
    implements $SunTimesModelCopyWith<$Res> {
  factory _$$_SunTimesModelCopyWith(
          _$_SunTimesModel value, $Res Function(_$_SunTimesModel) then) =
      __$$_SunTimesModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sunsetString,
      String sunriseString,
      DateTime? sunriseTime,
      DateTime? sunsetTime});
}

/// @nodoc
class __$$_SunTimesModelCopyWithImpl<$Res>
    extends _$SunTimesModelCopyWithImpl<$Res, _$_SunTimesModel>
    implements _$$_SunTimesModelCopyWith<$Res> {
  __$$_SunTimesModelCopyWithImpl(
      _$_SunTimesModel _value, $Res Function(_$_SunTimesModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sunsetString = null,
    Object? sunriseString = null,
    Object? sunriseTime = freezed,
    Object? sunsetTime = freezed,
  }) {
    return _then(_$_SunTimesModel(
      sunsetString: null == sunsetString
          ? _value.sunsetString
          : sunsetString // ignore: cast_nullable_to_non_nullable
              as String,
      sunriseString: null == sunriseString
          ? _value.sunriseString
          : sunriseString // ignore: cast_nullable_to_non_nullable
              as String,
      sunriseTime: freezed == sunriseTime
          ? _value.sunriseTime
          : sunriseTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sunsetTime: freezed == sunsetTime
          ? _value.sunsetTime
          : sunsetTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SunTimesModel implements _SunTimesModel {
  _$_SunTimesModel(
      {required this.sunsetString,
      required this.sunriseString,
      this.sunriseTime,
      this.sunsetTime});

  factory _$_SunTimesModel.fromJson(Map<String, dynamic> json) =>
      _$$_SunTimesModelFromJson(json);

  @override
  final String sunsetString;
  @override
  final String sunriseString;
  @override
  final DateTime? sunriseTime;
  @override
  final DateTime? sunsetTime;

  @override
  String toString() {
    return 'SunTimesModel(sunsetString: $sunsetString, sunriseString: $sunriseString, sunriseTime: $sunriseTime, sunsetTime: $sunsetTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SunTimesModel &&
            (identical(other.sunsetString, sunsetString) ||
                other.sunsetString == sunsetString) &&
            (identical(other.sunriseString, sunriseString) ||
                other.sunriseString == sunriseString) &&
            (identical(other.sunriseTime, sunriseTime) ||
                other.sunriseTime == sunriseTime) &&
            (identical(other.sunsetTime, sunsetTime) ||
                other.sunsetTime == sunsetTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, sunsetString, sunriseString, sunriseTime, sunsetTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SunTimesModelCopyWith<_$_SunTimesModel> get copyWith =>
      __$$_SunTimesModelCopyWithImpl<_$_SunTimesModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SunTimesModelToJson(
      this,
    );
  }
}

abstract class _SunTimesModel implements SunTimesModel {
  factory _SunTimesModel(
      {required final String sunsetString,
      required final String sunriseString,
      final DateTime? sunriseTime,
      final DateTime? sunsetTime}) = _$_SunTimesModel;

  factory _SunTimesModel.fromJson(Map<String, dynamic> json) =
      _$_SunTimesModel.fromJson;

  @override
  String get sunsetString;
  @override
  String get sunriseString;
  @override
  DateTime? get sunriseTime;
  @override
  DateTime? get sunsetTime;
  @override
  @JsonKey(ignore: true)
  _$$_SunTimesModelCopyWith<_$_SunTimesModel> get copyWith =>
      throw _privateConstructorUsedError;
}
