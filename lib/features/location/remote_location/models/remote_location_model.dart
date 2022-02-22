import 'package:epic_skies/utils/formatters/address_formatter.dart';
import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

import 'search_suggestion.dart';

@Entity()
class RemoteLocationModel extends Equatable {
  const RemoteLocationModel({
    required this.id,
    required this.remoteLat,
    required this.remoteLong,
    required this.city,
    required this.state,
    required this.country,
    required this.longNameList,
  });

  @Id(assignable: true)
  final int id;
  final String city;
  final String state;
  final String country;

  final double remoteLat;
  final double remoteLong;

  final List<String>? longNameList;

  factory RemoteLocationModel.fromResponse({
    required Map<String, dynamic> map,
    required SearchSuggestion suggestion,
  }) {
    final addressMap =
        (map['result'] as Map<String, dynamic>)['address_components'] as List;
    String country = '';
    String state = '';

    /// The response has varying numbers of fields and country and admin
    /// areas are not guaranteed to be at the same index for different
    /// searches. This loops through and ensures country and state are
    /// always initialized correctly
    for (int i = 1; i < (addressMap.length); i++) {
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
      id: 1,
      remoteLong: locationMap['lng'] as double,
      remoteLat: locationMap['lat'] as double,
      city: searchCity,
      state: AddressFormatter.formatState(country: country, state: state),
      country: country,
      longNameList: AddressFormatter.initStringList(searchCity: searchCity),
    );
  }

  @override
  List<Object?> get props => [
        id,
        remoteLong,
        remoteLat,
        city,
        state,
        longNameList,
      ];
}
