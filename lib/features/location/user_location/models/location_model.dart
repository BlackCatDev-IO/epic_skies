import 'package:epic_skies/utils/formatters/address_formatter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geocoding/geocoding.dart';

part 'location_model.freezed.dart';
part 'location_model.g.dart';

@freezed
class LocationModel with _$LocationModel {
  const factory LocationModel({
    @Default('') String subLocality,
    @Default('') String administrativeArea,
    @Default('') String country,
    @Default([]) List<String>? longNameList,
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

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

  @override
  String toString() {
    return '''
    subLocality: $subLocality 
    adminArea: $administrativeArea
    country: $country 
    longNameList: $longNameList''';
  }
}
