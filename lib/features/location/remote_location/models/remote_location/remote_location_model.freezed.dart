// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remote_location_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RemoteLocationModel _$RemoteLocationModelFromJson(Map<String, dynamic> json) {
  return _RemoteLocationModel.fromJson(json);
}

/// @nodoc
mixin _$RemoteLocationModel {
  double get remoteLat => throw _privateConstructorUsedError;
  double get remoteLong => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  List<String>? get longNameList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RemoteLocationModelCopyWith<RemoteLocationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemoteLocationModelCopyWith<$Res> {
  factory $RemoteLocationModelCopyWith(
          RemoteLocationModel value, $Res Function(RemoteLocationModel) then) =
      _$RemoteLocationModelCopyWithImpl<$Res, RemoteLocationModel>;
  @useResult
  $Res call(
      {double remoteLat,
      double remoteLong,
      String city,
      String state,
      String country,
      List<String>? longNameList});
}

/// @nodoc
class _$RemoteLocationModelCopyWithImpl<$Res, $Val extends RemoteLocationModel>
    implements $RemoteLocationModelCopyWith<$Res> {
  _$RemoteLocationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remoteLat = null,
    Object? remoteLong = null,
    Object? city = null,
    Object? state = null,
    Object? country = null,
    Object? longNameList = freezed,
  }) {
    return _then(_value.copyWith(
      remoteLat: null == remoteLat
          ? _value.remoteLat
          : remoteLat // ignore: cast_nullable_to_non_nullable
              as double,
      remoteLong: null == remoteLong
          ? _value.remoteLong
          : remoteLong // ignore: cast_nullable_to_non_nullable
              as double,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      longNameList: freezed == longNameList
          ? _value.longNameList
          : longNameList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RemoteLocationModelCopyWith<$Res>
    implements $RemoteLocationModelCopyWith<$Res> {
  factory _$$_RemoteLocationModelCopyWith(_$_RemoteLocationModel value,
          $Res Function(_$_RemoteLocationModel) then) =
      __$$_RemoteLocationModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double remoteLat,
      double remoteLong,
      String city,
      String state,
      String country,
      List<String>? longNameList});
}

/// @nodoc
class __$$_RemoteLocationModelCopyWithImpl<$Res>
    extends _$RemoteLocationModelCopyWithImpl<$Res, _$_RemoteLocationModel>
    implements _$$_RemoteLocationModelCopyWith<$Res> {
  __$$_RemoteLocationModelCopyWithImpl(_$_RemoteLocationModel _value,
      $Res Function(_$_RemoteLocationModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remoteLat = null,
    Object? remoteLong = null,
    Object? city = null,
    Object? state = null,
    Object? country = null,
    Object? longNameList = freezed,
  }) {
    return _then(_$_RemoteLocationModel(
      remoteLat: null == remoteLat
          ? _value.remoteLat
          : remoteLat // ignore: cast_nullable_to_non_nullable
              as double,
      remoteLong: null == remoteLong
          ? _value.remoteLong
          : remoteLong // ignore: cast_nullable_to_non_nullable
              as double,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      longNameList: freezed == longNameList
          ? _value._longNameList
          : longNameList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RemoteLocationModel implements _RemoteLocationModel {
  const _$_RemoteLocationModel(
      {this.remoteLat = 0.0,
      this.remoteLong = 0.0,
      this.city = '',
      this.state = '',
      this.country = '',
      final List<String>? longNameList = null})
      : _longNameList = longNameList;

  factory _$_RemoteLocationModel.fromJson(Map<String, dynamic> json) =>
      _$$_RemoteLocationModelFromJson(json);

  @override
  @JsonKey()
  final double remoteLat;
  @override
  @JsonKey()
  final double remoteLong;
  @override
  @JsonKey()
  final String city;
  @override
  @JsonKey()
  final String state;
  @override
  @JsonKey()
  final String country;
  final List<String>? _longNameList;
  @override
  @JsonKey()
  List<String>? get longNameList {
    final value = _longNameList;
    if (value == null) return null;
    if (_longNameList is EqualUnmodifiableListView) return _longNameList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'RemoteLocationModel(remoteLat: $remoteLat, remoteLong: $remoteLong, city: $city, state: $state, country: $country, longNameList: $longNameList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RemoteLocationModel &&
            (identical(other.remoteLat, remoteLat) ||
                other.remoteLat == remoteLat) &&
            (identical(other.remoteLong, remoteLong) ||
                other.remoteLong == remoteLong) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.country, country) || other.country == country) &&
            const DeepCollectionEquality()
                .equals(other._longNameList, _longNameList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, remoteLat, remoteLong, city,
      state, country, const DeepCollectionEquality().hash(_longNameList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RemoteLocationModelCopyWith<_$_RemoteLocationModel> get copyWith =>
      __$$_RemoteLocationModelCopyWithImpl<_$_RemoteLocationModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RemoteLocationModelToJson(
      this,
    );
  }
}

abstract class _RemoteLocationModel implements RemoteLocationModel {
  const factory _RemoteLocationModel(
      {final double remoteLat,
      final double remoteLong,
      final String city,
      final String state,
      final String country,
      final List<String>? longNameList}) = _$_RemoteLocationModel;

  factory _RemoteLocationModel.fromJson(Map<String, dynamic> json) =
      _$_RemoteLocationModel.fromJson;

  @override
  double get remoteLat;
  @override
  double get remoteLong;
  @override
  String get city;
  @override
  String get state;
  @override
  String get country;
  @override
  List<String>? get longNameList;
  @override
  @JsonKey(ignore: true)
  _$$_RemoteLocationModelCopyWith<_$_RemoteLocationModel> get copyWith =>
      throw _privateConstructorUsedError;
}
