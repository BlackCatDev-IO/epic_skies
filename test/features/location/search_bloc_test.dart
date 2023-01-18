import 'package:bloc_test/bloc_test.dart';
import 'package:epic_skies/features/location/search/bloc/search_bloc.dart';
import 'package:epic_skies/features/location/search/models/search_suggestion/search_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_api_responses/mock_location_data.dart';
import '../../mocks/mock_classes.dart';

void main() async {
  late MockLocationRepo locationRepo;
  late List<SearchSuggestion> suggestionList;
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();

    locationRepo = MockLocationRepo();

    suggestionList =
        (MockLocationData.predictionsZInput['predictions']! as List)
            .map(
              (e) => SearchSuggestion.fromMap(
                map: e as Map<String, dynamic>,
                query: 'z',
              ),
            )
            .toList();
  });

  group('SearchBloc:', () {
    blocTest(
      'SearchEntryUpdated: Initializes searchSuggestions as expected from user input',
      setUp: () {
        when(() => locationRepo.fetchSearchSuggestions(query: 'z')).thenAnswer(
          (_) async => MockLocationData.predictionsZInput,
        );
      },
      build: () => SearchBloc(
        locationRepository: locationRepo,
      ),
      act: (SearchBloc bloc) => bloc.add(SearchEntryUpdated(text: 'z')),
      expect: () => [
        const SearchState(query: 'z'),
        SearchState(query: 'z', searchSuggestions: suggestionList),
      ],
    );

    blocTest(
      'SearchEntryUpdated: Clears suggestion list when user clears input',
      setUp: () {
        when(() => locationRepo.fetchSearchSuggestions(query: '')).thenAnswer(
          (_) async => {},
        );
      },
      build: () => SearchBloc(
        locationRepository: locationRepo,
      ),
      seed: () => SearchState(query: 'z', searchSuggestions: suggestionList),
      act: (SearchBloc bloc) => bloc.add(SearchEntryUpdated(text: '')),
      expect: () => [
        const SearchState(),
      ],
    );
  });
}
