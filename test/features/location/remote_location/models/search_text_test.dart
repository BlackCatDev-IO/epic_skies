import 'dart:convert';

import 'package:epic_skies/features/location/search/models/search_text/search_text.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  late SearchText searchText;

  setUpAll(() async {
    searchText = const SearchText(text: 'test', isBold: false);
  });

  group('SearchText test: ', () {
    test('SearchText.fromRawJson initializes as expected', () {
      final jsonString = {'text': 'test', 'isBold': false};
      final searchTextFromJson = SearchText.fromMap(jsonString);
      expect(searchText, searchTextFromJson);
    });

    test('SearchText.toJson initializes as expected', () {
      final searchTextJson = jsonEncode(searchText.toJson());
      final jsonString = jsonEncode({'text': 'test', 'isBold': false});

      expect(searchTextJson, jsonString);
    });
  });
}
