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
      locality: map['locality']! as String,
      administrativeArea: map['adminDistrict']! as String,
      country: map['countryRegion']! as String,
    );

    return LocationModel.fromPlacemark(place: placeMark);
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
