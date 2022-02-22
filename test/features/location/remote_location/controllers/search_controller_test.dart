import 'package:epic_skies/features/location/remote_location/controllers/search_controller.dart';
import 'package:epic_skies/features/location/remote_location/models/search_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mock_api_responses/mock_google_places_response.dart';
import '../../../../mocks/mock_classes.dart';



Future<void> main() async {
  late SearchController searchController;
  late MockStorageController mockStorage;
  late MockApiCaller mockApiCaller;
  late MockRemoteLocationController mockRemoteLocationController;

  setUpAll(() async {
    mockStorage = MockStorageController();

    WidgetsFlutterBinding.ensureInitialized();

    mockApiCaller = MockApiCaller();
    mockRemoteLocationController =
        MockRemoteLocationController(storage: mockStorage);

    Get.put(mockRemoteLocationController);

    searchController = SearchController(
      apiCaller: mockApiCaller,
      remoteLocationController: mockRemoteLocationController,
    );

    Get.put(searchController);

    when(() => mockRemoteLocationController.clearCurrentSearchList())
        .thenReturn(
      mockRemoteLocationController.currentSearchList.clear(),
    );
  });

  tearDown(() {
    mockRemoteLocationController.currentSearchList.clear();
  });
  group('Search Controller test: ', () {
    /// Using testWidgets to initialize
    testWidgets('query updates as value of textController updates',
        (WidgetTester tester) async {
      await tester.pumpWidget(const GetMaterialApp(home: Scaffold()));

      when(
        () => mockApiCaller.fetchSuggestions(
          query: 'test',
          lang: Localizations.localeOf(Get.context!).languageCode,
        ),
      ).thenAnswer((_) async => MockPlacesResponse.predictions);

      searchController.textController.text = 'test';

      expect(
        searchController.query.value,
        'test',
      );
    });

    testWidgets('status updates depending on response',
        (WidgetTester tester) async {
      await tester.pumpWidget(const GetMaterialApp(home: Scaffold()));
      expect(
        searchController.status.value,
        'Loading...',
      );

      when(
        () => mockApiCaller.fetchSuggestions(
          query: 'asdfasdf',
          lang: Localizations.localeOf(Get.context!).languageCode,
        ),
      ).thenAnswer((_) async => MockPlacesResponse.noResults);

      searchController.textController.text = 'asdfasdf';
      await mockApiCaller.fetchSuggestions(
        query: 'asdfasdf',
        lang: Localizations.localeOf(Get.context!).languageCode,
      );

      expect(
        searchController.status.value,
        'No results',
      );
    });

    testWidgets(
        'properly initializes currentSearchList of RemoteLocationController',
        (WidgetTester tester) async {
      await tester.pumpWidget(const GetMaterialApp(home: Scaffold()));

      final nolaUSASuggestion = SearchSuggestion.fromMap(
        map: (MockPlacesResponse.newOrleans['predictions']! as List)[0]!
            as Map<String, dynamic>,
        query: 'new orleans',
      );

      final nolaUKSuggestion = SearchSuggestion.fromMap(
        map: (MockPlacesResponse.newOrleans['predictions']! as List)[1]!
            as Map<String, dynamic>,
        query: 'new orleans',
      );

      when(
        () => mockRemoteLocationController.addToSearchList(nolaUSASuggestion),
      ).thenReturn(
        mockRemoteLocationController.currentSearchList.add(nolaUSASuggestion),
      );

      when(() => mockRemoteLocationController.addToSearchList(nolaUKSuggestion))
          .thenReturn(
        mockRemoteLocationController.currentSearchList.add(nolaUKSuggestion),
      );

      when(
        () => mockApiCaller.fetchSuggestions(
          query: 'new orleans',
          lang: Localizations.localeOf(Get.context!).languageCode,
        ),
      ).thenAnswer((_) async => MockPlacesResponse.newOrleans);

      searchController.textController.text = 'new orleans';

      expect(
        mockRemoteLocationController.currentSearchList,
        [nolaUSASuggestion, nolaUKSuggestion],
      );
    });
    testWidgets('only adds predictions that contain all letters from query',
        (WidgetTester tester) async {
      await tester.pumpWidget(const GetMaterialApp(home: Scaffold()));

      final serangIndo = SearchSuggestion.fromMap(
        map: (MockPlacesResponse.seraQuery['predictions']! as List)[0]!
            as Map<String, dynamic>,
        query: 'sera',
      );

      final seraingBelgium = SearchSuggestion.fromMap(
        map: (MockPlacesResponse.seraQuery['predictions']! as List)[1]!
            as Map<String, dynamic>,
        query: 'sera',
      );

      final seravazzaItaly = SearchSuggestion.fromMap(
        map: (MockPlacesResponse.seraQuery['predictions']! as List)[3]!
            as Map<String, dynamic>,
        query: 'sera',
      );

      final sernacLakeNy = SearchSuggestion.fromMap(
        map: (MockPlacesResponse.seraQuery['predictions']! as List)[4]!
            as Map<String, dynamic>,
        query: 'sera',
      );

      when(
        () => mockRemoteLocationController.addToSearchList(serangIndo),
      ).thenReturn(
        mockRemoteLocationController.currentSearchList.add(serangIndo),
      );

      when(() => mockRemoteLocationController.addToSearchList(seraingBelgium))
          .thenReturn(
        mockRemoteLocationController.currentSearchList.add(seraingBelgium),
      );
      when(
        () => mockRemoteLocationController.addToSearchList(seravazzaItaly),
      ).thenReturn(
        mockRemoteLocationController.currentSearchList.add(seravazzaItaly),
      );

      when(() => mockRemoteLocationController.addToSearchList(sernacLakeNy))
          .thenReturn(
        mockRemoteLocationController.currentSearchList.add(sernacLakeNy),
      );

      when(
        () => mockApiCaller.fetchSuggestions(
          query: 'sera',
          lang: Localizations.localeOf(Get.context!).languageCode,
        ),
      ).thenAnswer((_) async => MockPlacesResponse.newOrleans);

      searchController.textController.text = 'sera';

      /// the response also includes 'Scranton, PA' which I don't want in the list
      /// if the query includes an 'e' and there is none in 'Scranton, PA'
      /// this test confirms that its not in the displayed list of suggestions
      expect(
        mockRemoteLocationController.currentSearchList,
        [serangIndo, seraingBelgium, seravazzaItaly, sernacLakeNy],
      );
    });
  });
}
