import 'package:epic_skies/features/location/user_location/models/location_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';

import '../../../../mocks/mock_api_responses/mock_location_data.dart';

void main() {
  late LocationModel modelFromResponse;
  late Placemark place;
  setUpAll(() async {
    place = MockLocationData.theBronx;

    modelFromResponse = LocationModel.fromPlacemark(
      place: place,
    );
  });

  group('local location model test: ', () {
    test('LocationModel.fromPlacemark initializes as expected', () {
      const regularModel = LocationModel(
        country: 'United States',
        administrativeArea: 'New York',
        subLocality: 'The Bronx',
      );

      expect(regularModel, modelFromResponse);
    });

    test('''
LocationModel.fromMap initializes as expected with blank locality 
  values''', () {
      const regularModel = LocationModel(
        country: 'Colombia',
        administrativeArea: 'Cundinamarca',
        subLocality: 'La Vega',
      );

      final laVega = LocationModel.fromPlacemark(
        place: MockLocationData().missingLocalityResponse,
      );

      expect(regularModel, laVega);
    });

    test('long multi word city name populates longNameList', () {
      final modelFromResponse = LocationModel.fromPlacemark(
        place: MockLocationData().ranchoSantaMargarita,
      );

      final list = ['Rancho', 'Santa', 'Margarita'];

      expect(modelFromResponse.longNameList, list);
    });

    test('emptyModel constructor populates empty model ', () {
      const modelFromResponse = LocationModel();
      const emptyModel = LocationModel();
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

      const regularModel = LocationModel(
        country: 'United States',
        administrativeArea: 'Washington',
        subLocality: 'Overlake',
      );

      expect(regularModel, modelFromResponse);
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
