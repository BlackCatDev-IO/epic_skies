part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState({
    this.searchSuggestions = const [],
    this.status = 'Loading...',
    this.query = '',
    this.noResults = false,
    this.errorMessage = '',
  });

  final List<SearchSuggestion> searchSuggestions;
  final String status;
  final String query;
  final bool noResults;
  final String errorMessage;

  SearchState copyWith({
    List<SearchSuggestion>? searchSuggestions,
    String? status,
    String? query,
    bool? noResults,
    String? errorMessage,
  }) {
    return SearchState(
      searchSuggestions: searchSuggestions ?? this.searchSuggestions,
      status: status ?? this.status,
      query: query ?? this.query,
      noResults: noResults ?? this.noResults,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props {
    return [
      searchSuggestions,
      status,
      query,
      noResults,
      errorMessage,
    ];
  }
}
