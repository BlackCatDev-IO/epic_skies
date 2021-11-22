import 'package:geocoding/geocoding.dart';

class MockLocationResponse {
  final bogotaLat = 4.692925453972034;
  final bogotaLong = -74.06160475376642;

  final rsmLat = 33.646510177241666;
  final rsmLong = -117.59434532284129;

  final bronxLat = 40.82570513146224;
  final bronxLong = -73.92530621572722;

  final theBronx = Placemark(
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

  final redmondFromBingAPI = {
    'addressLine': '3386 156th Ave NE',
    'adminDistrict': 'WA',
    'adminDistrict2': 'King Co.',
    'countryRegion': 'United States',
    'formattedAddress': '3386 156th Ave NE, Redmond, WA 98052, United States',
    'locality': 'Overlake',
    'postalCode': '98052'
  };
}
