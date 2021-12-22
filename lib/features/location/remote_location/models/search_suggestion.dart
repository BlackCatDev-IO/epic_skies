import 'package:black_cat_lib/extensions/string_extensions.dart';

import 'search_text.dart';

class SearchSuggestion {
  final String placeId;
  final String description;
  final List<SearchText>? searchTextList;

  SearchSuggestion({
    required this.placeId,
    required this.description,
    this.searchTextList,
  });

  factory SearchSuggestion.fromMap({
    required Map<String, dynamic> map,
    required String query,
  }) {
    final description = _checkForOddFormatting(map['description'] as String);
    final placeId = map['place_id'] as String?;

    return SearchSuggestion(
      description: description,
      placeId: placeId!,
      searchTextList: _getSearchText(query: query, suggestion: description),
    );
  }

  /// Sometimes the search suggestions can have imperfect formatting
  /// Anything I notice I add to this function
  static String _checkForOddFormatting(String description) {
    switch (description.toLowerCase()) {
      case 'bogotá, bogota, colombia':
        return 'Bogotá, Colombia';
      case 'sydney nsw, australia':
        return 'Sydney, NSW, Australia';
      default:
        return description;
    }
  }

  static List<SearchText> _getSearchText({
    required String suggestion,
    required String query,
  }) {
    if (query.hasNumber) {
      return _getRegionSearchText(suggestion: suggestion, query: query);
    } else {
      return _getCitySearchText(suggestion: suggestion, query: query);
    }
  }

  static List<SearchText> _getCitySearchText({
    required String suggestion,
    required String query,
  }) {
    final List<SearchText> searchTextList = [];

    String boldText = '';
    String regularText = '';

    for (int i = 0; i < query.length; i++) {
      final char = suggestion[i];
      // final charIsPartOfQuery = query. .contains(char.toLowerCase());
      final charIsPartOfQuery = query[i] == char.toLowerCase();

      if (charIsPartOfQuery) {
        boldText += char;
        regularText = suggestion.replaceRange(0, query.length, '');
      } else {
        regularText = suggestion;
      }
    }

    searchTextList.add(SearchText(text: boldText, isBold: true));
    searchTextList.add(SearchText(text: regularText, isBold: false));

    return searchTextList;
  }

  static List<SearchText> _getRegionSearchText({
    required String suggestion,
    required String query,
  }) {
    final List<SearchText> searchTextList = [];
    final postalCodeStringList = <String>[];
    final indexList = <int>[];

    String boldText = '';
    String regText = '';
    final stringList = suggestion.split(' ');
    String postalCode = '';

    bool firstIndexIsBold = false;

    for (int i = 0; i < stringList.length; i++) {
      final place = stringList[i];
      if (place.hasNumber) {
        postalCodeStringList.add(place);
        indexList.add(i);
      } else {
        searchTextList.add(SearchText(text: '$place ', isBold: false));
      }
    }

    postalCode = '${postalCodeStringList.join(' ')} ';

    for (int i = 0; i < postalCode.length; i++) {
      String char = '';
      if (i < query.length) {
        char = query[i].toLowerCase();

        if (char == postalCode[i].toLowerCase()) {
          boldText += char.toUpperCase();
          if (i == 0) {
            firstIndexIsBold = true;
          }
        }
      } else {
        char = postalCode[i];
        regText += char.toUpperCase();
      }
    }

    final boldSearchText = SearchText(text: boldText, isBold: true);
    final regSearchText = SearchText(text: regText, isBold: false);
    final postalCodeIndex = indexList[0];

    if (firstIndexIsBold) {
      searchTextList.insert(postalCodeIndex, boldSearchText);
      searchTextList.insert(postalCodeIndex + 1, regSearchText);
    } else {
      searchTextList.insert(postalCodeIndex, regSearchText);
      searchTextList.insert(postalCodeIndex + 1, boldSearchText);
    }

    return searchTextList;
  }

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}
