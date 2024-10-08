import 'package:dio/dio.dart';
import 'package:epic_skies/core/network/api_service.dart';
import 'package:epic_skies/env/env.dart';
import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../../mocks/mock_api_responses/mock_location_data.dart';
import '../../mocks/visual_crossing_mock.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Dio dio;
  late DioAdapter dioAdapter;
  const lat = 40.8256323;
  const long = -73.9252488;
  late String url;

  setUpAll(() async {
    const location = '$lat,$long';

    url = '${Env.weatherBaseUrl}$location';
    dio = Dio(BaseOptions(baseUrl: url));
    dioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = dioAdapter;
  });

  group('ApiService test', () {
    test('returns Visual Crossing response as Map', () async {
      final params = {
        'contentType': 'json',
        'unitGroup': 'metric',
        'key': Env.weatherApiKey,
      };

      const mockResponse = nycVisualCrossingResponse;

      dioAdapter.onGet(
        url,
        queryParameters: params,
        (server) => server.reply(200, mockResponse),
      );

      final apiService = ApiService(dio);

      final response = await dio.get<dynamic>(
        url,
        queryParameters: params,
      );

      final responseData = response.data! as Map;

      final apiResponse = await apiService.getWeatherData(
        coordinates: const Coordinates(lat: lat, long: long),
      );

      expect(responseData, apiResponse);
      expect(response.statusCode, 200);
    });

    test('returns correctly formmated Map from backup Bing API', () async {
      const bingMapsBaseUrl = 'http://dev.virtualearth.net/REST/v1/Locations/';

      final params = {'key': Env.bingMapsBackupKey};

      final mockResponse = MockLocationData.bronxFromBingAPI;

      const url = '$bingMapsBaseUrl$lat,$long';

      dioAdapter.onGet(
        url,
        (server) => server.reply(200, mockResponse),
        queryParameters: params,
      );

      final apiService = ApiService(dio);

      final response = await dio.get<dynamic>(
        url,
        queryParameters: params,
      );

      const expectedBingBronxReponse = {
        'addressLine': '811 Walton Ave',
        'adminDistrict': 'NY',
        'adminDistrict2': 'Bronx Co.',
        'countryRegion': 'United States',
        'formattedAddress': '811 Walton Ave, Bronx, NY 10451, United States',
        'intersection': {
          'baseStreet': 'Walton Ave',
          'secondaryStreet1': 'E 158th St',
          'secondaryStreet2': 'E 157th St',
          'intersectionType': 'Between',
          'displayName': 'Walton Ave, between E 158th St and E 157th St',
        },
        'locality': 'Concourse Village',
        'postalCode': '10451',
      };

      final apiResponse =
          await apiService.getBackupApiDetails(lat: lat, long: long);

      expect(apiResponse, expectedBingBronxReponse);
      expect(response.statusCode, 200);
    });
  });
}
