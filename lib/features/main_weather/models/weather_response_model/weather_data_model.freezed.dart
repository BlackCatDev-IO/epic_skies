// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WeatherResponseModel _$WeatherResponseModelFromJson(Map<String, dynamic> json) {
  return _WeatherResponseModel.fromJson(json);
}

/// @nodoc
mixin _$WeatherResponseModel {
  CurrentData get currentCondition => throw _privateConstructorUsedError;
  List<DailyData> get days => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  num? get queryCost => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  String? get resolvedAddress => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get timezone => throw _privateConstructorUsedError;
  int? get tzoffset => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeatherResponseModelCopyWith<WeatherResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherResponseModelCopyWith<$Res> {
  factory $WeatherResponseModelCopyWith(WeatherResponseModel value,
          $Res Function(WeatherResponseModel) then) =
      _$WeatherResponseModelCopyWithImpl<$Res, WeatherResponseModel>;
  @useResult
  $Res call(
      {CurrentData currentCondition,
      List<DailyData> days,
      String description,
      num? queryCost,
      double? latitude,
      double? longitude,
      String? resolvedAddress,
      String? address,
      String? timezone,
      int? tzoffset});

  $CurrentDataCopyWith<$Res> get currentCondition;
}

/// @nodoc
class _$WeatherResponseModelCopyWithImpl<$Res,
        $Val extends WeatherResponseModel>
    implements $WeatherResponseModelCopyWith<$Res> {
  _$WeatherResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentCondition = null,
    Object? days = null,
    Object? description = null,
    Object? queryCost = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? resolvedAddress = freezed,
    Object? address = freezed,
    Object? timezone = freezed,
    Object? tzoffset = freezed,
  }) {
    return _then(_value.copyWith(
      currentCondition: null == currentCondition
          ? _value.currentCondition
          : currentCondition // ignore: cast_nullable_to_non_nullable
              as CurrentData,
      days: null == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as List<DailyData>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      queryCost: freezed == queryCost
          ? _value.queryCost
          : queryCost // ignore: cast_nullable_to_non_nullable
              as num?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      resolvedAddress: freezed == resolvedAddress
          ? _value.resolvedAddress
          : resolvedAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      timezone: freezed == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String?,
      tzoffset: freezed == tzoffset
          ? _value.tzoffset
          : tzoffset // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CurrentDataCopyWith<$Res> get currentCondition {
    return $CurrentDataCopyWith<$Res>(_value.currentCondition, (value) {
      return _then(_value.copyWith(currentCondition: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_WeatherResponseModelCopyWith<$Res>
    implements $WeatherResponseModelCopyWith<$Res> {
  factory _$$_WeatherResponseModelCopyWith(_$_WeatherResponseModel value,
          $Res Function(_$_WeatherResponseModel) then) =
      __$$_WeatherResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CurrentData currentCondition,
      List<DailyData> days,
      String description,
      num? queryCost,
      double? latitude,
      double? longitude,
      String? resolvedAddress,
      String? address,
      String? timezone,
      int? tzoffset});

  @override
  $CurrentDataCopyWith<$Res> get currentCondition;
}

/// @nodoc
class __$$_WeatherResponseModelCopyWithImpl<$Res>
    extends _$WeatherResponseModelCopyWithImpl<$Res, _$_WeatherResponseModel>
    implements _$$_WeatherResponseModelCopyWith<$Res> {
  __$$_WeatherResponseModelCopyWithImpl(_$_WeatherResponseModel _value,
      $Res Function(_$_WeatherResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentCondition = null,
    Object? days = null,
    Object? description = null,
    Object? queryCost = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? resolvedAddress = freezed,
    Object? address = freezed,
    Object? timezone = freezed,
    Object? tzoffset = freezed,
  }) {
    return _then(_$_WeatherResponseModel(
      currentCondition: null == currentCondition
          ? _value.currentCondition
          : currentCondition // ignore: cast_nullable_to_non_nullable
              as CurrentData,
      days: null == days
          ? _value._days
          : days // ignore: cast_nullable_to_non_nullable
              as List<DailyData>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      queryCost: freezed == queryCost
          ? _value.queryCost
          : queryCost // ignore: cast_nullable_to_non_nullable
              as num?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      resolvedAddress: freezed == resolvedAddress
          ? _value.resolvedAddress
          : resolvedAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      timezone: freezed == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String?,
      tzoffset: freezed == tzoffset
          ? _value.tzoffset
          : tzoffset // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WeatherResponseModel implements _WeatherResponseModel {
  _$_WeatherResponseModel(
      {required this.currentCondition,
      required final List<DailyData> days,
      required this.description,
      this.queryCost,
      this.latitude,
      this.longitude,
      this.resolvedAddress,
      this.address,
      this.timezone,
      this.tzoffset})
      : _days = days;

  factory _$_WeatherResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_WeatherResponseModelFromJson(json);

  @override
  final CurrentData currentCondition;
  final List<DailyData> _days;
  @override
  List<DailyData> get days {
    if (_days is EqualUnmodifiableListView) return _days;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_days);
  }

  @override
  final String description;
  @override
  final num? queryCost;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final String? resolvedAddress;
  @override
  final String? address;
  @override
  final String? timezone;
  @override
  final int? tzoffset;

  @override
  String toString() {
    return 'WeatherResponseModel(currentCondition: $currentCondition, days: $days, description: $description, queryCost: $queryCost, latitude: $latitude, longitude: $longitude, resolvedAddress: $resolvedAddress, address: $address, timezone: $timezone, tzoffset: $tzoffset)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WeatherResponseModel &&
            (identical(other.currentCondition, currentCondition) ||
                other.currentCondition == currentCondition) &&
            const DeepCollectionEquality().equals(other._days, _days) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.queryCost, queryCost) ||
                other.queryCost == queryCost) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.resolvedAddress, resolvedAddress) ||
                other.resolvedAddress == resolvedAddress) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.tzoffset, tzoffset) ||
                other.tzoffset == tzoffset));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentCondition,
      const DeepCollectionEquality().hash(_days),
      description,
      queryCost,
      latitude,
      longitude,
      resolvedAddress,
      address,
      timezone,
      tzoffset);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WeatherResponseModelCopyWith<_$_WeatherResponseModel> get copyWith =>
      __$$_WeatherResponseModelCopyWithImpl<_$_WeatherResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WeatherResponseModelToJson(
      this,
    );
  }
}

abstract class _WeatherResponseModel implements WeatherResponseModel {
  factory _WeatherResponseModel(
      {required final CurrentData currentCondition,
      required final List<DailyData> days,
      required final String description,
      final num? queryCost,
      final double? latitude,
      final double? longitude,
      final String? resolvedAddress,
      final String? address,
      final String? timezone,
      final int? tzoffset}) = _$_WeatherResponseModel;

  factory _WeatherResponseModel.fromJson(Map<String, dynamic> json) =
      _$_WeatherResponseModel.fromJson;

  @override
  CurrentData get currentCondition;
  @override
  List<DailyData> get days;
  @override
  String get description;
  @override
  num? get queryCost;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  String? get resolvedAddress;
  @override
  String? get address;
  @override
  String? get timezone;
  @override
  int? get tzoffset;
  @override
  @JsonKey(ignore: true)
  _$$_WeatherResponseModelCopyWith<_$_WeatherResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
