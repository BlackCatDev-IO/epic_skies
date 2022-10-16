import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/core/error_handling/failure_handler.dart';
import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/features/forecast_controllers.dart';
import 'package:epic_skies/features/location/remote_location/controllers/remote_location_controller.dart';
import 'package:epic_skies/features/location/remote_location/models/search_suggestion.dart';
import 'package:epic_skies/features/location/user_location/controllers/location_controller.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../services/settings/unit_settings/unit_settings_model.dart';
import '../view/screens/tab_screens/home_tab_view.dart';

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

    if (hasConnection) {
      isLoading(true);
      _updateSearchIsLocal(true);
      await LocationController.to.getLocationAndAddress();
      if (LocationController.to.acquiredLocation) {
        final long = LocationController.to.position.longitude;
        final lat = LocationController.to.position.latitude;

        final data =
            await ApiCaller.to.getWeatherData(long: long!, lat: lat!) ?? {};

        TimeZoneUtil.setTimeZoneOffset(lat: lat, long: long);

        final dataInitModel = WeatherDataInitModel(
          searchIsLocal: searchIsLocal,
          unitSettings: storage.savedUnitSettings(),
        );
        weatherModel = WeatherResponseModel.fromResponse(
          model: dataInitModel,
          response: data,
        );

        if (storage.firstTimeUse()) {
          Get.offAndToNamed(HomeTabView.id);
        }

        _storeAndUpdateData();

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

      final locationModel = RemoteLocationController.to.data;

      final long = locationModel.remoteLong;
      final lat = locationModel.remoteLat;

      final data = await ApiCaller.to.getWeatherData(lat: lat, long: long);

      TimeZoneUtil.setTimeZoneOffset(lat: lat, long: long);

      final dataInitModel = WeatherDataInitModel(
        searchIsLocal: searchIsLocal,
        unitSettings: storage.savedUnitSettings(),
      );

      weatherModel = WeatherResponseModel.fromResponse(
        model: dataInitModel,
        response: data! as Map<String, dynamic>,
      );

      _storeAndUpdateData();

      isLoading(false);
    } else {
      FailureHandler.handleNoConnection(method: 'fetchRemoteWeatherData');
    }
  }

  Future<void> updateUIValues({required bool isRefresh}) async {
    CurrentWeatherController.to.initCurrentWeatherValues(isRefresh: isRefresh);
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
    final dataInitModel = WeatherDataInitModel(
      searchIsLocal: searchIsLocal,
      unitSettings: storage.savedUnitSettings(),
      oldSettings: storage.oldSavedUnitSettings(),
    );

    weatherModel = WeatherResponseModel.updatedUnitSettings(
      model: weatherModel!,
      data: dataInitModel,
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

  void _storeAndUpdateData() {
    storage.storeWeatherData(data: weatherModel!);
    CurrentWeatherController.to.initCurrentTime();
    SunTimeController.to.initSunTimeList(weatherModel: weatherModel!);
    isLoading(false);
    updateUIValues(isRefresh: true);
    update();
  }

  void _initWeatherDataFromStorage() {
    searchIsLocal = storage.restoreSavedSearchIsLocal();
    if (!storage.firstTimeUse()) {
      weatherModel = storage.restoreWeatherData();
    }
  }
}
