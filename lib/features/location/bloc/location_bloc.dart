import 'dart:async';

import 'package:epic_skies/repositories/location_repository.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:location/location.dart';

import '../../../core/error_handling/custom_exceptions.dart';
import '../remote_location/models/coordinates/coordinates.dart';
import '../search/models/search_suggestion/search_suggestion.dart';
import '../user_location/models/location_model.dart';
import 'location_state.dart';

export 'location_state.dart';

part 'location_event.dart';

class LocationBloc extends HydratedBloc<RemoteLocationEvent, LocationState> {
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
    late LocationData? position;
    try {
      await _locationRepository.throwExceptionIfLocationDisabled();

      await _locationRepository.throwExceptionIfNoPermission();

      position = await _locationRepository.getCurrentPosition();

      List<geo.Placemark>? newPlace;

      newPlace = await geo.placemarkFromCoordinates(
        position.latitude!,
        position.longitude!,
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
        'lat: ${position.latitude} long: ${position.longitude}',
      );

      final data = LocationModel.fromPlacemark(place: newPlace[0]);
      emit(
        state.copyWith(
          status: LocationStatus.success,
          data: data,
          coordinates: Coordinates.fromPosition(position),
        ),
      );
    } on PlatformException catch (e) {
      /// This platform exception happens pretty consistently on the first
      /// install of certain devices and I have no control over nor does the
      /// author of Geocoding as its a device system issue
      /// So Bing Maps reverse geocoding api gets called as a backup when this
      /// happens
      final data = await _locationRepository.getLocationDetailsFromBackupAPI(
        lat: position!.latitude!,
        long: position.longitude!,
      );
      _logLocationBloc('code: ${e.code} message: ${e.message}');

      emit(
        state.copyWith(
          status: LocationStatus.success,
          data: data ?? const LocationModel(),
        ),
      );
    } on LocationException catch (error) {
      emit(LocationState.error(exception: error));
    } on NetworkException catch (error) {
      emit(LocationState.error(exception: error));
    } catch (error, stack) {
      _logLocationBloc(
        '_onLocationRequestLocal ERROR: $error message: $stack',
      );

      emit(LocationState.error(exception: error as Exception));
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

      final searchHistory = [...state.searchHistory];

      if (!searchHistory.contains(event.searchSuggestion)) {
        searchHistory.insert(0, event.searchSuggestion);
      }

      emit(
        state.copyWith(
          status: LocationStatus.success,
          remoteLocationData: data,
          searchSuggestion: event.searchSuggestion,
          searchIsLocal: false,
          searchHistory: searchHistory,
        ),
      );
    } on NetworkException catch (error, stack) {
      _logLocationBloc(
        '_onRemoteSelectSearchSuggestion ERROR: $error, stack: $stack',
      );
      emit(LocationState.error(exception: error));
    } catch (e) {
      emit(LocationState.error(exception: e as Exception));
    }
  }

  Future<void> _onLocationReorderSearchList(
    LocationReorderSearchList event,
    Emitter<LocationState> emit,
  ) async {
    final updatedList = [...state.searchHistory];
    int index = event.newIndex;
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
    for (int i = 0; i < updatedSearchHistory.length; i++) {
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
