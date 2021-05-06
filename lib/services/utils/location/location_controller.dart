import 'dart:async';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';

import '../failure_handler.dart';

class LocationController extends GetxController {
  static LocationController get to => Get.find();

  late Position position;
  late geo.Placemark placemarks;

  String name = '';
  String street = '';
  String subLocality = '';
  String locality = '';
  String administrativeArea = '';
  String postalCode = '';
  String country = '';
  String address = '';

  Map<String, dynamic>? locationMap = {};

  @override
  void onInit() {
    super.onInit();
    locationMap = StorageController.to.restoreLocalLocationData();
  }

  Future<void> _getLocation() async {
    LocationPermission permission;

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      FailureHandler.to.handleLocationTurnedOff();
    } else {
      permission = await Geolocator.checkPermission();

      switch (permission) {
        case LocationPermission.denied:
          {
            permission = await Geolocator.requestPermission();
            if (permission == LocationPermission.denied ||
                permission == LocationPermission.deniedForever) {
              FailureHandler.to.handleLocationPermissionDenied();
            }
          }
          continue getPosition;
        getPosition:
        case LocationPermission.whileInUse:
        case LocationPermission.always:
          {
            position = await Geolocator.getCurrentPosition(
                timeLimit: const Duration(seconds: 10));
            update();
            break;
          }
        case LocationPermission.deniedForever:
          {
            FailureHandler.to.handleLocationPermissionDenied();
          }
      }
    }
  }

  Future<void> getLocationAndAddress() async {
    await _getLocation();
    final List<geo.Placemark> newPlace = await geo.placemarkFromCoordinates(
        position.latitude, position.longitude);

    placemarks = newPlace[0];

    name = placemarks.name!;

    street = placemarks.street!;
    subLocality = placemarks.subLocality!;
    if (subLocality == 'Bronx') {
      subLocality = 'The Bronx';
    }
    locality = placemarks.locality!;
    administrativeArea = placemarks.administrativeArea!;
    postalCode = placemarks.postalCode!;
    country = placemarks.country!;
    address =
        "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";
    _storeLocationValues();

    update();
  }

  void _storeLocationValues() {
    locationMap![streetKey] = street;
    locationMap![subLocalityKey] = subLocality;
    locationMap![localityKey] = locality;
    locationMap![administrativeAreaKey] = administrativeArea;
    locationMap![countryKey] = country;
    locationMap![addressKey] = address;

    StorageController.to.storeLocalLocationData(map: locationMap!);

    update();
  }

  Future<void> initLocationValues() async {
    final map = StorageController.to.restoreLocalLocationData();
    locationMap!.addAll(map);
    if (locationMap![streetKey] != null) {
      street = locationMap![streetKey] as String;
    }

    subLocality = locationMap![subLocalityKey] as String;

    /// sublocality variable is what is displayed on screen
    /// this assigns it to locality if sublocality returns empty
    /// and locality has a value. If location is NYC local borough
    /// is displayed in sublocality
    if (!_isNYC(subLocality)) {
      if (subLocality == '' || locality != '') {
        subLocality = locality;
      }
    }

    locality = locationMap![localityKey] as String;
    administrativeArea = locationMap![administrativeAreaKey] as String;
    country = locationMap![countryKey] as String;

    address = locationMap![addressKey] as String;

    update();
  }

  /// Checks for NYC to ensure local borough is displayed when
  /// user is searching from NYC
  bool _isNYC(String subLocality) {
    switch (subLocality) {
      case 'Manhattan':
      case 'Brooklyn':
      case 'Queens':
      case 'Bronx':
      case 'Staten Island':
        return true;
      default:
        return false;
    }
  }
}
