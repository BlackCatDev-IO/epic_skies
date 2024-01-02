// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_image_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WeatherImageModel _$WeatherImageModelFromJson(Map<String, dynamic> json) {
  return _WeatherImageModel.fromJson(json);
}

/// @nodoc
mixin _$WeatherImageModel {
  WeatherImageType get condition => throw _privateConstructorUsedError;
  bool get isDay => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeatherImageModelCopyWith<WeatherImageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherImageModelCopyWith<$Res> {
  factory $WeatherImageModelCopyWith(
          WeatherImageModel value, $Res Function(WeatherImageModel) then) =
      _$WeatherImageModelCopyWithImpl<$Res, WeatherImageModel>;
  @useResult
  $Res call({WeatherImageType condition, bool isDay, String imageUrl});
}

/// @nodoc
class _$WeatherImageModelCopyWithImpl<$Res, $Val extends WeatherImageModel>
    implements $WeatherImageModelCopyWith<$Res> {
  _$WeatherImageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? condition = null,
    Object? isDay = null,
    Object? imageUrl = null,
  }) {
    return _then(_value.copyWith(
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as WeatherImageType,
      isDay: null == isDay
          ? _value.isDay
          : isDay // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeatherImageModelImplCopyWith<$Res>
    implements $WeatherImageModelCopyWith<$Res> {
  factory _$$WeatherImageModelImplCopyWith(_$WeatherImageModelImpl value,
          $Res Function(_$WeatherImageModelImpl) then) =
      __$$WeatherImageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({WeatherImageType condition, bool isDay, String imageUrl});
}

/// @nodoc
class __$$WeatherImageModelImplCopyWithImpl<$Res>
    extends _$WeatherImageModelCopyWithImpl<$Res, _$WeatherImageModelImpl>
    implements _$$WeatherImageModelImplCopyWith<$Res> {
  __$$WeatherImageModelImplCopyWithImpl(_$WeatherImageModelImpl _value,
      $Res Function(_$WeatherImageModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? condition = null,
    Object? isDay = null,
    Object? imageUrl = null,
  }) {
    return _then(_$WeatherImageModelImpl(
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as WeatherImageType,
      isDay: null == isDay
          ? _value.isDay
          : isDay // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeatherImageModelImpl implements _WeatherImageModel {
  const _$WeatherImageModelImpl(
      {required this.condition, required this.isDay, required this.imageUrl});

  factory _$WeatherImageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeatherImageModelImplFromJson(json);

  @override
  final WeatherImageType condition;
  @override
  final bool isDay;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'WeatherImageModel(condition: $condition, isDay: $isDay, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherImageModelImpl &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.isDay, isDay) || other.isDay == isDay) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, condition, isDay, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherImageModelImplCopyWith<_$WeatherImageModelImpl> get copyWith =>
      __$$WeatherImageModelImplCopyWithImpl<_$WeatherImageModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeatherImageModelImplToJson(
      this,
    );
  }
}

abstract class _WeatherImageModel implements WeatherImageModel {
  const factory _WeatherImageModel(
      {required final WeatherImageType condition,
      required final bool isDay,
      required final String imageUrl}) = _$WeatherImageModelImpl;

  factory _WeatherImageModel.fromJson(Map<String, dynamic> json) =
      _$WeatherImageModelImpl.fromJson;

  @override
  WeatherImageType get condition;
  @override
  bool get isDay;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$WeatherImageModelImplCopyWith<_$WeatherImageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
