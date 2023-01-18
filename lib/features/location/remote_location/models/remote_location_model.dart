import 'package:epic_skies/utils/formatters/address_formatter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'search_suggestion.dart';

part 'remote_location_model.freezed.dart';
part 'remote_location_model.g.dart';

@freezed
class RemoteLocationModel with _$RemoteLocationModel {
  const factory RemoteLocationModel({
    required double remoteLat,
    required double remoteLong,
    required String city,
    required String state,
    required String country,
    required List<String>? longNameList,
  }) = _RemoteLocationModel;

  factory RemoteLocationModel.fromJson(Map<String, dynamic> json) =>
      _$RemoteLocationModelFromJson(json);

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
          if (country.toLowerCase() == 'united arab emirates') {
            /// Too long for the screen
            /// TODO: Implement more permanent solution to longer country names
            country = 'U.A.E';
          }
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
      remoteLong: locationMap['lng'] as double,
      remoteLat: locationMap['lat'] as double,
      city: searchCity,
      state: AddressFormatter.formatState(country: country, state: state),
      country: country,
      longNameList: AddressFormatter.initStringList(searchCity: searchCity),
    );
  }

  factory RemoteLocationModel.emptyModel() {
    return const RemoteLocationModel(
      remoteLat: 0.0,
      remoteLong: 0.0,
      city: '',
      state: '',
      country: '',
      longNameList: null,
    );
  }
}
