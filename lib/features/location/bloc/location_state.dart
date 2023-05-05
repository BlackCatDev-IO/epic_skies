// ignore_for_file: invalid_annotation_target

import 'package:epic_skies/core/error_handling/error_model.dart';
import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:epic_skies/features/location/remote_location/models/remote_location/remote_location_model.dart';
import 'package:epic_skies/features/location/search/models/search_suggestion/search_suggestion.dart';
import 'package:epic_skies/features/location/user_location/models/location_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_state.freezed.dart';
part 'location_state.g.dart';

enum LocationStatus {
  initial,
  loading,
  success,
  noLocationPermission,
  locationDisabled,
  error,
}

extension LocationStatusX on LocationStatus {
  bool get isInitial => this == LocationStatus.initial;
  bool get isLoading => this == LocationStatus.loading;
  bool get isSuccess => this == LocationStatus.success;
  bool get isNoLocationPermission =>
      this == LocationStatus.noLocationPermission;
  bool get isLocationDisabled => this == LocationStatus.locationDisabled;
  bool get isError => this == LocationStatus.error;
}

@freezed
class LocationState with _$LocationState {
  const factory LocationState({
    @JsonKey(ignore: true)
    @Default(LocationStatus.initial)
        LocationStatus status,
    @Default([]) List<SearchSuggestion> searchHistory,
    @Default([]) List<SearchSuggestion> currentSearchList,
    @Default(LocationModel()) LocationModel data,
    @Default(RemoteLocationModel()) RemoteLocationModel remoteLocationData,
    @Default(Coordinates(lat: 0, long: 0)) Coordinates? coordinates,
    @Default(true) bool searchIsLocal,
    SearchSuggestion? searchSuggestion,
    @JsonKey(ignore: true) ErrorModel? errorModel,
  }) = _LocationState;

  factory LocationState.error({
    required Exception exception,
  }) =>
      LocationState(
        status: LocationStatus.error,
        errorModel: ErrorModel.fromException(exception),
      );

  const LocationState._();

  factory LocationState.fromJson(Map<String, dynamic> json) =>
      _$LocationStateFromJson(json);

  @override
  String toString() {
    return '''
    status: $status
    coordinates: $coordinates
    searchIsLocal: $searchIsLocal
    errorModel: $errorModel
    ''';
  }
}
