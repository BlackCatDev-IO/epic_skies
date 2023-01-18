import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../utils/formatters/address_formatter.dart';
import '../search_text/search_text.dart';

part 'search_suggestion.freezed.dart';
part 'search_suggestion.g.dart';

@freezed
class SearchSuggestion with _$SearchSuggestion {
  const factory SearchSuggestion({
    required String placeId,
    required String description,
    List<SearchText>? searchTextList,
  }) = _SearchSuggestion;

  factory SearchSuggestion.fromJson(Map<String, dynamic> json) =>
      _$SearchSuggestionFromJson(json);

  factory SearchSuggestion.fromMap({
    required Map<String, dynamic> map,
    required String query,
  }) {
    final description = AddressFormatter.checkForOddSuggestionFormatting(
      map['description'] as String,
    );

    final placeId = map['place_id'] as String?;

    return SearchSuggestion(
      description: description,
      placeId: placeId!,
      searchTextList:
          AddressFormatter.getSearchText(query: query, suggestion: description),
    );
  }
}
