import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/features/forecast_controllers.dart';
import 'package:epic_skies/features/hourly_forecast/models/hourly_forecast_model.dart';
import 'package:epic_skies/features/location/remote_location/controllers/remote_location_controller.dart';
import 'package:epic_skies/features/location/remote_location/models/search_suggestion.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class MockStorageController extends Mock implements StorageController {}

class MockBuildContext extends Mock implements BuildContext {}

class MockWeatherRepo extends Mock implements WeatherRepository {
  @override
  final StorageController storage;

  @override
  WeatherResponseModel? weatherModel;

  @override
  bool searchIsLocal = true;

  MockWeatherRepo({required this.storage});
}

class MockHourlyForecastController extends Mock
    implements HourlyForecastController {
  MockHourlyForecastController({
    required this.weatherRepository,
    required this.currentWeatherController,
  });

  @override
  final WeatherRepository weatherRepository;

  @override
  final CurrentWeatherController currentWeatherController;

  @override
  List<HourlyForecastModel> houryForecastModelList = [];

  @override
  List<List<int>> minAndMaxTempList = [[], [], [], []];

  @override
  Map<String, List> hourlyForecastHorizontalScrollWidgetMap = {
    'next_24_hrs': [],
    'day_1': [],
    'day_2': [],
    'day_3': [],
    'day_4': [],
  };
}

class MockCurrentWeatherController extends Mock
    implements CurrentWeatherController {
  @override
  final WeatherRepository weatherRepository;
  @override
  late DateTime currentTime;

  MockCurrentWeatherController({required this.weatherRepository});
}

class MockApiCaller extends Mock implements ApiCaller {}

class MockRemoteLocationController extends GetxController
    with Mock
    implements RemoteLocationController {
  @override
  final MockStorageController storage;

  @override
  final currentSearchList = <SearchSuggestion>[].obs;

  MockRemoteLocationController({required this.storage});
}
