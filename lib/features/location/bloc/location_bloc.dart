import 'dart:async';

import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/core/error_handling/error_messages.dart';
import 'package:epic_skies/core/error_handling/error_model.dart';
import 'package:epic_skies/features/location/bloc/location_state.dart';
import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:epic_skies/features/location/search/models/search_suggestion/search_suggestion.dart';
import 'package:epic_skies/features/location/user_location/models/location_model.dart';
import 'package:epic_skies/repositories/location_repository.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

export 'location_state.dart';

part 'location_event.dart';

class LocationBloc extends HydratedBloc<LocationEvent, LocationState> {
  LocationBloc({
    required LocationRepository locationRepository,
  })  : _locationRepository = locationRepository,
        super(const LocationState()) {
    /// Local Location Events
    on<LocationUpdateLocal>(_onLocationRequestLocal);

    /// Remote Location Events
    on<LocationUpdateRemote>(_onLocationUpdateRemote);

    /// Refresh last search
    on<LocationUpdatePreviousRequest>(_onLocationUpdatePreviousRequest);

    /// Util Location Events
    on<LocationClearSearchHistory>(_onLocationClearSearchHistory);
    on<LocationDeleteSelectedSearch>(_onLocationDeleteSelectedSearch);
    on<LocationReorderSearchList>(_onLocationReorderSearchList);
  }

  final LocationRepository _locationRepository;

  Future<void> _onLocationUpdatePreviousRequest(
    LocationUpdatePreviousRequest event,
    Emitter<LocationState> emit,
  ) async {
    if (state.searchIsLocal) {
      add(LocationUpdateLocal());
    } else {
      add(LocationUpdateRemote(searchSuggestion: state.searchSuggestion!));
    }
  }

  Future<void> _onLocationRequestLocal(
    LocationUpdateLocal event,
    Emitter<LocationState> emit,
  ) async {
    emit(state.copyWith(status: LocationStatus.loading, searchIsLocal: true));

    late Coordinates? coordinates;

    try {
      coordinates = await _locationRepository.getCurrentPosition();

      List<geo.Placemark>? newPlace;

      newPlace = await geo.placemarkFromCoordinates(
        coordinates.lat,
        coordinates.long,
        // Rancho Santa Margarita coordinates for checking long names
        // Suba, Bogota
        // 33.646510177241666,
        // -117.59434532284129,
        // Other Bogota coordinates
        // 4.692702417983888,
        // -74.06161794597156,
        // 4.634045961676947,
        // -74.17122721333824,
      );

      _logLocationBloc(
        'lat: ${coordinates.lat} long: ${coordinates.long}',
      );

      final data = LocationModel.fromPlacemark(place: newPlace[0]);

      emit(
        state.copyWith(
          status: LocationStatus.success,
          data: data,
          coordinates: coordinates,
        ),
      );
    } on PlatformException catch (e) {
      if (e.code == 'IO_ERROR') {
        emit(
          state.copyWith(
            status: LocationStatus.error,
            errorModel: Errors.noNetworkErrorModel,
          ),
        );
        return;
      }

      /// This platform exception happens pretty consistently on the first
      /// install of certain devices and I have no control over nor does the
      /// author of Geocoding as its a device system issue
      /// So Bing Maps reverse geocoding api gets called as a backup when this
      /// happens
      final data = await _locationRepository.getLocationDetailsFromBackupAPI(
        lat: coordinates!.lat,
        long: coordinates.long,
      );

      _logLocationBloc('code: ${e.code} message: ${e.message}');

      emit(
        state.copyWith(
          status: LocationStatus.success,
          data: data ?? const LocationModel(),
        ),
      );
    } on LocationNoPermissionException {
      emit(
        state.copyWith(
          status: LocationStatus.noLocationPermission,
        ),
      );
    } on LocationServiceDisabledException {
      emit(
        state.copyWith(
          status: LocationStatus.locationDisabled,
        ),
      );
    } on NoConnectionException {
      emit(
        state.copyWith(
          status: LocationStatus.error,
          errorModel: Errors.noNetworkErrorModel,
        ),
      );
    } on Exception catch (error, stackTrace) {
      AppDebug.logSentryError(
        error.toString(),
        stack: stackTrace,
        name: 'LocationBloc',
      );
      emit(
        state.copyWith(
          status: LocationStatus.error,
          errorModel: Errors.locationErrorModel,
        ),
      );
      _logLocationBloc(
        '_onLocationRequestLocal ERROR: $error message: ${StackTrace.current}',
      );
    }
  }

  Future<void> _onLocationUpdateRemote(
    LocationUpdateRemote event,
    Emitter<LocationState> emit,
  ) async {
    try {
      emit(
        state.copyWith(status: LocationStatus.loading, searchIsLocal: false),
      );

      final data = await _locationRepository.getRemoteLocationModel(
        suggestion: event.searchSuggestion,
      );

      final updatedSearchHistory = [...state.searchHistory];

      if (!updatedSearchHistory.contains(event.searchSuggestion)) {
        updatedSearchHistory.insert(0, event.searchSuggestion);
      }

      emit(
        state.copyWith(
          status: LocationStatus.success,
          remoteLocationData: data,
          searchSuggestion: event.searchSuggestion,
          searchHistory: updatedSearchHistory,
        ),
      );
    } on NetworkException catch (error, stack) {
      _logLocationBloc(
        '_onRemoteSelectSearchSuggestion ERROR: $error, stack: $stack',
      );
      emit(
        state.copyWith(
          status: LocationStatus.error,
          errorModel: Errors.noNetworkErrorModel,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: LocationStatus.error,
          errorModel: ErrorModel.fromException(e),
        ),
      );
    }
  }

  Future<void> _onLocationReorderSearchList(
    LocationReorderSearchList event,
    Emitter<LocationState> emit,
  ) async {
    final updatedList = [...state.searchHistory];
    var index = event.newIndex;
    if (event.newIndex > event.oldIndex) {
      index -= 1;
    }
    final newEntry = updatedList.removeAt(event.oldIndex);
    updatedList.insert(index, newEntry);
    emit(state.copyWith(searchHistory: updatedList));
  }

  Future<void> _onLocationDeleteSelectedSearch(
    LocationDeleteSelectedSearch event,
    Emitter<LocationState> emit,
  ) async {
    final updatedSearchHistory = [...state.searchHistory];
    for (var i = 0; i < updatedSearchHistory.length; i++) {
      final suggestion = updatedSearchHistory[i];
      if (suggestion.placeId == event.searchSuggestion.placeId) {
        updatedSearchHistory.removeAt(i);
      }
    }

    emit(state.copyWith(searchHistory: updatedSearchHistory));
  }

  Future<void> _onLocationClearSearchHistory(
    LocationClearSearchHistory event,
    Emitter<LocationState> emit,
  ) async {
    emit(state.copyWith(searchHistory: []));
  }

  void _logLocationBloc(String message) {
    AppDebug.log(message, name: 'LocationBloc');
  }

  @override
  LocationState? fromJson(Map<String, dynamic> json) {
    return LocationState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(LocationState state) {
    return state.toJson();
  }
}
