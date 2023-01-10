part of 'location_bloc.dart';

enum LocationStatus { initial, loading, success, permissionDenied, error }

extension LocationStatusX on LocationStatus {
  bool get isInitial => this == LocationStatus.initial;
  bool get isLoading => this == LocationStatus.loading;
  bool get isSuccess => this == LocationStatus.success;
  bool get isPermissionDenied => this == LocationStatus.permissionDenied;
  bool get isError => this == LocationStatus.error;
}

class LocationState extends Equatable {
  const LocationState({
    this.status = LocationStatus.initial,
    this.searchHistory = const [],
    this.currentSearchList = const [],
    this.data = const LocationModel(
      subLocality: '',
      administrativeArea: '',
      country: '',
      longNameList: null,
    ),
    this.remoteLocationData = const RemoteLocationModel(
      remoteLat: 0.0,
      remoteLong: 0.0,
      city: '',
      state: '',
      country: '',
      longNameList: null,
    ),
    this.searchSuggestion,
    this.locationData,
    this.isLocalSearch = true,
  });

  final List<SearchSuggestion> searchHistory;
  final List<SearchSuggestion> currentSearchList;
  final LocationModel data;
  final RemoteLocationModel remoteLocationData;
  final LocationStatus status;
  final SearchSuggestion? searchSuggestion;
  final LocationData? locationData;
  final bool isLocalSearch;

  LocationState copyWith({
    List<SearchSuggestion>? searchHistory,
    List<SearchSuggestion>? currentSearchList,
    LocationModel? localLocationData,
    RemoteLocationModel? remoteLocationData,
    LocationStatus? status,
    SearchSuggestion? searchSuggestion,
    LocationData? locationData,
    bool? searchIsLocal,
  }) {
    return LocationState(
      searchHistory: searchHistory ?? this.searchHistory,
      currentSearchList: currentSearchList ?? this.currentSearchList,
      data: localLocationData ?? data,
      remoteLocationData: remoteLocationData ?? this.remoteLocationData,
      status: status ?? this.status,
      searchSuggestion: searchSuggestion ?? this.searchSuggestion,
      locationData: locationData ?? this.locationData,
      isLocalSearch: searchIsLocal ?? isLocalSearch,
    );
  }

  @override
  List<Object?> get props => [
        status,
        searchHistory,
        currentSearchList,
        data,
        remoteLocationData,
        searchSuggestion,
        locationData
      ];
}
