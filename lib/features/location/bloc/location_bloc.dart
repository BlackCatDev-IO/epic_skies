import 'dart:async';
import 'dart:ui';

import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/core/error_handling/error_messages.dart';
import 'package:epic_skies/core/error_handling/error_model.dart';
import 'package:epic_skies/features/location/bloc/location_state.dart';
import 'package:epic_skies/features/location/locale/locale_repository.dart';
import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:epic_skies/features/location/search/models/search_suggestion/search_suggestion.dart';
import 'package:epic_skies/features/location/user_location/models/location_model.dart';
import 'package:epic_skies/repositories/location_repository.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

export 'location_state.dart';

part 'location_event.dart';

class LocationBloc extends HydratedBloc<LocationEvent, LocationState> {
  LocationBloc({
    required LocationRepository locationRepository,
    required LocaleRepository localeRepository,
  })  : _locationRepository = locationRepository,
        _localeRepository = localeRepository,
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
  final LocaleRepository _localeRepository;

  static const _locationRefreshIntervalInMin = 10;

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

    if (state.lastUpdated != null) {
      final difference = DateTime.now().toUtc().difference(state.lastUpdated!);

      if (difference.inMinutes < _locationRefreshIntervalInMin) {
        return emit(
          state.copyWith(
            status: LocationStatus.success,
          ),
        );
      }
    }

    late Coordinates? coordinates;
    late Locale? locale;

    try {
      final locationRequest = _locationRepository.getCurrentPosition();
      final localeRequest = _localeRepository.getLocale();

      final results = await Future.wait([
        locationRequest,
        localeRequest,
      ]);

      coordinates = results[0] as Coordinates?;
      locale = results[1] as Locale?;

      final newPlace = await _locationRepository.getPlacemarksFromCoordinates(
        coordinates: coordinates!,
      );

      _logLocationBloc(
        'lat: ${coordinates.lat} long: ${coordinates.long}',
      );

      final localData = LocationModel.fromPlacemark(place: newPlace[0]);

      emit(
        state.copyWith(
          status: LocationStatus.success,
          localData: localData,
          localCoordinates: coordinates,
          languageCode: locale?.languageCode,
          countryCode: locale?.countryCode,
          lastUpdated: DateTime.now().toUtc(),
        ),
      );
    } on PlatformException catch (e) {
      if (e.code == 'IO_ERROR') {
        _logLocationBloc('$e', isError: true);
      }

      /// This platform exception happens pretty consistently on the first
      /// install of certain devices and I have no control over nor does the
      /// author of Geocoding as its a device system issue
      /// So Bing Maps reverse geocoding api gets called as a backup when this
      /// happens
      final localData =
          await _locationRepository.getLocationDetailsFromBackupAPI(
        lat: coordinates!.lat,
        long: coordinates.long,
      );

      _logLocationBloc('code: ${e.code} message: ${e.message}');

      emit(
        state.copyWith(
          status: LocationStatus.success,
          localData: localData ?? const LocationModel(),
        ),
      );
    } on LocationNoPermissionException catch (e) {
      _logLocationBloc('$e', isError: true);

      emit(
        state.copyWith(
          status: LocationStatus.noLocationPermission,
        ),
      );
    } on LocationServiceDisabledException catch (e) {
      _logLocationBloc('$e', isError: true);

      emit(
        state.copyWith(
          status: LocationStatus.locationDisabled,
        ),
      );
    } on NoConnectionException catch (e) {
      _logLocationBloc('$e', isError: true);

      emit(
        state.copyWith(
          status: LocationStatus.error,
          errorModel: Errors.noNetworkErrorModel,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: LocationStatus.error,
          errorModel: Errors.locationErrorModel,
        ),
      );
      _logLocationBloc(
        '_onLocationRequestLocal ERROR: $error message: ${StackTrace.current}',
      );
      rethrow; // send to Sentry
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

      final remoteData = await _locationRepository.getRemoteLocationModel(
        suggestion: event.searchSuggestion,
      );

      final updatedSearchHistory = [...state.searchHistory];

      final containsSearch = updatedSearchHistory
          .any((element) => element.placeId == event.searchSuggestion.placeId);

      if (!containsSearch) {
        updatedSearchHistory.insert(0, event.searchSuggestion);
      }

      /// Leave for generating app store screenshots
      // final bogota = remoteData.copyWith(
      //   city: 'Bogota',
      //   country: 'Colombia',
      //   state: '',
      // );

      // final newYorkSunny = remoteData.copyWith(
      //   city: 'New York',
      //   country: 'New York',
      // );

      emit(
        state.copyWith(
          status: LocationStatus.success,
          remoteLocationData: remoteData,
          // remoteLocationData: bogota,
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

  void _logLocationBloc(
    String message, {
    bool isError = false,
  }) {
    AppDebug.log(
      message,
      name: 'LocationBloc',
      isError: isError,
    );
  }

  @override
  LocationState? fromJson(Map<String, dynamic> json) {
    return LocationState.fromMap(json).copyWith(
      status: LocationStatus.initial,
    );
  }

  @override
  Map<String, dynamic>? toJson(LocationState state) {
    return state.copyWith(errorModel: null).toMap();
  }
}
