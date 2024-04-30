// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'search_text.dart';

class SearchTextMapper extends ClassMapperBase<SearchText> {
  SearchTextMapper._();

  static SearchTextMapper? _instance;
  static SearchTextMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SearchTextMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SearchText';

  static String _$text(SearchText v) => v.text;
  static const Field<SearchText, String> _f$text = Field('text', _$text);
  static bool _$isBold(SearchText v) => v.isBold;
  static const Field<SearchText, bool> _f$isBold = Field('isBold', _$isBold);

  @override
  final MappableFields<SearchText> fields = const {
    #text: _f$text,
    #isBold: _f$isBold,
  };

  static SearchText _instantiate(DecodingData data) {
    return SearchText(text: data.dec(_f$text), isBold: data.dec(_f$isBold));
  }

  @override
  final Function instantiate = _instantiate;

  static SearchText fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SearchText>(map);
  }

  static SearchText fromJson(String json) {
    return ensureInitialized().decodeJson<SearchText>(json);
  }
}

mixin SearchTextMappable {
  String toJson() {
    return SearchTextMapper.ensureInitialized()
        .encodeJson<SearchText>(this as SearchText);
  }

  Map<String, dynamic> toMap() {
    return SearchTextMapper.ensureInitialized()
        .encodeMap<SearchText>(this as SearchText);
  }

  SearchTextCopyWith<SearchText, SearchText, SearchText> get copyWith =>
      _SearchTextCopyWithImpl(this as SearchText, $identity, $identity);
  @override
  String toString() {
    return SearchTextMapper.ensureInitialized()
        .stringifyValue(this as SearchText);
  }

  @override
  bool operator ==(Object other) {
    return SearchTextMapper.ensureInitialized()
        .equalsValue(this as SearchText, other);
  }

  @override
  int get hashCode {
    return SearchTextMapper.ensureInitialized().hashValue(this as SearchText);
  }
}

extension SearchTextValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SearchText, $Out> {
  SearchTextCopyWith<$R, SearchText, $Out> get $asSearchText =>
      $base.as((v, t, t2) => _SearchTextCopyWithImpl(v, t, t2));
}

abstract class SearchTextCopyWith<$R, $In extends SearchText, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? text, bool? isBold});
  SearchTextCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SearchTextCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SearchText, $Out>
    implements SearchTextCopyWith<$R, SearchText, $Out> {
  _SearchTextCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SearchText> $mapper =
      SearchTextMapper.ensureInitialized();
  @override
  $R call({String? text, bool? isBold}) => $apply(FieldCopyWithData(
      {if (text != null) #text: text, if (isBold != null) #isBold: isBold}));
  @override
  SearchText $make(CopyWithData data) => SearchText(
      text: data.get(#text, or: $value.text),
      isBold: data.get(#isBold, or: $value.isBold));

  @override
  SearchTextCopyWith<$R2, SearchText, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SearchTextCopyWithImpl($value, $cast, t);
}
