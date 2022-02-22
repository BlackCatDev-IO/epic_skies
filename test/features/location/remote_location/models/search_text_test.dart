import 'dart:convert';

import 'package:epic_skies/features/location/remote_location/models/search_text.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  late SearchText searchText;

  setUpAll(() async {
    searchText = const SearchText(text: 'test', isBold: false);
  });

  group('SearchText test: ', () {
    test('SearchText.fromRawJson initializes as expected', () {
      final jsonString = jsonEncode({'text': 'test', 'isBold': false});
      final searchTextFromJson = SearchText.fromRawJson(jsonString);
      expect(searchText, searchTextFromJson);
    });

    test('SearchText.toRawJson initializes as expected', () {
      final searchTextJson = searchText.toRawJson();
      final jsonString = jsonEncode({'text': 'test', 'isBold': false});

      expect(searchTextJson, jsonString);
    });
  });
}
