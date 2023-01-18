// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
  ImageSettings get imageSettings => throw _privateConstructorUsedError;
  String get bgImagePath => throw _privateConstructorUsedError;
  Map<String, List<String>> get imageFileMap =>
      throw _privateConstructorUsedError;
  List<String> get imageFileList => throw _privateConstructorUsedError;

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
      {ImageSettings imageSettings,
      String bgImagePath,
      Map<String, List<String>> imageFileMap,
      List<String> imageFileList});
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
    Object? imageSettings = null,
    Object? bgImagePath = null,
    Object? imageFileMap = null,
    Object? imageFileList = null,
  }) {
    return _then(_value.copyWith(
      imageSettings: null == imageSettings
          ? _value.imageSettings
          : imageSettings // ignore: cast_nullable_to_non_nullable
              as ImageSettings,
      bgImagePath: null == bgImagePath
          ? _value.bgImagePath
          : bgImagePath // ignore: cast_nullable_to_non_nullable
              as String,
      imageFileMap: null == imageFileMap
          ? _value.imageFileMap
          : imageFileMap // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      imageFileList: null == imageFileList
          ? _value.imageFileList
          : imageFileList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BgImageStateCopyWith<$Res>
    implements $BgImageStateCopyWith<$Res> {
  factory _$$_BgImageStateCopyWith(
          _$_BgImageState value, $Res Function(_$_BgImageState) then) =
      __$$_BgImageStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ImageSettings imageSettings,
      String bgImagePath,
      Map<String, List<String>> imageFileMap,
      List<String> imageFileList});
}

/// @nodoc
class __$$_BgImageStateCopyWithImpl<$Res>
    extends _$BgImageStateCopyWithImpl<$Res, _$_BgImageState>
    implements _$$_BgImageStateCopyWith<$Res> {
  __$$_BgImageStateCopyWithImpl(
      _$_BgImageState _value, $Res Function(_$_BgImageState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageSettings = null,
    Object? bgImagePath = null,
    Object? imageFileMap = null,
    Object? imageFileList = null,
  }) {
    return _then(_$_BgImageState(
      imageSettings: null == imageSettings
          ? _value.imageSettings
          : imageSettings // ignore: cast_nullable_to_non_nullable
              as ImageSettings,
      bgImagePath: null == bgImagePath
          ? _value.bgImagePath
          : bgImagePath // ignore: cast_nullable_to_non_nullable
              as String,
      imageFileMap: null == imageFileMap
          ? _value._imageFileMap
          : imageFileMap // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      imageFileList: null == imageFileList
          ? _value._imageFileList
          : imageFileList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BgImageState implements _BgImageState {
  const _$_BgImageState(
      {required this.imageSettings,
      required this.bgImagePath,
      required final Map<String, List<String>> imageFileMap,
      required final List<String> imageFileList})
      : _imageFileMap = imageFileMap,
        _imageFileList = imageFileList;

  factory _$_BgImageState.fromJson(Map<String, dynamic> json) =>
      _$$_BgImageStateFromJson(json);

  @override
  final ImageSettings imageSettings;
  @override
  final String bgImagePath;
  final Map<String, List<String>> _imageFileMap;
  @override
  Map<String, List<String>> get imageFileMap {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_imageFileMap);
  }

  final List<String> _imageFileList;
  @override
  List<String> get imageFileList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageFileList);
  }

  @override
  String toString() {
    return 'BgImageState(imageSettings: $imageSettings, bgImagePath: $bgImagePath, imageFileMap: $imageFileMap, imageFileList: $imageFileList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BgImageState &&
            (identical(other.imageSettings, imageSettings) ||
                other.imageSettings == imageSettings) &&
            (identical(other.bgImagePath, bgImagePath) ||
                other.bgImagePath == bgImagePath) &&
            const DeepCollectionEquality()
                .equals(other._imageFileMap, _imageFileMap) &&
            const DeepCollectionEquality()
                .equals(other._imageFileList, _imageFileList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      imageSettings,
      bgImagePath,
      const DeepCollectionEquality().hash(_imageFileMap),
      const DeepCollectionEquality().hash(_imageFileList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BgImageStateCopyWith<_$_BgImageState> get copyWith =>
      __$$_BgImageStateCopyWithImpl<_$_BgImageState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BgImageStateToJson(
      this,
    );
  }
}

abstract class _BgImageState implements BgImageState {
  const factory _BgImageState(
      {required final ImageSettings imageSettings,
      required final String bgImagePath,
      required final Map<String, List<String>> imageFileMap,
      required final List<String> imageFileList}) = _$_BgImageState;

  factory _BgImageState.fromJson(Map<String, dynamic> json) =
      _$_BgImageState.fromJson;

  @override
  ImageSettings get imageSettings;
  @override
  String get bgImagePath;
  @override
  Map<String, List<String>> get imageFileMap;
  @override
  List<String> get imageFileList;
  @override
  @JsonKey(ignore: true)
  _$$_BgImageStateCopyWith<_$_BgImageState> get copyWith =>
      throw _privateConstructorUsedError;
}
