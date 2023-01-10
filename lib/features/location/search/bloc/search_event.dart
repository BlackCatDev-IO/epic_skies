part of 'search_bloc.dart';

abstract class SearchEvent {
  const SearchEvent();
}

class SearchEntryUpdated extends SearchEvent {
  SearchEntryUpdated({required this.text});

  final String text;
}
