import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/core/error_handling/failure_handler.dart';
import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/features/forecast_controllers.dart';
import 'package:epic_skies/features/location/remote_location/controllers/remote_location_controller.dart';
import 'package:epic_skies/features/location/remote_location/models/search_suggestion.dart';
import 'package:epic_skies/features/location/user_location/controllers/location_controller.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:epic_skies/utils/storage_getters/settings.dart';
import 'package:epic_skies/view/screens/settings_screens/drawer_animator.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../services/settings/unit_settings/unit_settings_model.dart';

class WeatherRepository extends GetxController {
  WeatherRepository({required this.storage});

  final StorageController storage;

  static WeatherRepository get to => Get.find();

  WeatherResponseModel? weatherModel;

  RxBool isLoading = false.obs;

  bool searchIsLocal = true;

  @override
  void onInit() {
    super.onInit();

    _initWeatherDataFromStorage();
  }

  Future<void> fetchLocalWeatherData() async {
    final hasConnection = await InternetConnectionChecker().hasConnection;
    _updateSearchIsLocal(true);

    if (hasConnection) {
      isLoading(true);
      await LocationController.to.getLocationAndAddress();
      if (LocationController.to.acquiredLocation) {
        TimeZoneController.to.initLocalTimezoneString();

        final long = LocationController.to.position.longitude;
        final lat = LocationController.to.position.latitude;
        final data =
            await ApiCaller.to.getWeatherData(long: long!, lat: lat!) ?? {};

        weatherModel = WeatherResponseModel.fromMap(
          map: data as Map<String, dynamic>,
          unitSettings: storage.savedUnitSettings(),
        );

        TimeZoneController.to.getTimeZoneOffset();

        if (Settings.firstTimeUse) {
          Get.offAndToNamed(DrawerAnimator.id);
        }

        _storeAndUpdateData(data: data);

        isLoading(false);
      } else {
        return; // stops the function to prep for a restart if there is a location error
      }
    } else {
      FailureHandler.handleNoConnection(method: 'getWeatherData');
    }
  }

  Future<void> fetchRemoteWeatherData({
    required SearchSuggestion suggestion,
  }) async {
    _updateSearchIsLocal(false);

    final hasConnection = await InternetConnectionChecker().hasConnection;

    if (hasConnection) {
      TabNavigationController.to.tabController.animateTo(0);
      isLoading(true);

      final placeDetails =
          await ApiCaller.to.getPlaceDetailsFromId(placeId: suggestion.placeId);

      await RemoteLocationController.to.initRemoteLocationData(
        dataMap: placeDetails,
        suggestion: suggestion,
      );

      TimeZoneController.to.initRemoteTimezoneString();
      TimeZoneController.to.getTimeZoneOffset();

      final locationModel = RemoteLocationController.to.data;

      final long = locationModel.remoteLong;
      final lat = locationModel.remoteLat;
      final data = await ApiCaller.to.getWeatherData(lat: lat, long: long);

      weatherModel = WeatherResponseModel.fromMap(
        map: data! as Map<String, dynamic>,
        unitSettings: storage.savedUnitSettings(),
      );

      _storeAndUpdateData(data: data);

      RemoteLocationController.to.updateAndStoreSearchHistory(suggestion);

      isLoading(false);
    } else {
      FailureHandler.handleNoConnection(method: 'fetchRemoteWeatherData');
    }
  }

  Future<void> updateUIValues() async {
    CurrentWeatherController.to.initCurrentWeatherValues();
    HourlyForecastController.to.buildHourlyForecastModels();
    DailyForecastController.to.initDailyForecastModels();
  }

  void refreshWeatherData() {
    final bool searchIsLocal = storage.restoreSavedSearchIsLocal();
    if (searchIsLocal) {
      fetchLocalWeatherData();
    } else {
      updateRemoteLocationData();
    }
  }

  void updateModelUnitSettings({required UnitSettings settings}) {
    weatherModel = WeatherResponseModel.updatedUnitSettings(
      model: weatherModel!,
      unitSettings: settings,
    );
  }

  Future<void> updateRemoteLocationData() async {
    final suggestion = storage.restoreLatestSuggestion();
    fetchRemoteWeatherData(suggestion: suggestion);
  }

  void _updateSearchIsLocal(bool value) {
    searchIsLocal = value;
    storage.storeLocalOrRemote(searchIsLocal: searchIsLocal);
  }

  void retryLocalWeatherAfterLocationError() {
    Get.back();
    TabNavigationController.to.tabController.animateTo(0);
    fetchLocalWeatherData();
  }

  void retryWeatherSearchAfterNetworkError() {
    Get.back();
    TabNavigationController.to.tabController.animateTo(0);
    refreshWeatherData();
  }

  void _storeAndUpdateData({
    required Map data,
  }) {
    storage.storeWeatherData(map: data);
    CurrentWeatherController.to.initCurrentTime();
    SunTimeController.to
        .initSunTimeList(weatherModel: WeatherRepository.to.weatherModel!);
    isLoading(false);
    updateUIValues();
    update();
  }

  void _initWeatherDataFromStorage() {
    searchIsLocal = storage.restoreSavedSearchIsLocal();
    if (!storage.firstTimeUse()) {
      weatherModel = WeatherResponseModel.fromMap(
        map: storage.restoreWeatherData(),
        unitSettings: storage.savedUnitSettings(),
      );
    }
  }
}
