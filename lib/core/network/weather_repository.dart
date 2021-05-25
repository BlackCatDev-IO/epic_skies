import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/utils/failure_handler.dart';
import 'package:epic_skies/services/utils/master_getx_controller.dart';
import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/services/utils/location/search_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/view/screens/settings_screens/drawer_animator.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../services/utils/location/location_controller.dart';

class WeatherRepository extends GetxController {
  static WeatherRepository get to => Get.find();

  RxBool isLoading = false.obs;
  bool searchIsLocal = true;

  @override
  void onInit() {
    super.onInit();
    searchIsLocal = StorageController.to.restoreSavedSearchIsLocal();
  }

  Future<void> fetchLocalWeatherData() async {
    if (Get.isRegistered<SearchController>()) {
      Get.delete<SearchController>();
    }

    _updateSearchIsLocal(true);

    final hasConnection = await InternetConnectionChecker().hasConnection;

    if (hasConnection) {
      isLoading(true);
      await LocationController.to.getLocationAndAddress();
      TimeZoneController.to.initLocalTimezoneString();

      final long = LocationController.to.position.longitude;
      final lat = LocationController.to.position.latitude;
      final url = ApiCaller.to.buildTomorrowIOUrl(long: long, lat: lat);
      final data = await ApiCaller.to.getWeatherData(url) ?? {};

      StorageController.to.storeWeatherData(map: data);

      TimeZoneController.to.getTimeZoneOffset();

      if (MasterController.to.firstTimeUse) {
        Get.to(() => const CustomAnimatedDrawer());
        MasterController.to.firstTimeUse = false;
      }

      MasterController.to.initUiValues();
      isLoading(false);
    } else {
      FailureHandler.to.handleNoConnection(method: 'getWeatherData');
    }
  }

  Future<void> fetchRemoteWeatherData(
      {required SearchSuggestion suggestion}) async {
    final hasConnection = await InternetConnectionChecker().hasConnection;

    if (hasConnection) {
      Get.to(() => const CustomAnimatedDrawer());
      ViewController.to.tabController.animateTo(0);
      isLoading(true);

      _updateSearchIsLocal(false);

      final result = await ApiCaller.to.getPlaceDetailsFromId(
          placeId: suggestion.placeId!);

      await LocationController.to.initRemoteLocationData(result);

      TimeZoneController.to.initRemoteTimezoneString();

      final long = LocationController.to.long;
      final lat = LocationController.to.lat;
      final url = ApiCaller.to.buildTomorrowIOUrl(lat: lat, long: long);

      final data = await ApiCaller.to.getWeatherData(url);

      LocationController.to.updateAndStoreSearchHistory(suggestion);
      TimeZoneController.to.getTimeZoneOffset();
      StorageController.to.storeWeatherData(map: data!);
      isLoading(false);

      MasterController.to.initUiValues();
    } else {
      FailureHandler.to.handleNoConnection(method: 'fetchRemoteWeatherData');
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
