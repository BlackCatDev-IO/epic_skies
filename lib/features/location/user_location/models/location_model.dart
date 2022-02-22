import 'package:epic_skies/utils/formatters/address_formatter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class LocationModel {
  LocationModel({
    this.id = 0,
    required this.subLocality,
    required this.administrativeArea,
    required this.country,
    required this.longNameList,
  });

  int id;
  final String subLocality;
  final String administrativeArea;
  final String country;
  final List<String>? longNameList;

  factory LocationModel.fromPlacemark({required Placemark place}) {
    final locationMap = {
      'street': place.street!,
      'subLocality': place.subLocality,
      'locality': place.locality,
      'administrativeArea': place.administrativeArea,
      'country': place.country
    };

    return LocationModel(
      subLocality: AddressFormatter.formatLocalSubLocality(
        locationMap: locationMap,
      ),
      administrativeArea: AddressFormatter.formatLocalAdminArea(
        locationMap: locationMap,
      ),
      country: place.country!,
      longNameList:
          AddressFormatter.initStringList(searchCity: place.locality!),
    );
  }

  factory LocationModel.fromStorage({required Map map}) {
    return LocationModel(
      subLocality: map['subLocality'] as String,
      administrativeArea: map['administrativeArea'] as String,
      country: map['country'] as String,
      longNameList: map['longNameList'] == null
          ? null
          : map['longNameList'] as List<String>,
    );
  }

  factory LocationModel.fromBingMaps(Map<String, dynamic> map) {
    final Map<String, String> locationMap = {
      'subLocality': map['adminDistrict2']! as String,
      'locality': map['locality']! as String,
      'administrativeArea': map['adminDistrict']! as String,
      'country': map['countryRegion']! as String,
    };

    final subLocality = AddressFormatter.formatCityFromBingApi(
      formattedAddress: map['formattedAddress'] as String,
    );

    return LocationModel(
      subLocality: subLocality,
      administrativeArea:
          AddressFormatter.formatLocalAdminArea(locationMap: locationMap),
      country: map['countryRegion']! as String,
      longNameList: AddressFormatter.initStringList(
        searchCity: subLocality,
      ),
    );
  }

  factory LocationModel.emptyModel() {
    return LocationModel(
      subLocality: '',
      administrativeArea: '',
      country: '',
      longNameList: null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subLocality': subLocality,
      'administrativeArea': administrativeArea,
      'country': country,
      'longNameList': longNameList
    };
  }

  @override
  String toString() {
    return '''
    subLocality: $subLocality 
    adminArea: $administrativeArea
    country: $country 
    longNameList: $longNameList''';
  }
}
