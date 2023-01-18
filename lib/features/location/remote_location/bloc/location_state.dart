import 'package:epic_skies/features/location/remote_location/models/coordinates.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../user_location/models/location_model.dart';
import '../models/remote_location_model.dart';
import '../models/search_suggestion.dart';

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
    required List<SearchSuggestion> searchHistory,
    required List<SearchSuggestion> currentSearchList,
    required LocationModel data,
    required RemoteLocationModel remoteLocationData,
    required LocationStatus status,
    required SearchSuggestion? searchSuggestion,
    required Coordinates? coordinates,
    required bool searchIsLocal,
  }) = _LocationState;

  factory LocationState.fromJson(Map<String, dynamic> json) =>
      _$LocationStateFromJson(json);

  factory LocationState.initialState() => LocationState(
        searchHistory: const [],
        currentSearchList: const [],
        data: LocationModel.emptyModel(),
        remoteLocationData: RemoteLocationModel.emptyModel(),
        status: LocationStatus.initial,
        searchSuggestion: null,
        coordinates: const Coordinates(lat: 0.0, long: 0.0),
        searchIsLocal: true,
      );
}
