import 'dart:async';
import 'dart:io';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';

import 'failure_handler.dart';

class LocationController extends GetxController {
  static LocationController get to => Get.find();

  Position position;
  geo.Placemark placemarks;

  String name = '';
  String street = '';
  String subLocality = '';
  String locality = '';
  String administrativeArea = '';
  String postalCode = '';
  String country = '';
  String address = '';

  Map<String, dynamic> locationMap = {};

  Future<void> _getLocation() async {
    LocationPermission permission;

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      FailureHandler.to.handleLocationTurnedOff();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
    try {
      position = await Geolocator.getCurrentPosition(
          timeLimit: const Duration(seconds: 10));
    } on SocketException {
      debugPrint('socket exception');
      throw FailureHandler();
    } on HttpException {
      throw FailureHandler();
    } on FormatException {
      throw FailureHandler();
    } on TimeoutException {
      throw FailureHandler();
    }
    update();
  }

  Future<void> getLocationAndAddress() async {
    await _getLocation();
    final List<geo.Placemark> newPlace = await geo.placemarkFromCoordinates(
        position.latitude, position.longitude);

    placemarks = newPlace[0];

    name = placemarks.name;

    street = placemarks.street;
    subLocality = placemarks.subLocality;
    if (subLocality == 'Bronx') {
      subLocality = 'The Bronx';
    }
    locality = placemarks.locality;
    administrativeArea = placemarks.administrativeArea;
    postalCode = placemarks.postalCode;
    country = placemarks.country;
    address =
        "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";
    _storeLocationValues();

    update();
  }

  void _storeLocationValues() {
    locationMap[streetKey] = street;
    locationMap[subLocalityKey] = subLocality;
    locationMap[localityKey] = locality;
    locationMap[administrativeAreaKey] = administrativeArea;
    locationMap[countryKey] = country;
    locationMap[addressKey] = address;

    StorageController.to.storeLocalLocationData(map: locationMap);

    update();
  }

  Future<void> initLocationValues() async {
    final map = StorageController.to.restoreLocalLocationData();
    locationMap.addAll(map);
    street = locationMap[streetKey] as String;
    subLocality = locationMap[subLocalityKey] as String;
    locality = locationMap[localityKey] as String;
    administrativeArea = locationMap[administrativeAreaKey] as String;
    country = locationMap[countryKey] as String;
    address = locationMap[addressKey] as String;

    update();
  }
}
