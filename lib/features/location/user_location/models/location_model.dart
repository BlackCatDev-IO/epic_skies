// ignore_for_file: sort_constructors_first

import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/utils/formatters/address_formatter.dart';
import 'package:geocoding/geocoding.dart';

part 'location_model.mapper.dart';

@MappableClass()
class LocationModel with LocationModelMappable {
  const LocationModel({
    this.subLocality = '',
    this.administrativeArea = '',
    this.country = '',
    this.longNameList = const [],
  });

  final String subLocality;
  final String administrativeArea;
  final String country;
  final List<String> longNameList;

  factory LocationModel.fromPlacemark({required Placemark place}) {
    final subLocality = AddressFormatter.formatLocalSubLocality(place: place);
    return LocationModel(
      subLocality: subLocality,
      administrativeArea: AddressFormatter.formatLocalAdminArea(
        place: place,
      ),
      country: place.country!,
      longNameList: AddressFormatter.initStringList(searchCity: subLocality),
    );
  }

  factory LocationModel.fromBingMaps(Map<String, dynamic> map) {
    final subLocality = AddressFormatter.formatCityFromBingApi(
      formattedAddress: map['formattedAddress'] as String,
    );

    final placeMark = Placemark(
      subLocality: subLocality,
      locality: map['locality'] as String? ?? '',
      administrativeArea: map['adminDistrict'] as String? ?? '',
      country: map['countryRegion'] as String? ?? '',
    );

    return LocationModel.fromPlacemark(place: placeMark);
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
