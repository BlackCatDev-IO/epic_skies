// ignore_for_file: sort_constructors_first

import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/features/location/search/models/search_text/search_text.dart';
import 'package:epic_skies/utils/formatters/address_formatter.dart';

part 'search_suggestion.mapper.dart';

@MappableClass()
class SearchSuggestion with SearchSuggestionMappable {
  const SearchSuggestion({
    required this.placeId,
    required this.description,
    this.searchTextList,
  });

  final String placeId;
  final String description;
  final List<SearchText>? searchTextList;

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
