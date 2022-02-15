import 'package:epic_skies/features/location/user_location/controllers/location_controller.dart';
import 'package:epic_skies/features/location/user_location/models/location_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mock_api_responses/mock_local_placemark_response.dart';
import '../../../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../../../mocks/mock_classes.dart';
import '../../../../mocks/mock_storage_return_values.dart';

void main() {
  late LocationModel modelFromResponse;
  late Placemark place;
  late MockStorageController mockStorage;
  late UnitSettings unitSettings;
  setUpAll(() async {
    unitSettings = UnitSettings(
      id: 1,
      timeIn24Hrs: false,
      speedInKph: false,
      tempUnitsMetric: false,
      precipInMm: false,
    );

    mockStorage = MockStorageController();
    place = MockLocationResponse().theBronx;

    modelFromResponse = LocationModel.fromPlacemark(
      place: place,
    );

    when(() => mockStorage.firstTimeUse()).thenReturn(false);
    when(() => mockStorage.restoreTodayData())
        .thenReturn(MockStorageReturns.todayData);
    when(() => mockStorage.savedUnitSettings()).thenReturn(unitSettings);
    when(() => mockStorage.restoreSavedSearchIsLocal()).thenReturn(true);
    when(() => mockStorage.restoreWeatherData())
        .thenReturn(MockWeatherResponse.bronxWeather);

    when(() => mockStorage.restoreLocalLocationData())
        .thenReturn(MockStorageReturns.bronxLocationData);

    Get.put(LocationController(storage: mockStorage));
  });

  group('local location model test: ', () {
    test('LocationModel.fromMap initializes as expected', () {
      const regularModel = LocationModel(
        country: 'United States',
        administrativeArea: 'New York',
        subLocality: 'The Bronx',
        longNameList: null,
      );

      expect(regularModel, modelFromResponse);
    });

    test('LocationModel.fromStorage initializes as expected', () {
      final modelFromStorage = LocationModel.fromStorage(
        map: mockStorage.restoreLocalLocationData(),
      );

      expect(modelFromStorage, modelFromResponse);
    });

    test('long multi word city name populates longNameList', () {
      final modelFromResponse = LocationModel.fromPlacemark(
        place: MockLocationResponse().ranchoSantaMargarita,
      );

      final list = ['Rancho', 'Santa', 'Margarita'];

      expect(modelFromResponse.longNameList, list);
    });

    test('emptyModel constructor populates empty model ', () {
      final modelFromResponse = LocationModel.emptyModel();
      const emptyModel = LocationModel(
        subLocality: '',
        administrativeArea: '',
        country: '',
        longNameList: null,
      );
      expect(modelFromResponse, emptyModel);
    });

    test('fromBingMaps constructor initializes as expected', () {
      final modelFromResponse =
          LocationModel.fromBingMaps(MockLocationResponse().redmondFromBingAPI);

      const regularModel = LocationModel(
        country: 'United States',
        administrativeArea: 'Washington',
        subLocality: 'Redmond',
        longNameList: null,
      );

      expect(modelFromResponse, regularModel);
    });

    test('toMap constructor returns proper map', () {
      final responseMap = modelFromResponse.toMap();
      final map = {
        'country': 'United States',
        'administrativeArea': 'New York',
        'subLocality': 'The Bronx',
        'longNameList': null,
      };

      expect(responseMap, map);
    });
  });
}
