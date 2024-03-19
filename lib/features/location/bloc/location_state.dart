import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/core/error_handling/error_model.dart';
import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:epic_skies/features/location/remote_location/models/remote_location/remote_location_model.dart';
import 'package:epic_skies/features/location/search/models/search_suggestion/search_suggestion.dart';
import 'package:epic_skies/features/location/user_location/models/location_model.dart';

part 'location_state.mapper.dart';

@MappableEnum()
enum LocationStatus {
  initial,
  loading,
  success,
  noLocationPermission,
  locationDisabled,
  error;

  bool get isInitial => this == LocationStatus.initial;
  bool get isLoading => this == LocationStatus.loading;
  bool get isSuccess => this == LocationStatus.success;
  bool get isNoLocationPermission =>
      this == LocationStatus.noLocationPermission;
  bool get isLocationDisabled => this == LocationStatus.locationDisabled;
  bool get isError => this == LocationStatus.error;
}

@MappableClass()
class LocationState with LocationStateMappable {
  const LocationState({
    this.status = LocationStatus.initial,
    this.searchHistory = const [],
    this.currentSearchList = const [],
    this.localData = const LocationModel(),
    this.remoteLocationData = const RemoteLocationModel(),
    this.localCoordinates = const Coordinates(lat: 0, long: 0),
    this.searchIsLocal = true,
    this.languageCode,
    this.countryCode,
    this.searchSuggestion,
    this.errorModel,
    this.lastUpdated,
  });

  final LocationStatus status;
  final List<SearchSuggestion> searchHistory;
  final List<SearchSuggestion> currentSearchList;
  final LocationModel localData;
  final RemoteLocationModel remoteLocationData;
  final Coordinates localCoordinates;
  final bool searchIsLocal;
  final String? languageCode;
  final String? countryCode;
  final SearchSuggestion? searchSuggestion;
  final ErrorModel? errorModel;
  final DateTime? lastUpdated;

  static const fromMap = LocationStateMapper.fromMap;

  @override
  String toString() {
    return '''
    status: $status
    coordinates: $localCoordinates
    searchIsLocal: $searchIsLocal
    errorModel: $errorModel
    ''';
  }
}
