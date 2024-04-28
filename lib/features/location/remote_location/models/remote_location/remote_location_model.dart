// ignore_for_file: sort_constructors_first

import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:epic_skies/features/location/search/models/search_suggestion/search_suggestion.dart';
import 'package:epic_skies/utils/formatters/address_formatter.dart';

part 'remote_location_model.mapper.dart';

@MappableClass()
class RemoteLocationModel with RemoteLocationModelMappable {
  const RemoteLocationModel({
    this.coordinates = const Coordinates(lat: 0, long: 0),
    this.city = '',
    this.state = '',
    this.country = '',
    this.longNameList = const [],
  });

  final Coordinates coordinates;
  final String city;
  final String state;
  final String country;
  final List<String> longNameList;

  factory RemoteLocationModel.fromResponse({
    required Map<String, dynamic> map,
    required SearchSuggestion suggestion,
  }) {
    final addressMap =
        (map['result'] as Map<String, dynamic>)['address_components'] as List;
    var country = '';
    var state = '';

    /// The response has varying numbers of fields and country and admin
    /// areas are not guaranteed to be at the same index for different
    /// searches. This loops through and ensures country and state are
    /// always initialized correctly
    for (var i = 1; i < (addressMap.length); i++) {
      final locationType =
          ((addressMap[i] as Map)['types'] as List)[0] as String;

      switch (locationType) {
        case 'country':
          country = (addressMap[i] as Map)['long_name'] as String;
          break;
        case 'administrative_area_level_1':
          state = (addressMap[i] as Map)['long_name'] as String;
          break;
      }
    }

    final searchCity = AddressFormatter.formatRemoteCityName(
      city: (addressMap[0] as Map)['long_name'] as String,
      suggestion: suggestion,
    );

    final geoMap = (map['result'] as Map<String, dynamic>)['geometry']
        as Map<String, dynamic>;

    final locationMap = geoMap['location'] as Map<String, dynamic>;

    return RemoteLocationModel(
      coordinates: Coordinates(
        lat: locationMap['lat'] as double,
        long: locationMap['lng'] as double,
      ),
      city: searchCity,
      state: AddressFormatter.formatState(country: country, state: state),
      country: country,
      longNameList: AddressFormatter.initStringList(searchCity: searchCity),
    );
  }
}
