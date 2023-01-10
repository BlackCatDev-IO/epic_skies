part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState({
    this.searchSuggestions = const [],
    this.status = 'Loading...',
    this.query = '',
    this.noResults = false,
  });

  final List<SearchSuggestion> searchSuggestions;

  final String status;

  final String query;

  final bool noResults;

  SearchState copyWith({
    List<SearchSuggestion>? searchSuggestions,
    String? status,
    String? query,
    bool? noResults,
  }) {
    return SearchState(
      searchSuggestions: searchSuggestions ?? this.searchSuggestions,
      status: status ?? this.status,
      query: query ?? this.query,
      noResults: noResults ?? this.noResults,
    );
  }

  @override
  List<Object> get props => [searchSuggestions, status, noResults, query];
}
