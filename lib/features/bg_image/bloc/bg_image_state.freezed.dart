// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bg_image_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BgImageState _$BgImageStateFromJson(Map<String, dynamic> json) {
  return _BgImageState.fromJson(json);
}

/// @nodoc
mixin _$BgImageState {
  BgImageStatus get status => throw _privateConstructorUsedError;
  List<WeatherImageModel> get bgImageList => throw _privateConstructorUsedError;
  ImageSettings get imageSettings => throw _privateConstructorUsedError;
  String get bgImagePath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BgImageStateCopyWith<BgImageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BgImageStateCopyWith<$Res> {
  factory $BgImageStateCopyWith(
          BgImageState value, $Res Function(BgImageState) then) =
      _$BgImageStateCopyWithImpl<$Res, BgImageState>;
  @useResult
  $Res call(
      {BgImageStatus status,
      List<WeatherImageModel> bgImageList,
      ImageSettings imageSettings,
      String bgImagePath});
}

/// @nodoc
class _$BgImageStateCopyWithImpl<$Res, $Val extends BgImageState>
    implements $BgImageStateCopyWith<$Res> {
  _$BgImageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? bgImageList = null,
    Object? imageSettings = null,
    Object? bgImagePath = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BgImageStatus,
      bgImageList: null == bgImageList
          ? _value.bgImageList
          : bgImageList // ignore: cast_nullable_to_non_nullable
              as List<WeatherImageModel>,
      imageSettings: null == imageSettings
          ? _value.imageSettings
          : imageSettings // ignore: cast_nullable_to_non_nullable
              as ImageSettings,
      bgImagePath: null == bgImagePath
          ? _value.bgImagePath
          : bgImagePath // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BgImageStateImplCopyWith<$Res>
    implements $BgImageStateCopyWith<$Res> {
  factory _$$BgImageStateImplCopyWith(
          _$BgImageStateImpl value, $Res Function(_$BgImageStateImpl) then) =
      __$$BgImageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BgImageStatus status,
      List<WeatherImageModel> bgImageList,
      ImageSettings imageSettings,
      String bgImagePath});
}

/// @nodoc
class __$$BgImageStateImplCopyWithImpl<$Res>
    extends _$BgImageStateCopyWithImpl<$Res, _$BgImageStateImpl>
    implements _$$BgImageStateImplCopyWith<$Res> {
  __$$BgImageStateImplCopyWithImpl(
      _$BgImageStateImpl _value, $Res Function(_$BgImageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? bgImageList = null,
    Object? imageSettings = null,
    Object? bgImagePath = null,
  }) {
    return _then(_$BgImageStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BgImageStatus,
      bgImageList: null == bgImageList
          ? _value._bgImageList
          : bgImageList // ignore: cast_nullable_to_non_nullable
              as List<WeatherImageModel>,
      imageSettings: null == imageSettings
          ? _value.imageSettings
          : imageSettings // ignore: cast_nullable_to_non_nullable
              as ImageSettings,
      bgImagePath: null == bgImagePath
          ? _value.bgImagePath
          : bgImagePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BgImageStateImpl extends _BgImageState {
  const _$BgImageStateImpl(
      {this.status = BgImageStatus.initial,
      final List<WeatherImageModel> bgImageList = const [],
      this.imageSettings = ImageSettings.dynamic,
      this.bgImagePath = ''})
      : _bgImageList = bgImageList,
        super._();

  factory _$BgImageStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$BgImageStateImplFromJson(json);

  @override
  @JsonKey()
  final BgImageStatus status;
  final List<WeatherImageModel> _bgImageList;
  @override
  @JsonKey()
  List<WeatherImageModel> get bgImageList {
    if (_bgImageList is EqualUnmodifiableListView) return _bgImageList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bgImageList);
  }

  @override
  @JsonKey()
  final ImageSettings imageSettings;
  @override
  @JsonKey()
  final String bgImagePath;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BgImageStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._bgImageList, _bgImageList) &&
            (identical(other.imageSettings, imageSettings) ||
                other.imageSettings == imageSettings) &&
            (identical(other.bgImagePath, bgImagePath) ||
                other.bgImagePath == bgImagePath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_bgImageList),
      imageSettings,
      bgImagePath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BgImageStateImplCopyWith<_$BgImageStateImpl> get copyWith =>
      __$$BgImageStateImplCopyWithImpl<_$BgImageStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BgImageStateImplToJson(
      this,
    );
  }
}

abstract class _BgImageState extends BgImageState {
  const factory _BgImageState(
      {final BgImageStatus status,
      final List<WeatherImageModel> bgImageList,
      final ImageSettings imageSettings,
      final String bgImagePath}) = _$BgImageStateImpl;
  const _BgImageState._() : super._();

  factory _BgImageState.fromJson(Map<String, dynamic> json) =
      _$BgImageStateImpl.fromJson;

  @override
  BgImageStatus get status;
  @override
  List<WeatherImageModel> get bgImageList;
  @override
  ImageSettings get imageSettings;
  @override
  String get bgImagePath;
  @override
  @JsonKey(ignore: true)
  _$$BgImageStateImplCopyWith<_$BgImageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
