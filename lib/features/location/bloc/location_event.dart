part of 'location_bloc.dart';

abstract class LocationEvent {
  const LocationEvent();
}

class LocationUpdateLocal extends LocationEvent {
  @override
  String toString() => 'LocationUpdateLocal';
}

class LocationUpdatePreviousRequest extends LocationEvent {
  @override
  String toString() => 'LocationUpdatePreviousRequest';
}

class RemoteSuggestionListUpdated extends LocationEvent {
  RemoteSuggestionListUpdated({required this.text});

  final String text;

  @override
  String toString() => 'RemoteSuggestionListUpdated';
}

class LocationUpdateRemote extends LocationEvent {
  LocationUpdateRemote({required this.searchSuggestion});

  final SearchSuggestion searchSuggestion;

  @override
  String toString() => 'LocationUpdateRemote';
}

class LocationClearSearchHistory extends LocationEvent {
  @override
  String toString() => 'LocationClearSearchHistory';
}

class LocationDeleteSelectedSearch extends LocationEvent {
  LocationDeleteSelectedSearch({required this.searchSuggestion});

  final SearchSuggestion searchSuggestion;

  @override
  String toString() => 'LocationDeleteSelectedSearch';
}

class LocationReorderSearchList extends LocationEvent {
  LocationReorderSearchList({
    required this.oldIndex,
    required this.newIndex,
  });

  final int oldIndex;
  final int newIndex;

  @override
  String toString() => 'LocationReorderSearchList';
}
