import 'dart:async';
import 'dart:io';

import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/core/network/api_service.dart';
import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:epic_skies/features/location/remote_location/models/remote_location/remote_location_model.dart';
import 'package:epic_skies/features/location/search/models/search_suggestion/search_suggestion.dart';
import 'package:epic_skies/features/location/user_location/models/location_model.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:location/location.dart';

class LocationRepository {
  LocationRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  final ApiService _apiService;

  static const _locationTimeout = Duration(seconds: 15);

  Future<Coordinates> getCurrentPosition() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw const LocationServiceDisabledException();
      }

      if (!await _hasLocationPermission()) {
        throw LocationNoPermissionException();
      }

      final position = await Geolocator.getCurrentPosition(
        timeLimit: _locationTimeout,
      );

      return Coordinates.fromPosition(position);
    } on TimeoutException catch (e) {
      _logLocationRepository(
        'Geolocator.getCurrentPosition error: $e',
      );

      final message = 'Geolocation.getCurrentPosition: $e';

      AppDebug.logSentryError(
        LocationTimeOutException(message),
        name: 'LocationRepository',
        stack: StackTrace.current,
      );

      final hasConnection = await InternetConnection().hasInternetAccess;

      if (!hasConnection) {
        throw NoConnectionException();
      }

      try {
        final location = Location();
        final locationData = await location.getLocation().timeout(
          _locationTimeout,
          onTimeout: () {
            final message = 'location.getLocation 2nd Timeout: $e';

            AppDebug.logSentryError(
              LocationTimeOutException(message),
              name: 'LocationRepository',
              stack: StackTrace.current,
            );
            throw TimeoutException('Error retrieving location');
          },
        );
        return Coordinates(
          lat: locationData.latitude!,
          long: locationData.longitude!,
        );
      } catch (e) {
        AppDebug.logSentryError(
          '''
LocationRepository.getCurrentPosition error on catch block after 2nd TimeoutException: $e''',
          name: 'LocationRepository',
          stack: StackTrace.current,
        );
        rethrow;
      }
    }
  }

  Future<LocationModel?> getLocationDetailsFromBackupAPI({
    required double lat,
    required double long,
  }) async {
    try {
      final response = await _apiService.getBackupApiDetails(
        lat: lat,
        long: long,
      );

      _logLocationRepository(response.toString());

      return LocationModel.fromBingMaps(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<dynamic, dynamic>?> fetchSearchSuggestions({
    required String query,
  }) async {
    try {
      return await _apiService.fetchSuggestions(
        query: query,
        lang: Platform.localeName,
      ) as Map<String, dynamic>?;
    } catch (error, stack) {
      _logLocationRepository(
        'fetchSearchSuggestions ERROR: $error, stack: $stack',
      );
      rethrow;
    }
  }

  Future<RemoteLocationModel> getRemoteLocationModel({
    required SearchSuggestion suggestion,
  }) async {
    try {
      final placeDetails =
          await _apiService.getPlaceDetailsFromId(placeId: suggestion.placeId);

      final locationModel = RemoteLocationModel.fromResponse(
        map: placeDetails as Map<String, dynamic>,
        suggestion: suggestion,
      );

      _logLocationRepository(
        'searchCity character length: ${locationModel.city.length}',
      );

      _logLocationRepository(
        '''
City:${locationModel.city} \nState:${locationModel.state}  \nCountry:${locationModel.country}
''',
      );
      return locationModel;
    } on NetworkException {
      rethrow;
    } catch (error, stack) {
      _logLocationRepository(
        'getRemoteLocationModel: ERROR: $error, stack: $stack',
      );
      rethrow;
    }
  }

  Future<bool> _hasLocationPermission() async {
    var permission = await Geolocator.checkPermission();

    try {
      switch (permission) {
        case LocationPermission.denied:
          {
            permission = await Geolocator.requestPermission();

            if (permission == LocationPermission.denied ||
                permission == LocationPermission.deniedForever) {
              _logLocationRepository(
                'checkLocationPermissions returning false in 1st case',
              );
              return false;
            }
          }
          continue recheckPermission;
        recheckPermission:
        case LocationPermission.whileInUse:
        case LocationPermission.always:
          return true;
        case LocationPermission.deniedForever:
        case LocationPermission.unableToDetermine:
          {
            _logLocationRepository(
              'checkLocationPermissions returning false: denied forever',
            );
            return false;
          }
      }
    } catch (error, stack) {
      _logLocationRepository(
        '_hasPermission Error: $error Stack: $stack',
      );
      rethrow;
    }
  }

  void _logLocationRepository(String message) {
    AppDebug.log(message, name: 'LocationRepository');
  }
}
