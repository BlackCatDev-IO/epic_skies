// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_text.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SearchText _$SearchTextFromJson(Map<String, dynamic> json) {
  return _SearchText.fromJson(json);
}

/// @nodoc
mixin _$SearchText {
  String get text => throw _privateConstructorUsedError;
  bool get isBold => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchTextCopyWith<SearchText> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchTextCopyWith<$Res> {
  factory $SearchTextCopyWith(
          SearchText value, $Res Function(SearchText) then) =
      _$SearchTextCopyWithImpl<$Res, SearchText>;
  @useResult
  $Res call({String text, bool isBold});
}

/// @nodoc
class _$SearchTextCopyWithImpl<$Res, $Val extends SearchText>
    implements $SearchTextCopyWith<$Res> {
  _$SearchTextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? isBold = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isBold: null == isBold
          ? _value.isBold
          : isBold // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchTextImplCopyWith<$Res>
    implements $SearchTextCopyWith<$Res> {
  factory _$$SearchTextImplCopyWith(
          _$SearchTextImpl value, $Res Function(_$SearchTextImpl) then) =
      __$$SearchTextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, bool isBold});
}

/// @nodoc
class __$$SearchTextImplCopyWithImpl<$Res>
    extends _$SearchTextCopyWithImpl<$Res, _$SearchTextImpl>
    implements _$$SearchTextImplCopyWith<$Res> {
  __$$SearchTextImplCopyWithImpl(
      _$SearchTextImpl _value, $Res Function(_$SearchTextImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? isBold = null,
  }) {
    return _then(_$SearchTextImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isBold: null == isBold
          ? _value.isBold
          : isBold // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchTextImpl implements _SearchText {
  const _$SearchTextImpl({required this.text, required this.isBold});

  factory _$SearchTextImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchTextImplFromJson(json);

  @override
  final String text;
  @override
  final bool isBold;

  @override
  String toString() {
    return 'SearchText(text: $text, isBold: $isBold)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchTextImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.isBold, isBold) || other.isBold == isBold));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, text, isBold);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchTextImplCopyWith<_$SearchTextImpl> get copyWith =>
      __$$SearchTextImplCopyWithImpl<_$SearchTextImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchTextImplToJson(
      this,
    );
  }
}

abstract class _SearchText implements SearchText {
  const factory _SearchText(
      {required final String text,
      required final bool isBold}) = _$SearchTextImpl;

  factory _SearchText.fromJson(Map<String, dynamic> json) =
      _$SearchTextImpl.fromJson;

  @override
  String get text;
  @override
  bool get isBold;
  @override
  @JsonKey(ignore: true)
  _$$SearchTextImplCopyWith<_$SearchTextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
