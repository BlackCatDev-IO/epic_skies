import 'dart:async';
import 'dart:developer';

import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/models/location_models/location_model.dart';
import 'package:epic_skies/services/loading_status_controller/loading_status_controller.dart';
import 'package:epic_skies/services/settings/unit_settings_controller.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:location/location.dart';

import '../../core/error_handling/failure_handler.dart';

class LocationController extends GetxController {
  static LocationController get to => Get.find();

  late LocationData position;

  late geo.Placemark placemarks;

  final location = Location();

  bool acquiredLocation = false;

  late LocationModel? data;

  @override
  void onInit() {
    super.onInit();
    final firstTimeUse = StorageController.to.firstTimeUse();
    if (!firstTimeUse) {
      data = LocationModel.fromStorage(
        map: StorageController.to.restoreLocalLocationData(),
      );
    }
  }

  Future<void> getLocationAndAddress() async {
    acquiredLocation = false;

    final serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      await FailureHandler.handleLocationTurnedOff();
      return;
    }

    final permissionGranted = await _checkLocationPermissions();
    if (permissionGranted) {
      final firstTime = StorageController.to.firstTimeUse();
      if (firstTime) {
        LoadingStatusController.to.showFetchingLocationStatus();
      }
      await _getCurrentPosition();

      late List<geo.Placemark>? newPlace;

      try {
        newPlace = await geo.placemarkFromCoordinates(
          position.latitude!,
          position.longitude!,
        );

        log('lat: ${position.latitude} long: ${position.longitude}');

        data = LocationModel.fromPlacemark(place: newPlace[0]);

        log(data.toString());

        if (data != null) {
          _storeAndInitLocationData();
        }
      } on PlatformException catch (e) {
        /// This platform exception happens pretty consistently on the first
        /// install of certain devices and I have no control over nor does the
        /// author of Geocoding as its a device system issue
        /// So Bing Maps reverse geocoding api gets called as a backup when this
        /// happens
        _initAddressDetailsFromBackupAPI(errorCode: e.code);
        log('code: ${e.code} message: ${e.message}');
      }
    } else {
      log('get location attempted with location permission not granted');
      await FailureHandler.handleLocationPermissionDenied();
      return;
    }
  }

  Future<void> _initAddressDetailsFromBackupAPI({
    required String errorCode,
  }) async {
    late String endResult;
    final response = await ApiCaller.getBackupApiDetails(
      lat: position.latitude!,
      long: position.longitude!,
    );

    if (response.isNotEmpty) {
      data = LocationModel.fromBingMaps(response);
      endResult = 'Backup API successful: data: $data';
      _storeAndInitLocationData();
    } else {
      data = LocationModel.emptyModel();
      endResult = 'Backup API failed: data: $data';
    }

    FailureHandler.reportNoAddressInfoFoundToSentry(
      code: errorCode,
      endResult: endResult,
    );
  }

  void _storeAndInitLocationData() {
    if (StorageController.to.firstTimeUse()) {
      _setUnitSettingsAccordingToCountryOnFirstInstall();
    }
    acquiredLocation = true;

    StorageController.to.storeLocalLocationData(map: data!.toMap());
  }

  Future<bool> _checkLocationPermissions() async {
    PermissionStatus permission = await location.hasPermission();

    switch (permission) {
      case PermissionStatus.denied:
        {
          permission = await location.requestPermission();
          if (permission == PermissionStatus.denied ||
              permission == PermissionStatus.deniedForever) {
            log(
              'returning false in 1st case',
              name: 'checkLocationPermissions',
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
          log(
            'returning false: denied forever',
            name: 'checkLocationPermissions',
          );
          return false;
        }
      default:
        log('returning false in default', name: 'checkLocationPermissions');
        return false;
    }
  }

  Future<void> _getCurrentPosition() async {
    try {
      position = await location.getLocation();
      final firstTime = StorageController.to.firstTimeUse();
      if (firstTime) {
        LoadingStatusController.to.showFetchingLocalWeatherStatus();
      }
      acquiredLocation = true;
    } on TimeoutException catch (e) {
      FailureHandler.handleLocationTimeout(
        message: 'Timeout Exception: error: $e',
        isTimeout: true,
      );
      log(
        'Geolocator.getCurrentPosition error: $e',
        name: 'LocationController',
      );
    } catch (e) {
      FailureHandler.handleLocationTimeout(
        message: 'Unhandled exception $e',
        isTimeout: false,
      );
    }
  }

  void _setUnitSettingsAccordingToCountryOnFirstInstall() {
    final country = data!.country.toLowerCase();
    switch (country) {
      case 'united states':
      case 'liberia':
      case 'myanmar':
        return;
      default:
        UnitSettingsController.to.setUnitsToMetric();
    }
  }
}
