import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/conversions/timezone_controller.dart';
import 'package:epic_skies/services/error_handling/failure_handler.dart';
import 'package:epic_skies/services/network/api_caller.dart';
import 'package:epic_skies/services/location/search_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/controllers/current_weather_controller.dart';
import 'package:epic_skies/controllers/daily_forecast_controller.dart';
import 'package:epic_skies/controllers/hourly_forecast_controller.dart';
import 'package:epic_skies/view/screens/settings_screens/drawer_animator.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../location/location_controller.dart';

class WeatherRepository extends GetxController {
  static WeatherRepository get to => Get.find();

  RxBool isLoading = false.obs;
  bool searchIsLocal = true;
  bool firstTimeUse = true;

  @override
  void onInit() {
    super.onInit();
    searchIsLocal = StorageController.to.restoreSavedSearchIsLocal();
    firstTimeUse = StorageController.to.firstTimeUse();
  }

  Future<void> fetchLocalWeatherData() async {
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

      _storeAndUpdate(data: data);

      if (firstTimeUse) {
        Get.offAndToNamed(DrawerAnimator.id);
        firstTimeUse = false;
      }
      isLoading(false);
    } else {
      FailureHandler.handleNoConnection(method: 'getWeatherData');
    }
  }

  Future<void> fetchRemoteWeatherData(
      {required SearchSuggestion suggestion}) async {
    _updateSearchIsLocal(false);

    final hasConnection = await InternetConnectionChecker().hasConnection;

    if (hasConnection) {
      ViewController.to.tabController.animateTo(0);
      isLoading(true);

      final result =
          await ApiCaller.to.getPlaceDetailsFromId(placeId: suggestion.placeId);

      await LocationController.to
          .initRemoteLocationData(data: result, suggestion: suggestion);

      TimeZoneController.to.initRemoteTimezoneString();

      final long = LocationController.to.long;
      final lat = LocationController.to.lat;
      final url = ApiCaller.to.buildTomorrowIOUrl(lat: lat, long: long);
      final data = await ApiCaller.to.getWeatherData(url);

      LocationController.to.updateAndStoreSearchHistory(suggestion);
      isLoading(false);
      _storeAndUpdate(data: data!);
    } else {
      FailureHandler.handleNoConnection(method: 'fetchRemoteWeatherData');
    }
  }

  Future<void> updateUIValues() async {
    CurrentWeatherController.to.initCurrentWeatherValues();
    LocationController.to.initLocationValues();
    HourlyForecastController.to.buildHourlyForecastWidgets();
    DailyForecastController.to.buildDailyForecastWidgets();
  }

  void refreshWeatherData() {
    final bool searchIsLocal = StorageController.to.restoreSavedSearchIsLocal();
    if (searchIsLocal) {
      fetchLocalWeatherData();
    } else {
      updateRemoteLocationData();
    }
  }

  Future<void> updateRemoteLocationData() async {
    final suggestion = StorageController.to.restoreLatestSuggestion();
    fetchRemoteWeatherData(suggestion: suggestion);
  }

  void _updateSearchIsLocal(bool value) {
    searchIsLocal = value;
    StorageController.to.storeLocalOrRemote(searchIsLocal: searchIsLocal);
  }

  void retryLocalWeatherAfterLocationError() {
    Get.back();
    ViewController.to.tabController.animateTo(0);
    fetchLocalWeatherData();
  }

  void retryWeatherSearchAfterNetworkError() {
    Get.back();
    ViewController.to.tabController.animateTo(0);
    refreshWeatherData();
  }

  void _storeAndUpdate({required Map data}) {
    StorageController.to.storeWeatherData(map: data);
    TimeZoneController.to.getTimeZoneOffset();
    isLoading(false);
    updateUIValues();
    update();
  }
}
