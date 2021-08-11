import 'dart:async';
import 'dart:developer';
import 'package:black_cat_lib/formatting/us_state_formatting/us_states_formatting.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/settings/unit_settings_controller.dart';
import 'package:epic_skies/services/utils/formatters/address_formatter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import '../error_handling/failure_handler.dart';
import 'search_controller.dart';

class LocationController extends GetxController {
  static LocationController get to => Get.find();

/* -------------------------------------------------------------------------- */
/*                                USER LOCATION                               */
/* -------------------------------------------------------------------------- */

  late Position position;
  late geo.Placemark placemarks;

  String name = '';
  String street = '';
  String subLocality = '';
  String locality = '';
  String administrativeArea = '';
  String country = '';

  bool acquiredLocation = false;

  Map<String, dynamic>? locationMap = {};

  @override
  void onInit() {
    super.onInit();
    locationMap = StorageController.to.restoreLocalLocationData();
    _initLocationDataFromStorage();
    _restoreSearchHistory();
  }

  Future<void> getLocationAndAddress() async {
    acquiredLocation = false;

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await FailureHandler.handleLocationTurnedOff();
      return;
    }

    final permissionGranted = await _checkLocationPermissions();
    if (permissionGranted) {
      await _getCurrentPosition();
      final List<geo.Placemark> newPlace = await geo.placemarkFromCoordinates(
          position.latitude, position.longitude);

      log('lat: ${position.latitude} long: ${position.longitude}');

      placemarks = newPlace[0];
      name = placemarks.name!;
      street = placemarks.street!;
      subLocality = placemarks.subLocality!;
      locality = placemarks.locality!;
      administrativeArea = placemarks.administrativeArea!;
      country = placemarks.country!;

      if (StorageController.to.firstTimeUse()) {
        _setUnitSettingsAccordingToCountryOnFirstInstall();
      }
      acquiredLocation = true;

      _initLocationMapForStorage();
      _checkCountrySpecificFormatting();
      StorageController.to.storeLocalLocationData(map: locationMap!);

      update();
    } else {
      log('permissions returning false');
      await FailureHandler.handleLocationPermissionDenied();
      return;
    }
  }

  Future<bool> _checkLocationPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();

    switch (permission) {
      case LocationPermission.denied:
        {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied ||
              permission == LocationPermission.deniedForever) {
            log('returning false in 1st case',
                name: 'checkLocationPermissions');
            return false;
          }
        }
        continue getPosition;
      getPosition:
      case LocationPermission.whileInUse:
      case LocationPermission.always:
        return true;
      case LocationPermission.deniedForever:
        {
          log('returning false: denied forever',
              name: 'checkLocationPermissions');
          return false;
        }
      default:
        log('returning false in default', name: 'checkLocationPermissions');
        return false;
    }
  }

  Future<void> _getCurrentPosition() async {
    try {
      position = await Geolocator.getCurrentPosition(
        timeLimit: const Duration(seconds: 10),
      );
      update();
    } on TimeoutException {
      FailureHandler.handleLocationTimeout();
    } catch (e) {
      log('Geolocator.getCurrentPosition error: $e',
          name: 'LocationController');
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
    locationMap![streetKey] = street;
    locationMap![subLocalityKey] = subLocality;
    locationMap![localityKey] = locality;
    locationMap![administrativeAreaKey] = administrativeArea;
    locationMap![countryKey] = country;

    update();
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
    update();
  }

  void _initValuesFromMap() {
    if (locationMap![streetKey] != null) {
      street = locationMap![streetKey] as String;
    }
    subLocality = locationMap![subLocalityKey] as String;
    locality = locationMap![localityKey] as String;
    administrativeArea = locationMap![administrativeAreaKey] as String;
    country = locationMap![countryKey] as String;
  }

  void _checkCountrySpecificFormatting() {
    switch (country.toLowerCase()) {
      case 'united states':
        _formatAmericanAddresses();
        break;
      case 'colombia':
        _formatColombianAddress();
        break;
      default:
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
    update();
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
    update();
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

/* -------------------------------------------------------------------------- */
/*                              REMOTE LOCATIONS                              */
/* -------------------------------------------------------------------------- */

  String searchCity = '';
  String searchState = '';
  String searchCountry = '';

  RxList searchHistory = [].obs;
  RxList currentSearchList = [].obs;

  Map<String, dynamic> remoteLocationMap = {};

  late double lat, long;

  void updateAndStoreSearchHistory(SearchSuggestion suggestion) {
    searchHistory.removeWhere((value) => value == null);
    searchHistory.insert(0, suggestion);
    _removeDuplicates();
    StorageController.to.storeSearchHistory(searchHistory, suggestion);
  }

  void _restoreSearchHistory() {
    final RxList list = StorageController.to.restoreSearchHistory().obs;
    searchHistory.addAll(list);
  }

  void clearSearchHistory() {
    searchHistory.clear();
    StorageController.to.storeSearchHistory();
    Get.back();
  }

  void deleteSelectedSearch(SearchSuggestion selectedSuggestion) {
    for (int i = 0; i < searchHistory.length; i++) {
      final suggestion = searchHistory[i];
      if (suggestion.placeId == selectedSuggestion.placeId) {
        searchHistory.removeAt(i);
      }
    }
    StorageController.to.storeSearchHistory(searchHistory);
    Get.back();
  }

  void _removeDuplicates() {
    SearchSuggestion? duplicate;
    for (int i = 0; i < searchHistory.length; i++) {
      duplicate = searchHistory[i] as SearchSuggestion?;
      for (int j = 0; j < searchHistory.length; j++) {
        final suggestion = searchHistory[j] as SearchSuggestion;
        if (suggestion.placeId == duplicate!.placeId && i != j) {
          searchHistory.removeAt(j);
        }
      }
    }
  }

  Future<void> initRemoteLocationData(
      {required Map data, required SearchSuggestion suggestion}) async {
    final dataMap = data['result']['address_components'];
    lat = data['result']['geometry']['location']['lat'] as double;
    long = data['result']['geometry']['location']['lng'] as double;

    _clearLocationValues();

    log('components length ${dataMap.length} Suggestion description ${suggestion.description}',
        name: 'LocationController');
    searchCity = dataMap[0]['long_name'] as String;
    _checkForMismatchSuggestionNames(suggestion: suggestion);

    for (int i = 1; i < (dataMap.length as int); i++) {
      final type = dataMap[i]['types'][0];

      switch (type as String) {
        case 'country':
          searchCountry = dataMap[i]['long_name'] as String;
          break;
        case 'administrative_area_level_1':
          searchState = dataMap[i]['long_name'] as String;
          break;
      }
    }

    if (searchCountry != 'United States') {
      searchState = '';
    } else {
      searchState = USStates.getAbbreviation(searchState);
    }
    log('City:$searchCity \nState:$searchState \nCountry:$searchCountry',
        name: 'LocationController');

    update();
    _storeRemoteLocationData();
  }

  /// Search suggestions lists "Calcutta" but the findDetailsFromPlaceId
  /// returns "Kalcutta". This ensures the CurrentWeatherRow dispays
  /// the same city spelling as the search suggestion when 2 differnt spellings
  /// exist
  void _checkForMismatchSuggestionNames(
      {required SearchSuggestion suggestion}) {
    final splitDescription = suggestion.description.split(' ');

    final List<String> tempList = [];
    for (String string in splitDescription) {
      tempList.add(string);
      if (string.endsWith(',')) {
        string = string.substring(0, string.length - 1);
        tempList.removeLast();
        tempList.add(string);
        break;
      }
    }

    String suggestionCity = AddressFormatter.rejoinSplit(stringList: tempList);

    if (suggestionCity.endsWith(',')) {
      suggestionCity = suggestionCity.substring(0, suggestionCity.length - 1);
    }

    if (searchCity != suggestionCity) {
      searchCity = suggestionCity;
    }
  }

  void _storeRemoteLocationData() {
    remoteLocationMap = {
      'city': searchCity,
      'state': searchState,
      'country': searchCountry,
    };
    StorageController.to.storeRemoteLocationData(map: remoteLocationMap);
  }

  void _initLocationDataFromStorage() {
    remoteLocationMap = StorageController.to.restoreRemoteLocationData();
    searchCity = remoteLocationMap['city'] as String? ?? '';
    searchState = remoteLocationMap['state'] as String? ?? '';
    searchCountry = remoteLocationMap['country'] as String? ?? '';
  }

  void _clearLocationValues() {
    searchCity = '';
    searchState = '';
    searchCountry = '';
  }
}
