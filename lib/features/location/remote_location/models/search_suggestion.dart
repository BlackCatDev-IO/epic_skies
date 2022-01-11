import 'package:epic_skies/utils/formatters/address_formatter.dart';
import 'package:equatable/equatable.dart';

import 'search_text.dart';

class SearchSuggestion extends Equatable {
  final String placeId;
  final String description;
  final List<SearchText>? searchTextList;

  const SearchSuggestion({
    required this.placeId,
    required this.description,
    this.searchTextList,
  });

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

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId) $searchTextList';
  }

  @override
  List<Object?> get props => [placeId, description, searchTextList];
}
