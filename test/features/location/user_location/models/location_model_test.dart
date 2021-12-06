import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/features/location/user_location/controllers/location_controller.dart';
import 'package:epic_skies/features/location/user_location/models/location_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../../../mocks/mock_api_responses/mock_local_placemark_response.dart';
import '../../../../test_utils.dart';

Future<void> main() async {
  late LocationModel modelFromResponse;
  late Placemark place;
  setUpAll(() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    Get.put(StorageController());
    await StorageController.to.initAllStorage();
    place = MockLocationResponse().theBronx;

    modelFromResponse = LocationModel.fromPlacemark(
      place: place,
    );

    StorageController.to.storeLocalLocationData(map: modelFromResponse.toMap());

    Get.put(LocationController());
  });

  group('local location model test: ', () {
    test('LocationModel.fromMap initializes as expected', () {
      const regularModel = LocationModel(
        street: '811 Walton Ave',
        country: 'United States',
        administrativeArea: 'New York',
        subLocality: 'The Bronx',
        longNameList: null,
      );

      expect(regularModel, modelFromResponse);
    });

    test('LocationModel.fromStorage initializes as expected', () {
      final modelFromStorage = LocationModel.fromStorage(
        map: StorageController.to.restoreLocalLocationData(),
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
        street: '',
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
        street: '3386 156th Ave NE',
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
        'street': '811 Walton Ave',
        'country': 'United States',
        'administrativeArea': 'New York',
        'subLocality': 'The Bronx',
        'longNameList': null,
      };

      expect(responseMap, map);
    });
  });
}
