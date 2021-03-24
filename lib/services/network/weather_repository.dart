import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:epic_skies/global/alert_dialogs.dart';
import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/utils/failure_handler.dart';
import 'package:epic_skies/services/utils/master_getx_controller.dart';
import 'package:epic_skies/services/network/api_caller.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/services/utils/settings_controller.dart';
import 'package:epic_skies/services/utils/view_controller.dart';
import 'package:epic_skies/widgets/general/animated_drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../utils/location_controller.dart';

class WeatherRepository extends GetxController {
  static WeatherRepository get to => Get.find();

  RxBool isLoading = false.obs;
  bool searchIsLocal = true;

  Future<void> fetchLocalWeatherData() async {
    _updateSearchIsLocal(true);

    final hasConnection = await DataConnectionChecker().hasConnection;

    if (hasConnection) {
      await LocationController.to.getLocationAndAddress();
      isLoading(true);
      TimeZoneController.to.initLocalTimezoneString();

      final long = LocationController.to.position.longitude;
      final lat = LocationController.to.position.latitude;
      final apiCaller = ApiCaller();
      final url = apiCaller.buildClimaCellUrl(long: long, lat: lat);
      final data = await apiCaller.getWeatherData(url);

      StorageController.to.storeWeatherData(map: data);
      TimeZoneController.to.getTimeZoneOffset();

      if (MasterController.to.firstTimeUse) {
        Get.to(() => const CustomAnimatedDrawer());
        MasterController.to.firstTimeUse = false;
      }

      MasterController.to.initUiValues();
      isLoading(false);
      SettingsController.to.resetSettingChangeCounters();
    } else {
      showNoConnectionDialog(context: Get.context);

      FailureHandler.to.handleNoConnection();
    }
  }

  Future<void> fetchRemoteWeatherData(
      {@required SearchSuggestion suggestion}) async {
    final hasConnection = await DataConnectionChecker().hasConnection;

    if (hasConnection) {
      Get.to(() => const CustomAnimatedDrawer());
      ViewController.to.tabController.animateTo(0);
      isLoading(true);
      final apiCaller = ApiCaller();

      _updateSearchIsLocal(false);

      await apiCaller.getPlaceDetailsFromId(
          placeId: suggestion.placeId,
          sessionToken: SearchController.to.sessionToken);
      TimeZoneController.to.initRemoteTimezoneString();

      final long = SearchController.to.long;
      final lat = SearchController.to.lat;
      final url = apiCaller.buildClimaCellUrl(lat: lat, long: long);
      final data = await apiCaller.getWeatherData(url);

      SearchController.to.updateAndStoreSearchHistory(suggestion);
      TimeZoneController.to.getTimeZoneOffset();
      StorageController.to.storeWeatherData(map: data);
      isLoading(false);

      MasterController.to.initUiValues();
    } else {
      FailureHandler.to.handleNoConnection();
    }
  }

  Future<void> updateRemoteLocationData() async {
    final suggestion = StorageController.to.restoreLatestSuggestion();
    WeatherRepository.to.fetchRemoteWeatherData(suggestion: suggestion);
  }

  void _updateSearchIsLocal(bool value) {
    searchIsLocal = value;
    StorageController.to.storeLocalOrRemote(searchIsLocal: searchIsLocal);
  }
}
