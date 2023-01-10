part of 'location_bloc.dart';

abstract class RemoteLocationEvent {
  const RemoteLocationEvent();
}

class LocationUpdateLocal extends RemoteLocationEvent {}

class LocationUpdatePreviousRequest extends RemoteLocationEvent {}

class RemoteSuggestionListUpdated extends RemoteLocationEvent {
  RemoteSuggestionListUpdated({required this.text});

  final String text;
}

class LocationUpdateRemote extends RemoteLocationEvent {
  LocationUpdateRemote({required this.searchSuggestion});

  final SearchSuggestion searchSuggestion;
}

class LocationClearSearchHistory extends RemoteLocationEvent {}

class LocationDeleteSelectedSearch extends RemoteLocationEvent {
  LocationDeleteSelectedSearch({required this.searchSuggestion});

  final SearchSuggestion searchSuggestion;
}

class LocationReorderSearchList extends RemoteLocationEvent {
  LocationReorderSearchList({
    required this.oldIndex,
    required this.newIndex,
  });

  final int oldIndex;
  final int newIndex;
}
