// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'search_suggestion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SearchSuggestion _$SearchSuggestionFromJson(Map<String, dynamic> json) {
  return _SearchSuggestion.fromJson(json);
}

/// @nodoc
mixin _$SearchSuggestion {
  String get placeId => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<SearchText>? get searchTextList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchSuggestionCopyWith<SearchSuggestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchSuggestionCopyWith<$Res> {
  factory $SearchSuggestionCopyWith(
          SearchSuggestion value, $Res Function(SearchSuggestion) then) =
      _$SearchSuggestionCopyWithImpl<$Res, SearchSuggestion>;
  @useResult
  $Res call(
      {String placeId, String description, List<SearchText>? searchTextList});
}

/// @nodoc
class _$SearchSuggestionCopyWithImpl<$Res, $Val extends SearchSuggestion>
    implements $SearchSuggestionCopyWith<$Res> {
  _$SearchSuggestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? placeId = null,
    Object? description = null,
    Object? searchTextList = freezed,
  }) {
    return _then(_value.copyWith(
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      searchTextList: freezed == searchTextList
          ? _value.searchTextList
          : searchTextList // ignore: cast_nullable_to_non_nullable
              as List<SearchText>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SearchSuggestionCopyWith<$Res>
    implements $SearchSuggestionCopyWith<$Res> {
  factory _$$_SearchSuggestionCopyWith(
          _$_SearchSuggestion value, $Res Function(_$_SearchSuggestion) then) =
      __$$_SearchSuggestionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String placeId, String description, List<SearchText>? searchTextList});
}

/// @nodoc
class __$$_SearchSuggestionCopyWithImpl<$Res>
    extends _$SearchSuggestionCopyWithImpl<$Res, _$_SearchSuggestion>
    implements _$$_SearchSuggestionCopyWith<$Res> {
  __$$_SearchSuggestionCopyWithImpl(
      _$_SearchSuggestion _value, $Res Function(_$_SearchSuggestion) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? placeId = null,
    Object? description = null,
    Object? searchTextList = freezed,
  }) {
    return _then(_$_SearchSuggestion(
      placeId: null == placeId
          ? _value.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      searchTextList: freezed == searchTextList
          ? _value._searchTextList
          : searchTextList // ignore: cast_nullable_to_non_nullable
              as List<SearchText>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SearchSuggestion implements _SearchSuggestion {
  const _$_SearchSuggestion(
      {required this.placeId,
      required this.description,
      final List<SearchText>? searchTextList})
      : _searchTextList = searchTextList;

  factory _$_SearchSuggestion.fromJson(Map<String, dynamic> json) =>
      _$$_SearchSuggestionFromJson(json);

  @override
  final String placeId;
  @override
  final String description;
  final List<SearchText>? _searchTextList;
  @override
  List<SearchText>? get searchTextList {
    final value = _searchTextList;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SearchSuggestion(placeId: $placeId, description: $description, searchTextList: $searchTextList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SearchSuggestion &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._searchTextList, _searchTextList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, placeId, description,
      const DeepCollectionEquality().hash(_searchTextList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SearchSuggestionCopyWith<_$_SearchSuggestion> get copyWith =>
      __$$_SearchSuggestionCopyWithImpl<_$_SearchSuggestion>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SearchSuggestionToJson(
      this,
    );
  }
}

abstract class _SearchSuggestion implements SearchSuggestion {
  const factory _SearchSuggestion(
      {required final String placeId,
      required final String description,
      final List<SearchText>? searchTextList}) = _$_SearchSuggestion;

  factory _SearchSuggestion.fromJson(Map<String, dynamic> json) =
      _$_SearchSuggestion.fromJson;

  @override
  String get placeId;
  @override
  String get description;
  @override
  List<SearchText>? get searchTextList;
  @override
  @JsonKey(ignore: true)
  _$$_SearchSuggestionCopyWith<_$_SearchSuggestion> get copyWith =>
      throw _privateConstructorUsedError;
}
