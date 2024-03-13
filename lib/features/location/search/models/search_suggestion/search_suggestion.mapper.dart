// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'search_suggestion.dart';

class SearchSuggestionMapper extends ClassMapperBase<SearchSuggestion> {
  SearchSuggestionMapper._();

  static SearchSuggestionMapper? _instance;
  static SearchSuggestionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SearchSuggestionMapper._());
      SearchTextMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SearchSuggestion';

  static String _$placeId(SearchSuggestion v) => v.placeId;
  static const Field<SearchSuggestion, String> _f$placeId =
      Field('placeId', _$placeId);
  static String _$description(SearchSuggestion v) => v.description;
  static const Field<SearchSuggestion, String> _f$description =
      Field('description', _$description);
  static List<SearchText>? _$searchTextList(SearchSuggestion v) =>
      v.searchTextList;
  static const Field<SearchSuggestion, List<SearchText>> _f$searchTextList =
      Field('searchTextList', _$searchTextList, opt: true);

  @override
  final MappableFields<SearchSuggestion> fields = const {
    #placeId: _f$placeId,
    #description: _f$description,
    #searchTextList: _f$searchTextList,
  };

  static SearchSuggestion _instantiate(DecodingData data) {
    return SearchSuggestion(
        placeId: data.dec(_f$placeId),
        description: data.dec(_f$description),
        searchTextList: data.dec(_f$searchTextList));
  }

  @override
  final Function instantiate = _instantiate;

  static SearchSuggestion fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SearchSuggestion>(map);
  }

  static SearchSuggestion fromJson(String json) {
    return ensureInitialized().decodeJson<SearchSuggestion>(json);
  }
}

mixin SearchSuggestionMappable {
  String toJson() {
    return SearchSuggestionMapper.ensureInitialized()
        .encodeJson<SearchSuggestion>(this as SearchSuggestion);
  }

  Map<String, dynamic> toMap() {
    return SearchSuggestionMapper.ensureInitialized()
        .encodeMap<SearchSuggestion>(this as SearchSuggestion);
  }

  SearchSuggestionCopyWith<SearchSuggestion, SearchSuggestion, SearchSuggestion>
      get copyWith => _SearchSuggestionCopyWithImpl(
          this as SearchSuggestion, $identity, $identity);
  @override
  String toString() {
    return SearchSuggestionMapper.ensureInitialized()
        .stringifyValue(this as SearchSuggestion);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SearchSuggestionMapper.ensureInitialized()
                .isValueEqual(this as SearchSuggestion, other));
  }

  @override
  int get hashCode {
    return SearchSuggestionMapper.ensureInitialized()
        .hashValue(this as SearchSuggestion);
  }
}

extension SearchSuggestionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SearchSuggestion, $Out> {
  SearchSuggestionCopyWith<$R, SearchSuggestion, $Out>
      get $asSearchSuggestion =>
          $base.as((v, t, t2) => _SearchSuggestionCopyWithImpl(v, t, t2));
}

abstract class SearchSuggestionCopyWith<$R, $In extends SearchSuggestion, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, SearchText, SearchTextCopyWith<$R, SearchText, SearchText>>?
      get searchTextList;
  $R call(
      {String? placeId, String? description, List<SearchText>? searchTextList});
  SearchSuggestionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SearchSuggestionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SearchSuggestion, $Out>
    implements SearchSuggestionCopyWith<$R, SearchSuggestion, $Out> {
  _SearchSuggestionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SearchSuggestion> $mapper =
      SearchSuggestionMapper.ensureInitialized();
  @override
  ListCopyWith<$R, SearchText, SearchTextCopyWith<$R, SearchText, SearchText>>?
      get searchTextList => $value.searchTextList != null
          ? ListCopyWith($value.searchTextList!, (v, t) => v.copyWith.$chain(t),
              (v) => call(searchTextList: v))
          : null;
  @override
  $R call(
          {String? placeId,
          String? description,
          Object? searchTextList = $none}) =>
      $apply(FieldCopyWithData({
        if (placeId != null) #placeId: placeId,
        if (description != null) #description: description,
        if (searchTextList != $none) #searchTextList: searchTextList
      }));
  @override
  SearchSuggestion $make(CopyWithData data) => SearchSuggestion(
      placeId: data.get(#placeId, or: $value.placeId),
      description: data.get(#description, or: $value.description),
      searchTextList: data.get(#searchTextList, or: $value.searchTextList));

  @override
  SearchSuggestionCopyWith<$R2, SearchSuggestion, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SearchSuggestionCopyWithImpl($value, $cast, t);
}
