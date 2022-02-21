import 'dart:async';
import 'dart:developer';

import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/features/location/user_location/models/location_model.dart';
import 'package:epic_skies/services/loading_status_controller/loading_status_controller.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:get/get.dart';
import 'package:location/location.dart';

import '../../../../core/error_handling/failure_handler.dart';
import '../../../../services/settings/unit_settings/unit_settings_model.dart';

class LocationController extends GetxController {
  LocationController({required this.storage});

  static LocationController get to => Get.find();

  final StorageController storage;

  late LocationData position;

  late geo.Placemark placemarks;

  final location = Location();

  bool acquiredLocation = false;

  late LocationModel? data;

  @override
  void onInit() {
    super.onInit();
    if (!storage.firstTimeUse()) {
      data = storage.restoreLocalLocationData();
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
      if (storage.firstTimeUse()) {
        LoadingStatusController.to.showFetchingLocationStatus();
      }
      await _getCurrentPosition();

      late List<geo.Placemark>? newPlace;

      try {
        newPlace = await geo.placemarkFromCoordinates(
          position.latitude!,
          position.longitude!,
          // Rancho Santa Margarita coordinates for checking long names
          // 33.646510177241666,
          // -117.59434532284129,
        );

        log('lat: ${position.latitude} long: ${position.longitude}');

        data = LocationModel.fromPlacemark(place: newPlace[0]);

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
      update();
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
    final response = await ApiCaller.to.getBackupApiDetails(
      lat: position.latitude!,
      long: position.longitude!,
    );

    log(response.toString());

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
    if (storage.firstTimeUse()) {
      _setUnitSettingsAccordingToCountryOnFirstInstall();
    }
    acquiredLocation = true;

    storage.storeLocalLocationData(data: data!);
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

      storage.storeCoordinates(
        lat: position.latitude!,
        long: position.longitude!,
      );

      if (storage.firstTimeUse()) {
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
    bool isMetric = true;
    switch (country) {
      case 'united states':
      case 'liberia':
      case 'myanmar':
        isMetric = false;
        break;
    }

    final initalSettings = UnitSettings(
      id: 1,
      timeIn24Hrs: false,
      speedInKph: isMetric,
      tempUnitsMetric: isMetric,
      precipInMm: isMetric,
    );

    storage.storeInitialUnitSettings(settings: initalSettings);
  }
}
