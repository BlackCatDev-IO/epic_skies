import 'dart:async';
import 'dart:io';

import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

import '../core/database/storage_controller.dart';
import '../core/error_handling/failure_handler.dart';
import '../core/network/api_caller.dart';
import '../features/location/remote_location/models/remote_location_model.dart';
import '../features/location/remote_location/models/search_suggestion.dart';
import '../features/location/user_location/models/location_model.dart';
import '../services/loading_status_controller/loading_status_controller.dart';

class LocationRepository {
  LocationRepository({
    required StorageController storage,
    required ApiCaller apiCaller,
  })  : _storage = storage,
        _apiCaller = apiCaller;
  final StorageController _storage;

  final ApiCaller _apiCaller;

  final _location = Location();

  Future<LocationData?> getCurrentPosition() async {
    try {
      final position = await _location.getLocation();

      if (_storage.firstTimeUse()) {
        LoadingStatusController.to.showFetchingLocalWeatherStatus();
      }

      return position;
    } on TimeoutException catch (e) {
      FailureHandler.handleLocationTimeout(
        message: 'Timeout Exception: error: $e',
        isTimeout: true,
      );
      _logLocationRepository(
        'Geolocator.getCurrentPosition error: $e',
      );
    } catch (e) {
      FailureHandler.handleLocationTimeout(
        message: 'Unhandled exception $e',
        isTimeout: false,
      );
    }
    return null;
  }

  Future<LocationModel?> getLocationDetailsFromBackupAPI({
    required double lat,
    required double long,
  }) async {
    String endResult = '';
    final response = await _apiCaller.getBackupApiDetails(
      lat: lat,
      long: long,
    );

    _logLocationRepository(response.toString());

    if (response.isNotEmpty) {
      final data = LocationModel.fromBingMaps(response);
      endResult = 'Backup API successful: data: $data';
      storeLocalLocationData(data);
      return data;
    } else {
      final data = LocationModel.emptyModel();
      endResult = 'Backup API failed: data: $data';
      FailureHandler.reportNoAddressInfoFoundToSentry(
        endResult: endResult,
      );
      return null;
    }
  }

  Future<bool> isServiceEnabled() async {
    return _location.serviceEnabled();
  }

  Future<bool> checkLocationPermissions() async {
    PermissionStatus permission = await _location.hasPermission();

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
      default:
        _logLocationRepository(
          'checkLocationPermissions returning false in default',
        );
        return false;
    }
  }

  Future<Map?> fetchSearchSuggestions({
    required String query,
  }) async {
    _logLocationRepository(
      'Get locale: ${Localizations.localeOf(Get.context!).languageCode} Platform: ${Platform.localeName}',
    );
    try {
      return await _apiCaller.fetchSuggestions(
        query: query,
        // lang: Localizations.localeOf(Get.context!).languageCode,
        lang: Platform.localeName,
      ) as Map<String, dynamic>?;
    } catch (error, stack) {
      _logLocationRepository(
        'fetchSearchSuggestions ERROR: $error, stack: $stack',
      );
      return null;
    }
  }

  Future<RemoteLocationModel?> getRemoteLocationModel({
    required SearchSuggestion suggestion,
  }) async {
    try {
      final placeDetails =
          await _apiCaller.getPlaceDetailsFromId(placeId: suggestion.placeId);

      final locationModel = RemoteLocationModel.fromResponse(
        map: placeDetails as Map<String, dynamic>,
        suggestion: suggestion,
      );

      _storage.storeRemoteLocationData(
        data: locationModel,
        suggestion: suggestion,
      );

      _storage.storeSearchHistory2(suggestion);

      // storeSearchHistory(updatedSearchHistory);

      _logLocationRepository(
        'searchCity character length: ${locationModel.city.length}',
      );

      _logLocationRepository(
        'City:${locationModel.city} \nState:${locationModel.state}  \nCountry:${locationModel.country}',
      );
      return locationModel;
    } catch (error, stack) {
      _logLocationRepository(
        'getRemoteLocationModel: ERROR: $error, stack: $stack',
      );
      return null;
    }
  }

  void storeLocalLocationData(LocationModel locationModel) {
    _storage.storeLocalLocationData(data: locationModel);
  }

  void storeSearchHistory(List<SearchSuggestion> searchHistory) {
    /// ObjectBox returns list in order of id's. This ensures
    /// that storage returns the list in the order it was at the
    /// time of being stored
    for (int i = 0; i < searchHistory.length; i++) {
      searchHistory[i].id = i + 1;
    }
    _storage.updateSearchHistory(searchHistory);
  }

  List<SearchSuggestion> restoreSearchHistory() {
    return _storage.restoreSearchHistory().reversed.toList();
  }

  void _logLocationRepository(String message) {
    AppDebug.log(message, name: 'LocationRepository');
  }

  void clearSearchHistory() {
    _storage.updateSearchHistory([]);
  }
}
