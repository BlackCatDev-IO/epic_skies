import 'package:epic_skies/utils/formatters/address_formatter.dart';
import 'package:objectbox/objectbox.dart';

import 'search_text.dart';

@Entity()
class SearchSuggestion {
  SearchSuggestion({
    this.id = 0,
    required this.placeId,
    required this.description,
    this.searchTextList,
  });

  @Id(assignable: true)
  int id;
  final String placeId;
  final String description;
  List<SearchText>? searchTextList;

  List<String>? get dbSearchTextList {
    if (searchTextList != null) {
      return List<String>.from(
        searchTextList!.map(
          (searchText) => searchText.toRawJson(),
        ),
      );
    } else {
      return null;
    }
  }

  set dbSearchTextList(List<String>? stringList) {
    if (stringList != null) {
      searchTextList = List<SearchText>.from(
        stringList.map(
          (e) => SearchText.fromRawJson(e),
        ),
      );
    } else {
      searchTextList = null;
    }
  }

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
}
