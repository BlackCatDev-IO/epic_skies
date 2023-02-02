import 'dart:async';
import 'dart:io';

import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/features/location/remote_location/models/remote_location/remote_location_model.dart';
import 'package:epic_skies/features/location/search/models/search_suggestion/search_suggestion.dart';
import 'package:epic_skies/features/location/user_location/models/location_model.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:location/location.dart';

class LocationRepository {
  LocationRepository({
    required ApiCaller apiCaller,
  }) : _apiCaller = apiCaller;

  final ApiCaller _apiCaller;

  final _location = Location();

  Future<LocationData> getCurrentPosition() async {
    try {
      if (!await InternetConnectionChecker().hasConnection) {
        throw NoConnectionException();
      }

      if (!await _location.serviceEnabled()) {
        throw LocationServiceDisableException();
      }

      if (!await _hasLocationPermission()) {
        throw LocationNoPermissionException();
      }

      final position = await _location.getLocation();

      return position;
    } on TimeoutException catch (e) {
      _logLocationRepository(
        'Geolocator.getCurrentPosition error: $e',
      );
      throw LocationTimeOutException();
    } catch (e) {
      rethrow;
    }
  }

  Future<LocationModel?> getLocationDetailsFromBackupAPI({
    required double lat,
    required double long,
  }) async {
    try {
      final response = await _apiCaller.getBackupApiDetails(
        lat: lat,
        long: long,
      );

      _logLocationRepository(response.toString());

      return LocationModel.fromBingMaps(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map?> fetchSearchSuggestions({
    required String query,
  }) async {
    try {
      if (!await InternetConnectionChecker().hasConnection) {
        throw NoConnectionException();
      }

      return await _apiCaller.fetchSuggestions(
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
      if (!await InternetConnectionChecker().hasConnection) {
        throw NoConnectionException();
      }

      final placeDetails =
          await _apiCaller.getPlaceDetailsFromId(placeId: suggestion.placeId);

      final locationModel = RemoteLocationModel.fromResponse(
        map: placeDetails as Map<String, dynamic>,
        suggestion: suggestion,
      );

      _logLocationRepository(
        'searchCity character length: ${locationModel.city.length}',
      );

      _logLocationRepository(
        'City:${locationModel.city} \nState:${locationModel.state}  \nCountry:${locationModel.country}',
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
    var permission = await _location.hasPermission();

    try {
      switch (permission) {
        case PermissionStatus.denied:
          {
            permission = await _location.requestPermission();
            if (permission == PermissionStatus.denied ||
                permission == PermissionStatus.deniedForever) {
              _logLocationRepository(
                'checkLocationPermissions returning false in 1st case',
              );
              return false;
            }
          }
          continue recheckPermission;
        recheckPermission:
        case PermissionStatus.granted:
        case PermissionStatus.grantedLimited:
          return true;
        case PermissionStatus.deniedForever:
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
