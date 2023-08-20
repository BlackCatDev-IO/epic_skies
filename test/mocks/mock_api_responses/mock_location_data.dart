// ignore_for_file: lines_longer_than_80_chars

import 'package:epic_skies/features/location/user_location/models/location_model.dart';
import 'package:geocoding/geocoding.dart';

class MockLocationData {
  final bogotaLat = 4.692925453972034;
  final bogotaLong = -74.06160475376642;

  final rsmLat = 33.646510177241666;
  final rsmLong = -117.59434532284129;

  final bronxLat = 40.82570513146224;
  final bronxLong = -73.92530621572722;

  final ouagaLat = 12.377056614634617;
  final ouagaLong = -1.5218641977422087;

  static final bronxLocation = LocationModel.fromPlacemark(place: theBronx);

  static final theBronx = Placemark(
    administrativeArea: 'New York',
    country: 'United States',
    isoCountryCode: 'US',
    locality: '',
    name: '811',
    postalCode: '',
    street: '811 Walton Ave',
    subAdministrativeArea: 'Bronx County',
    subLocality: 'Bronx',
    subThoroughfare: '811',
    thoroughfare: 'Walton Avenue',
  );

  final bogota = Placemark(
    name: '103b81',
    street: 'Cra. 51 #103b81',
    isoCountryCode: 'CO',
    country: 'Colombia',
    postalCode: '111111',
    administrativeArea: 'Bogotá',
    subAdministrativeArea: '',
    locality: 'Bogotá',
    subLocality: 'Suba',
    thoroughfare: 'Carrera 51',
    subThoroughfare: '103b81',
  );

  final ranchoSantaMargarita = Placemark(
    name: '19',
    street: '19 Salvia',
    isoCountryCode: 'US',
    country: 'United States',
    postalCode: '92688',
    administrativeArea: 'California',
    subAdministrativeArea: 'Orange County',
    locality: 'Rancho Santa Margarita',
    subLocality: ' ',
    thoroughfare: 'Salvia',
    subThoroughfare: '19',
  );

  final missingLocalityResponse = Placemark(
    name: 'La Vega',
    street: 'Kilómetro 4.3via laguna el tabacal',
    isoCountryCode: 'CO',
    country: 'Colombia',
    postalCode: '253617',
    administrativeArea: 'Cundinamarca',
    subAdministrativeArea: 'La Vega',
    locality: '',
    subLocality: '',
    thoroughfare: '',
    subThoroughfare: '',
  );

  final redmondFromBingAPI = {
    'addressLine': '3386 156th Ave NE',
    'adminDistrict': 'WA',
    'adminDistrict2': 'King Co.',
    'countryRegion': 'United States',
    'formattedAddress': '3386 156th Ave NE, Redmond, WA 98052, United States',
    'locality': 'Overlake',
    'postalCode': '98052',
  };

  static final bronxFromBingAPI = {
    'authenticationResultCode': 'ValidCredentials',
    'brandLogoUri': 'http://dev.virtualearth.net/Branding/logo_powered_by.png',
    'copyright':
        'Copyright © 2022 Microsoft and its suppliers. All rights reserved. This API cannot be accessed and the content and any results may not be used, reproduced or transmitted in any manner without express written permission from Microsoft Corporation.',
    'resourceSets': [
      {
        'estimatedTotal': 1,
        'resources': [
          {
            '__type':
                'Location:http://schemas.microsoft.com/search/local/ws/rest/v1',
            'bbox': [
              40.821715282429324,
              -73.932405825066127,
              40.829440717570677,
              -73.918794174933879,
            ],
            'name': '811 Walton Ave, Bronx, NY 10451, United States',
            'point': {
              'type': 'Point',
              'coordinates': [40.825578, -73.9256],
            },
            'address': {
              'addressLine': '811 Walton Ave',
              'adminDistrict': 'NY',
              'adminDistrict2': 'Bronx Co.',
              'countryRegion': 'United States',
              'formattedAddress':
                  '811 Walton Ave, Bronx, NY 10451, United States',
              'intersection': {
                'baseStreet': 'Walton Ave',
                'secondaryStreet1': 'E 158th St',
                'secondaryStreet2': 'E 157th St',
                'intersectionType': 'Between',
                'displayName': 'Walton Ave, between E 158th St and E 157th St',
              },
              'locality': 'Concourse Village',
              'postalCode': '10451',
            },
            'confidence': 'High',
            'entityType': 'Address',
            'geocodePoints': [
              {
                'type': 'Point',
                'coordinates': [40.825578, -73.9256],
                'calculationMethod': 'Parcel',
                'usageTypes': ['Display'],
              }
            ],
            'matchCodes': ['Good'],
          }
        ],
      }
    ],
    'statusCode': 200,
    'statusDescription': 'OK',
    'traceId':
        'dee1dcd76a87460d88bd04de22e1f7ca|BN00005049|0.0.0.1|BN01EAP000009A3',
  };

  static final predictionsZInput = {
    'predictions': [
      {
        'description': 'Zürich, Switzerland',
        'place_id': 'ChIJGaK-SZcLkEcRA9wf5_GNbuY',
      },
      {
        'description': 'Zakopane, Poland',
        'place_id': 'ChIJOTnvlJLyFUcRoKZrcaGHjd8',
      },
    ],
    'status': 'OK',
  };
}
