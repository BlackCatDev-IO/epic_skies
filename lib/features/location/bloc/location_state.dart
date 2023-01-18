import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../remote_location/models/remote_location/remote_location_model.dart';
import '../search/models/search_suggestion/search_suggestion.dart';
import '../user_location/models/location_model.dart';

part 'location_state.freezed.dart';
part 'location_state.g.dart';

enum LocationStatus {
  initial,
  loading,
  success,
  locationDisabled,
  permissionDenied,
  error
}

extension LocationStatusX on LocationStatus {
  bool get isInitial => this == LocationStatus.initial;
  bool get isLoading => this == LocationStatus.loading;
  bool get isSuccess => this == LocationStatus.success;
  bool get isLocationDisabled => this == LocationStatus.locationDisabled;
  bool get isPermissionDenied => this == LocationStatus.permissionDenied;
  bool get isError => this == LocationStatus.error;
}

@freezed
class LocationState with _$LocationState {
  const factory LocationState({
    @Default([]) List<SearchSuggestion> searchHistory,
    @Default([]) List<SearchSuggestion> currentSearchList,
    @Default(LocationModel()) LocationModel data,
    @Default(RemoteLocationModel()) RemoteLocationModel remoteLocationData,
    @Default(LocationStatus.initial) LocationStatus status,
    @Default(Coordinates(lat: 0.0, long: 0.0)) Coordinates? coordinates,
    @Default(true) bool searchIsLocal,
    SearchSuggestion? searchSuggestion,
  }) = _LocationState;

  factory LocationState.fromJson(Map<String, dynamic> json) =>
      _$LocationStateFromJson(json);
}
