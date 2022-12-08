import 'package:epic_skies/features/location/user_location/models/location_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mock_api_responses/mock_location_data.dart';
import '../../../../mocks/mock_classes.dart';

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
    place = MockLocationData.theBronx;

    modelFromResponse = LocationModel.fromPlacemark(
      place: place,
    );

    when(() => mockStorage.savedUnitSettings()).thenReturn(unitSettings);
    when(() => mockStorage.restoreSavedSearchIsLocal()).thenReturn(true);
  });

  group('local location model test: ', () {
    test('LocationModel.fromPlacemark initializes as expected', () {
      final regularModel = LocationModel(
        country: 'United States',
        administrativeArea: 'New York',
        subLocality: 'The Bronx',
        longNameList: null,
      );

      expect(regularModel.id, modelFromResponse.id);
      expect(regularModel.country, modelFromResponse.country);
      expect(
        regularModel.administrativeArea,
        modelFromResponse.administrativeArea,
      );
      expect(regularModel.subLocality, modelFromResponse.subLocality);
      expect(
        regularModel.longNameList,
        modelFromResponse.longNameList,
      );
    });

    test(
        'LocationModel.fromMap initializes as expected with blank locality values',
        () {
      final regularModel = LocationModel(
        country: 'Colombia',
        administrativeArea: 'Cundinamarca',
        subLocality: 'La Vega',
        longNameList: null,
      );

      final laVega = LocationModel.fromPlacemark(
        place: MockLocationData().missingLocalityResponse,
      );

      expect(regularModel.id, laVega.id);
      expect(regularModel.country, laVega.country);
      expect(
        regularModel.administrativeArea,
        laVega.administrativeArea,
      );
      expect(regularModel.subLocality, laVega.subLocality);
      expect(
        regularModel.longNameList,
        laVega.longNameList,
      );
    });

    test('long multi word city name populates longNameList', () {
      final modelFromResponse = LocationModel.fromPlacemark(
        place: MockLocationData().ranchoSantaMargarita,
      );

      final list = ['Rancho', 'Santa', 'Margarita'];

      expect(modelFromResponse.longNameList, list);
    });

    test('emptyModel constructor populates empty model ', () {
      final modelFromResponse = LocationModel.emptyModel();
      final emptyModel = LocationModel(
        subLocality: '',
        administrativeArea: '',
        country: '',
        longNameList: null,
      );
      expect(emptyModel.id, modelFromResponse.id);
      expect(emptyModel.country, modelFromResponse.country);
      expect(
        emptyModel.administrativeArea,
        modelFromResponse.administrativeArea,
      );
      expect(emptyModel.subLocality, modelFromResponse.subLocality);
      expect(
        emptyModel.longNameList,
        modelFromResponse.longNameList,
      );
    });

    test('fromBingMaps constructor initializes as expected', () {
      final modelFromResponse =
          LocationModel.fromBingMaps(MockLocationData().redmondFromBingAPI);

      final regularModel = LocationModel(
        country: 'United States',
        administrativeArea: 'Washington',
        subLocality: 'Overlake',
        longNameList: null,
      );

      expect(regularModel.id, modelFromResponse.id);
      expect(regularModel.country, modelFromResponse.country);
      expect(
        regularModel.administrativeArea,
        modelFromResponse.administrativeArea,
      );
      expect(regularModel.subLocality, modelFromResponse.subLocality);
      expect(
        regularModel.longNameList,
        modelFromResponse.longNameList,
      );
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
