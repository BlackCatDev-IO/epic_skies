import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../features/location/remote_location/models/remote_location_model.dart';
import '../services/settings/unit_settings/unit_settings_model.dart';

class WeatherRepository {
  WeatherRepository({
    required StorageController storage,
    required ApiCaller apiCaller,
  })  : _storage = storage,
        _apiCaller = apiCaller;

  final StorageController _storage;

  final ApiCaller _apiCaller;

  Future<WeatherResponseModel?> fetchWeatherData({
    required double lat,
    required double long,
  }) async {
    try {
      final data = await _apiCaller.getWeatherData(long: long, lat: lat);

      TimeZoneUtil.setTimeZoneOffset(lat: lat, long: long);

      if (data != null) {
        final weatherModel = WeatherResponseModel.fromResponse(
          response: data as Map<String, dynamic>,
        );

        final condition = weatherModel.currentCondition!.condition;

        _storage.storeWeatherData(data: weatherModel);

        _storage.storeCurrentLocalCondition(condition: condition);

        return weatherModel;
      }
    } catch (error, stack) {
      _logWeatherRepository('$error, $stack');
      return null;
    }
    return null;
  }

  Future<bool> hasConnection() async =>
      InternetConnectionChecker().hasConnection;

  void storeSearchIsLocal({required bool searchIsLocal}) {
    _storage.storeLocalOrRemote(searchIsLocal: searchIsLocal);
  }

  RemoteLocationModel? restoreRemoteLocationData() {
    return _storage.restoreRemoteLocationData();
  }

  void storeUnitSettings(UnitSettings unitSettings) {
    _storage.updateUnitSettings(settings: unitSettings);
  }

  bool restoreSavedIsDay() => _storage.restoreDayOrNight();

  void _logWeatherRepository(String message) {
    AppDebug.log(message, name: 'WeatherRepository');
  }
}
