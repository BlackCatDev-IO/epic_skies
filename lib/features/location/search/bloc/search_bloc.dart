import 'dart:async';

import 'package:epic_skies/features/location/search/models/search_suggestion/search_suggestion.dart';
import 'package:epic_skies/repositories/location_repository.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required LocationRepository locationRepository})
      : _locationRepository = locationRepository,
        super(const SearchState()) {
    on<SearchEntryUpdated>(_onSearchEntryUpdated);
  }

  final LocationRepository _locationRepository;

  Future<void> _onSearchEntryUpdated(
    SearchEntryUpdated event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(searchSuggestions: [], query: event.text));

    _logSearchBloc(event.text);

    final updatedList = [...state.searchSuggestions];

    try {
      final result =
          await _locationRepository.fetchSearchSuggestions(query: event.text);

      _logSearchBloc('Search Results: $result');

      if (result != null && result.isNotEmpty) {
        if ((result['status'] as String).toLowerCase() == 'zero_results') {
          emit(state.copyWith(noResults: true, status: 'No results'));
        } else {
          emit(state.copyWith(noResults: false, status: 'Loading...'));
        }

        final predictionList = result['predictions'] as List;

        for (final prediction in predictionList) {
          final suggestion = SearchSuggestion.fromMap(
            map: prediction as Map<String, dynamic>,
            query: event.text,
          );

          if (_containsAllCharactersFromQuery(
            suggestion: suggestion.description.toLowerCase(),
            query: event.text.trim().toLowerCase(),
          )) {
            updatedList.add(suggestion);
            emit(state.copyWith(searchSuggestions: updatedList));
          }
        }
      }
    } catch (error, stack) {
      _logSearchBloc('_onSearchEntryUpdated ERROR: $error, stack: $stack');
      rethrow;
    }
  }

  bool _containsAllCharactersFromQuery({
    required String query,
    required String suggestion,
  }) {
    for (var i = 0; i < query.trim().length; i++) {
      if (!suggestion.toLowerCase().contains(query[i])) {
        return false;
      }
    }
    return true;
  }

  void _logSearchBloc(String message) {
    AppDebug.log(message, name: 'SearchBloc');
  }
}
