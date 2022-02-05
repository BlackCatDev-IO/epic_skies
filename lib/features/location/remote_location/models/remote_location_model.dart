import 'package:epic_skies/utils/formatters/address_formatter.dart';
import 'package:equatable/equatable.dart';

import 'search_suggestion.dart';

class RemoteLocationModel extends Equatable {
  final String city;
  final String state;
  final String country;

  final double remoteLat;
  final double remoteLong;

  final List? longNameList;

  const RemoteLocationModel({
    required this.remoteLat,
    required this.remoteLong,
    required this.city,
    required this.state,
    required this.country,
    required this.longNameList,
  });

  factory RemoteLocationModel.fromMap({
    required Map<String, dynamic> map,
    required SearchSuggestion suggestion,
  }) {
    final addressMap = map['result']['address_components'] as List;
    String country = '';
    String state = '';

    /// The response has varying numbers of fields and country and admin
    /// areas are not guaranteed to be at the same index for different
    /// searches. This loops through and ensures country and state are
    /// always initialized correctly
    for (int i = 1; i < (addressMap.length); i++) {
      final locationType = addressMap[i]['types'][0];

      switch (locationType as String) {
        case 'country':
          country = addressMap[i]['long_name'] as String;
          break;
        case 'administrative_area_level_1':
          state = addressMap[i]['long_name'] as String;
          break;
      }
    }

    final searchCity = AddressFormatter.formatRemoteCityName(
      city: addressMap[0]['long_name'] as String,
      suggestion: suggestion,
    );

    return RemoteLocationModel(
      remoteLong: map['result']['geometry']['location']['lng'] as double,
      remoteLat: map['result']['geometry']['location']['lat'] as double,
      city: searchCity,
      state: AddressFormatter.formatState(country: country, state: state),
      country: country,
      longNameList: AddressFormatter.initStringList(searchCity: searchCity),
    );
  }

  factory RemoteLocationModel.fromStorage(Map map) {
    final List? stringList =
        map['longNameList'] == null ? null : map['longNameList'] as List;

    return RemoteLocationModel(
      remoteLong: map['remoteLong'] as double,
      remoteLat: map['remoteLat'] as double,
      city: map['city'] as String,
      state: map['state'] as String,
      country: map['country'] as String,
      longNameList: stringList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'remoteLong': remoteLong,
      'remoteLat': remoteLat,
      'city': city,
      'state': state,
      'country': country,
      'longNameList': longNameList,
    };
  }

  @override
  List<Object?> get props => [
        city,
        state,
        country,
        remoteLat,
        remoteLong,
        longNameList,
      ];
}
