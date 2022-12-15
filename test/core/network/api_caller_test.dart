import 'package:dio/dio.dart';
import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/core/network/api_keys.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../../mocks/mock_api_responses/mock_location_data.dart';

const _tomorrowIoBaseUrl = 'https://data.climacell.co/v4/timelines';

const _fieldList = [
  'temperature',
  'temperatureApparent',
  'humidity',
  'cloudBase',
  'cloudCeiling',
  'cloudCover',
  'windSpeed',
  'windDirection',
  'precipitationProbability',
  'precipitationType',
  'precipitationIntensity',
  'visibility',
  'cloudCover',
  'weatherCode',
  'sunsetTime',
  'sunriseTime'
];

const _timestepList = [
  'current',
  '1h',
  '1d',
];

Future<void> main() async {
  late Dio dio;
  late DioAdapter dioAdapter;
  const lat = 40.8256323;
  const long = -73.9252488;

  setUpAll(() {
    dio = Dio(BaseOptions(baseUrl: _tomorrowIoBaseUrl));
    dioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = dioAdapter;
  });

  group('ApiCaller test', () {
    test('returns Tomorrow.io response as Map', () async {
      final params = {
        'location': '$lat,$long',
        'units': 'imperial',
        'fields': _fieldList,
        'timezone': TimeZoneUtil.timezoneString(lat: lat, long: long),
        'timesteps': _timestepList,
        'apikey': climaCellApiKey,
      };

      final mockResponse = {'data': MockWeatherResponse.bronxWeather};

      dioAdapter.onGet(
        _tomorrowIoBaseUrl,
        (server) => server.reply(200, mockResponse),
        queryParameters: params,
      );

      final apiCaller = ApiCaller(dio);

      final response = await dio.get(
        _tomorrowIoBaseUrl,
        queryParameters: params,
      );

      final responseData = (response.data as Map)['data'] as Map;

      final apiResponse = await apiCaller.getWeatherData(lat: lat, long: long);

      expect(responseData, apiResponse);
      expect(response.statusCode, 200);
    });

    test('returns correctly formmated Map from backup Bing API', () async {
      const bingMapsBaseUrl = 'http://dev.virtualearth.net/REST/v1/Locations/';

      final params = {'key': bingMapsApiKey};

      final mockResponse = MockLocationData.bronxFromBingAPI;

      const url = '$bingMapsBaseUrl$lat,$long';

      dioAdapter.onGet(
        url,
        (server) => server.reply(200, mockResponse),
        queryParameters: params,
      );

      final apiCaller = ApiCaller(dio);

      final response = await dio.get(
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
          'displayName': 'Walton Ave, between E 158th St and E 157th St'
        },
        'locality': 'Concourse Village',
        'postalCode': '10451'
      };

      final apiResponse =
          await apiCaller.getBackupApiDetails(lat: lat, long: long);

      expect(apiResponse, expectedBingBronxReponse);
      expect(response.statusCode, 200);
    });
  });
}
