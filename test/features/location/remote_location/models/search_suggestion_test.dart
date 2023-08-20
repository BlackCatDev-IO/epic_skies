import 'package:epic_skies/features/location/search/models/search_suggestion/search_suggestion.dart';
import 'package:epic_skies/features/location/search/models/search_text/search_text.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks/mock_api_responses/mock_google_places_response.dart';

Future<void> main() async {
  group('search suggestion test: ', () {
    test('fromMap initializes as expected with city search', () {
      final ouaga = MockPlacesResponse.cityData[1];

      final suggestionFromMap =
          SearchSuggestion.fromMap(map: ouaga, query: 'oua');

      const searchTextList = [
        SearchText(text: 'Oua', isBold: true),
        SearchText(text: 'gadougou, Burkina Faso', isBold: false),
      ];

      const suggestion = SearchSuggestion(
        placeId: 'ChIJzUSqzuyVLg4Rizt0nHlnn3k',
        description: 'Ouagadougou, Burkina Faso',
        searchTextList: searchTextList,
      );

      expect(suggestion, suggestionFromMap);
    });

    test('fromMap initializes as expected with region search', () {
      final bronx = MockPlacesResponse.regionSearchBronx[0];

      final suggestionFromMap =
          SearchSuggestion.fromMap(map: bronx, query: '104');

      const searchTextList = [
        SearchText(text: 'Bronx,  NY ', isBold: false),
        SearchText(text: '104', isBold: true),
        SearchText(text: '51,  USA ', isBold: false),
      ];

      const suggestion = SearchSuggestion(
        placeId: 'ChIJ4are_s31wokRPWIfx0e3ELw',
        description: 'Bronx, NY 10451, USA',
        searchTextList: searchTextList,
      );

      expect(suggestion, suggestionFromMap);
    });

    test('''
fromMap initializes as expected with region search of postal code with letters and numbers
''', () {
      final vancouver = MockPlacesResponse.regionSearchVancouver[1];

      final suggestionFromMap =
          SearchSuggestion.fromMap(map: vancouver, query: 'v6h');

      const searchTextList = [
        SearchText(text: 'Vancouver,  BC ', isBold: false),
        SearchText(text: 'V6H ', isBold: true),
        SearchText(text: '2X1, Canada ', isBold: false),
      ];

      const suggestion = SearchSuggestion(
        placeId: 'ChIJicOVxpNzhlQR5QrKiJawSYo',
        description: 'Vancouver, BC V6H 2X1, Canada',
        searchTextList: searchTextList,
      );

      expect(suggestion, suggestionFromMap);
    });

    test('''
fromMap initializes maintains space in postal code display on postal codes with numbers and letters
        ''', () {
      final vancouver = MockPlacesResponse.regionSearchVancouver[1];

      final queryLengthMatchesPortionBeforeSpace =
          SearchSuggestion.fromMap(map: vancouver, query: 'v6h');

      final queryLengthShorterThanPortionBeforeSpace =
          SearchSuggestion.fromMap(map: vancouver, query: 'v6');

      final queryLengthLongerThanPortionBeforeSpace =
          SearchSuggestion.fromMap(map: vancouver, query: 'v6h2');

      const listWithEqualLengthQuery = [
        SearchText(text: 'Vancouver,  BC ', isBold: false),
        SearchText(text: 'V6H ', isBold: true),
        SearchText(text: '2X1, Canada ', isBold: false),
      ];

      const listWithShorterQuery = [
        SearchText(text: 'Vancouver,  BC ', isBold: false),
        SearchText(text: 'V6', isBold: true),
        SearchText(text: 'H 2X1, Canada ', isBold: false),
      ];

      const listWithLongerQuery = [
        SearchText(text: 'Vancouver,  BC ', isBold: false),
        SearchText(text: 'V6H 2', isBold: true),
        SearchText(text: 'X1, Canada ', isBold: false),
      ];

      const suggestionEqualLength = SearchSuggestion(
        placeId: 'ChIJicOVxpNzhlQR5QrKiJawSYo',
        description: 'Vancouver, BC V6H 2X1, Canada',
        searchTextList: listWithEqualLengthQuery,
      );

      const suggestionShorterQuery = SearchSuggestion(
        placeId: 'ChIJicOVxpNzhlQR5QrKiJawSYo',
        description: 'Vancouver, BC V6H 2X1, Canada',
        searchTextList: listWithShorterQuery,
      );
      const suggestionLongerQuery = SearchSuggestion(
        placeId: 'ChIJicOVxpNzhlQR5QrKiJawSYo',
        description: 'Vancouver, BC V6H 2X1, Canada',
        searchTextList: listWithLongerQuery,
      );

      expect(
        suggestionEqualLength,
        queryLengthMatchesPortionBeforeSpace,
      );

      expect(
        suggestionShorterQuery,
        queryLengthShorterThanPortionBeforeSpace,
      );

      expect(
        suggestionLongerQuery,
        queryLengthLongerThanPortionBeforeSpace,
      );
    });

    test(
      '''
overly long descriptions from response get truncated to remove unneccessary info
''',
      () {
        // full description from response is:
        // Chester Road, Old Trafford, Stretford, Manchester M16 9EA, UK
        const longResponse = MockPlacesResponse.longUKResponse;

        final suggestionFromMap =
            SearchSuggestion.fromMap(map: longResponse, query: 'm169ea');

        const searchTextList = [
          SearchText(text: 'Stretford,  Manchester ', isBold: false),
          SearchText(text: 'M16 9EA', isBold: true),
          SearchText(text: ', UK ', isBold: false),
        ];

        const suggestion = SearchSuggestion(
          placeId: 'ChIJY5J3MgOue0gRsrOVSwNRFYc',
          description: 'Stretford, Manchester M16 9EA, UK',
          searchTextList: searchTextList,
        );
        expect(suggestion, suggestionFromMap);
      },
    );

    test(
      '''
when user enters a space into the query it still returns expected results
      ''',
      () {
        final vancouver = MockPlacesResponse.regionSearchVancouver[1];

        final suggestionFromMap =
            SearchSuggestion.fromMap(map: vancouver, query: 'v6h 2');

        const searchTextList = [
          SearchText(text: 'Vancouver,  BC ', isBold: false),
          SearchText(text: 'V6H 2', isBold: true),
          SearchText(text: 'X1, Canada ', isBold: false),
        ];

        const suggestion = SearchSuggestion(
          placeId: 'ChIJicOVxpNzhlQR5QrKiJawSYo',
          description: 'Vancouver, BC V6H 2X1, Canada',
          searchTextList: searchTextList,
        );

        expect(suggestion, suggestionFromMap);
      },
    );

    test(
      '''
duplicate characters in query don't break expected response of bold text
''',
      () {
        const kitzingen = MockPlacesResponse.germanyResponse;
        const turkey = MockPlacesResponse.turkeyResponse;
        const matchingQuery = 'kitz';
        const mismatchedQuery = 'kitzk';

        final suggestionFromMatchingQuery =
            SearchSuggestion.fromMap(map: kitzingen, query: matchingQuery);

        final suggestionFromMismatchedQuery =
            SearchSuggestion.fromMap(map: turkey, query: mismatchedQuery);

        const matchedSearchTextList = [
          SearchText(text: 'Kitz', isBold: true),
          SearchText(text: 'ingen, Germany', isBold: false),
        ];

        const misMatchedSearchTextList = [
          SearchText(text: '', isBold: true),
          SearchText(text: 'Kızıksa, Manyas/Balıkesir, Turkey', isBold: false),
        ];

        const matchedSuggestion = SearchSuggestion(
          placeId: 'ChIJ0UKD569iokcREBJi8Ci3HQQ',
          description: 'Kitzingen, Germany',
          searchTextList: matchedSearchTextList,
        );

        const misMatchedSuggestion = SearchSuggestion(
          placeId: 'ChIJsyFEnsJ8thQR0krXIRfRgMo',
          description: 'Kızıksa, Manyas/Balıkesir, Turkey',
          searchTextList: misMatchedSearchTextList,
        );

        expect(matchedSuggestion, suggestionFromMatchingQuery);

        expect(
          misMatchedSuggestion,
          suggestionFromMismatchedQuery,
        );
      },
    );
  });
}
