import 'package:epic_skies/utils/formatters/address_formatter.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';

class LocationModel extends Equatable {
  final String street;
  final String subLocality;
  final String administrativeArea;
  final String country;
  final List? longNameList;

  const LocationModel({
    required this.street,
    required this.subLocality,
    required this.administrativeArea,
    required this.country,
    required this.longNameList,
  });

  factory LocationModel.fromPlacemark({required Placemark place}) {
    final locationMap = {
      'street': place.street!,
      'subLocality': place.subLocality,
      'locality': place.locality,
      'administrativeArea': place.administrativeArea,
      'country': place.country
    };

    return LocationModel(
      street: AddressFormatter.formatLocalStreet(
        locationMap: locationMap,
      ),
      subLocality: AddressFormatter.formatLocalSubLocality(
        locationMap: locationMap,
      ),
      administrativeArea: AddressFormatter.formatLocalAdminArea(
        locationMap: locationMap,
      ),
      country: place.country!,
      longNameList:
          AddressFormatter.initStringList(searchCity: place.subLocality!),
    );
  }

  factory LocationModel.fromStorage({required Map map}) {
    return LocationModel(
      street: map['street'] as String,
      subLocality: map['subLocality'] as String,
      administrativeArea: map['administrativeArea'] as String,
      country: map['country'] as String,
      longNameList:
          map['longNameList'] == null ? null : map['longNameList'] as List,
    );
  }

  factory LocationModel.emptyModel() {
    return const LocationModel(
      street: '',
      subLocality: '',
      administrativeArea: '',
      country: '',
      longNameList: null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'subLocality': subLocality,
      'administrativeArea': administrativeArea,
      'country': country,
      'longNameList': longNameList
    };
  }

  @override
  List<Object?> get props =>
      [street, subLocality, administrativeArea, country, longNameList];
}
