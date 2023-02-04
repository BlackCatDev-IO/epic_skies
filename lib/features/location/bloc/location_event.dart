part of 'location_bloc.dart';

abstract class LocationEvent {
  const LocationEvent();
}

class LocationUpdateLocal extends LocationEvent {}

class LocationUpdatePreviousRequest extends LocationEvent {}

class RemoteSuggestionListUpdated extends LocationEvent {
  RemoteSuggestionListUpdated({required this.text});

  final String text;
}

class LocationUpdateRemote extends LocationEvent {
  LocationUpdateRemote({required this.searchSuggestion});

  final SearchSuggestion searchSuggestion;
}

class LocationClearSearchHistory extends LocationEvent {}

class LocationDeleteSelectedSearch extends LocationEvent {
  LocationDeleteSelectedSearch({required this.searchSuggestion});

  final SearchSuggestion searchSuggestion;
}

class LocationReorderSearchList extends LocationEvent {
  LocationReorderSearchList({
    required this.oldIndex,
    required this.newIndex,
  });

  final int oldIndex;
  final int newIndex;
}
