import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/core/error_handling/failure_handler.dart';
import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/features/location/remote_location/controllers/remote_location_controller.dart';
import 'package:epic_skies/features/location/remote_location/models/search_suggestion.dart';
import 'package:epic_skies/features/location/user_location/controllers/location_controller.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../services/settings/unit_settings/unit_settings_model.dart';

class WeatherRepository {
  WeatherRepository({required StorageController storage}) : _storage = storage;

  final StorageController _storage;

  Future<WeatherResponseModel?> fetchLocalWeatherData() async {
    if (!_storage.isTwoDotEightInstalled()) {
      _storage.confirmTwoDotEightInstalled();
    }
    try {
      await LocationController.to.getLocationAndAddress();
      if (LocationController.to.acquiredLocation) {
        final long = LocationController.to.position.longitude;
        final lat = LocationController.to.position.latitude;

        final data =
            await ApiCaller.to.getWeatherData(long: long!, lat: lat!) ?? {};

        TimeZoneUtil.setTimeZoneOffset(lat: lat, long: long);

        final weatherModel = WeatherResponseModel.fromResponse(
          response: data as Map<String, dynamic>,
        );

        final condition = weatherModel.currentCondition!.condition;

        _storage.storeWeatherData(data: weatherModel);
        _storage.storeCurrentLocalCondition(condition: condition);

        return weatherModel;
      } else {
        return null; // stops the function to prep for a restart if there is a location error
      }
    } catch (e) {
      return null;
    }
  }

  Future<WeatherResponseModel?> fetchRemoteWeatherData({
    required SearchSuggestion suggestion,
  }) async {
    final hasConnection = await InternetConnectionChecker().hasConnection;

    if (hasConnection) {
      TabNavigationController.to.tabController.animateTo(0);

      final placeDetails =
          await ApiCaller.to.getPlaceDetailsFromId(placeId: suggestion.placeId);

      await RemoteLocationController.to.initRemoteLocationData(
        dataMap: placeDetails,
        suggestion: suggestion,
      );

      final locationModel = RemoteLocationController.to.data!;

      final long = locationModel.remoteLong;
      final lat = locationModel.remoteLat;

      final data = await ApiCaller.to.getWeatherData(lat: lat, long: long);

      TimeZoneUtil.setTimeZoneOffset(lat: lat, long: long);

      final weatherModel = WeatherResponseModel.fromResponse(
        response: data! as Map<String, dynamic>,
      );

      _storage.storeWeatherData(data: weatherModel);

      return weatherModel;
    } else {
      FailureHandler.handleNoConnection(method: 'fetchRemoteWeatherData');
    }
    return null;
  }

  void refreshWeatherData() {
    final bool searchIsLocal = _storage.restoreSavedSearchIsLocal();
    if (searchIsLocal) {
      fetchLocalWeatherData();
    } else {
      updateRemoteLocationData();
    }
  }

  Future<void> updateRemoteLocationData() async {
    final suggestion = _storage.restoreLatestSuggestion();
    fetchRemoteWeatherData(suggestion: suggestion);
  }

  void storeSearchIsLocal({required bool searchIsLocal}) {
    _storage.storeLocalOrRemote(searchIsLocal: searchIsLocal);
  }

  SearchSuggestion restoreLatestSuggestion() {
    return _storage.restoreLatestSuggestion();
  }

  void storeUnitSettings(UnitSettings unitSettings) {
    _storage.updateUnitSettings(settings: unitSettings);
  }

  bool restoreSavedIsDay() => _storage.restoreDayOrNight();
}
