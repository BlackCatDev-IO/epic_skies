import 'dart:async';
import 'dart:developer';

import 'package:black_cat_lib/formatting/us_state_formatting/us_states_formatting.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/map_keys/location_map_keys.dart';
import 'package:epic_skies/services/loading_status_controller/loading_status_controller.dart';
import 'package:epic_skies/services/settings/unit_settings_controller.dart';
import 'package:epic_skies/utils/formatters/address_formatter.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:location/location.dart';

import '../../core/error_handling/failure_handler.dart';

class LocationController extends GetxController {
  static LocationController get to => Get.find();

/* -------------------------------------------------------------------------- */
/*                                USER LOCATION                               */
/* -------------------------------------------------------------------------- */

  late LocationData position;
  late geo.Placemark placemarks;

  final location = Location();

  String name = '';
  String street = '';
  String subLocality = '';
  String locality = '';
  String administrativeArea = '';
  String subAdministrativeArea = '';
  String country = '';

  List<String> multiWordCityList = [];

  bool acquiredLocation = false;

  bool longMultiWordCity = false;

  Map<String, dynamic>? locationMap = {};

  @override
  void onInit() {
    super.onInit();
    locationMap = StorageController.to.restoreLocalLocationData();
    // _initLocationDataFromStorage();
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
        log(locationMap.toString());
      } on PlatformException catch (e) {
        /// fetching data still needs to continue even if address details
        /// can't be provided from coordinates
        log('code: ${e.code} message: ${e.message}');
        _displayNoAddressInfoFound();
        FailureHandler.reportNoAddressInfoFoundToSentry(code: e.code);
      } catch (e) {
        rethrow;
      }

      if (newPlace != null) {
        _initPlacemarkData(place: newPlace);
      }
      _storeAndInitLocationData();
    } else {
      log('get location attempted with location permission not granted');
      await FailureHandler.handleLocationPermissionDenied();
      return;
    }
  }

  void _displayNoAddressInfoFound() {
    name = '';
    street = '';
    subLocality = '';
    locality = '';
    administrativeArea = '';
    subAdministrativeArea = 'Unable to determine local address';
    country = '';
  }

  void _initPlacemarkData({required List<geo.Placemark> place}) {
    placemarks = place[0];
    name = placemarks.name!;
    street = placemarks.street!;
    subLocality = placemarks.subLocality!;
    locality = placemarks.locality!;
    administrativeArea = placemarks.administrativeArea!;
    subAdministrativeArea = placemarks.subAdministrativeArea!;
    country = placemarks.country!;
  }

  void _storeAndInitLocationData() {
    if (StorageController.to.firstTimeUse()) {
      _setUnitSettingsAccordingToCountryOnFirstInstall();
    }
    acquiredLocation = true;

    _initLocationMapForStorage();
    _checkCountrySpecificFormatting();
    StorageController.to.storeLocalLocationData(map: locationMap!);
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
    switch (country.toLowerCase()) {
      case 'united states':
      case 'liberia':
      case 'myanmar':
        return;
      default:
        UnitSettingsController.to.setUnitsToMetric();
    }
  }

  void _initLocationMapForStorage() {
    locationMap![LocationMapKeys.street] = street;
    locationMap![LocationMapKeys.subLocality] = subLocality;
    locationMap![LocationMapKeys.localityKey] = locality;
    locationMap![LocationMapKeys.administrativeArea] = administrativeArea;
    locationMap![LocationMapKeys.subAdministrativeArea] = subAdministrativeArea;
    locationMap![LocationMapKeys.country] = country;
  }

  Future<void> initLocationValues() async {
    final map = StorageController.to.restoreLocalLocationData();
    locationMap!.addAll(map);

    _initValuesFromMap();

    /// sublocality variable is what is displayed on screen
    /// this assigns it to locality if sublocality returns empty
    /// and locality has a value. If location is NYC local borough
    /// is displayed in sublocality
    if (!_isNYC()) {
      if (subLocality == '' && locality != '') {
        subLocality = locality;
      }
    }

    if (_isUK()) {
      if (subLocality == '' && locality == '') {
        subLocality = subAdministrativeArea;
      }
    }
    _fixOddCityFormatting();

    update();
  }

  void _initValuesFromMap() {
    if (locationMap![LocationMapKeys.street] != null) {
      street = locationMap![LocationMapKeys.street] as String;
    }
    subLocality = locationMap![LocationMapKeys.subLocality] as String;
    _formatCityName(city: subLocality);
    locality = locationMap![LocationMapKeys.localityKey] as String;
    administrativeArea =
        locationMap![LocationMapKeys.administrativeArea] as String;
    subAdministrativeArea =
        locationMap![LocationMapKeys.subAdministrativeArea] as String;
    country = locationMap![LocationMapKeys.country] as String;
  }

  void _checkCountrySpecificFormatting() {
    switch (country.toLowerCase()) {
      case 'united states':
        _formatAmericanAddresses();
        break;
      case 'colombia':
        _formatColombianAddress();
        break;
    }
  }

  void _formatAmericanAddresses() {
    administrativeArea = USStates.getName(administrativeArea);
    locationMap![administrativeArea] = administrativeArea;

    /// Sometimes apt # is displayed for local searches
    /// It is unnecessary and is often the incorrect apt #
    /// anyway so this removes it
    if (street.contains('#')) {
      locationMap = AddressFormatter.removeUnitNumber(map: locationMap!);
      _initValuesFromMap();
    }
    _initLocationMapForStorage();
    StorageController.to.storeLocalLocationData(map: locationMap!);
  }

  /// Addresses in Colombia can return weird formatting
  /// that doesn't look good by default. This makes it
  /// look better to someone who lives there
  void _formatColombianAddress() {
    locationMap = AddressFormatter.formatColombianAddresses(
      map: locationMap!,
    );
    _initValuesFromMap();
    StorageController.to.storeLocalLocationData(map: locationMap!);
  }

  /// Checks for NYC to ensure local borough is displayed when
  /// user is searching from NYC
  bool _isNYC() {
    switch (subLocality.toLowerCase()) {
      case 'bronx':
        subLocality = 'The Bronx';
        return true;
      case 'the bronx':
      case 'manhattan':
      case 'brooklyn':
      case 'queens':
      case 'staten island':
        return true;
      default:
        return false;
    }
  }

  bool _isUK() {
    switch (country.toLowerCase()) {
      case 'united kingdom':
      case 'uk':
        return true;
      default:
        return false;
    }
  }

  /// I add stuff to this function as I see it
  void _fixOddCityFormatting() {
    switch (subLocality.toLowerCase()) {
      case 'newcastle upon tyne':
        {
          subLocality = 'Newcastle';
        }
        break;
    }
    _formatCityName(city: subLocality);

    update();
  }

  void _formatCityName({required String city}) {
    if (city.length <= 11) {
      longMultiWordCity = false;
      return;
    } else {
      if (city.contains(' ')) {
        longMultiWordCity = true;
        multiWordCityList.clear();
        final splitCity = city.split(' ');
        for (final word in splitCity) {
          final capWord = word.capitalizeFirst;
          multiWordCityList.add(capWord!);
        }
      }
      update();
    }
  }
}
