import 'package:epic_skies/features/location/search/models/search_suggestion/search_suggestion.dart';
import 'package:epic_skies/utils/formatters/address_formatter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_location_model.freezed.dart';
part 'remote_location_model.g.dart';

@freezed
class RemoteLocationModel with _$RemoteLocationModel {
  const factory RemoteLocationModel({
    @Default(0.0) double remoteLat,
    @Default(0.0) double remoteLong,
    @Default('') String city,
    @Default('') String state,
    @Default('') String country,
    @Default(null) List<String>? longNameList,
  }) = _RemoteLocationModel;

  factory RemoteLocationModel.fromJson(Map<String, dynamic> json) =>
      _$RemoteLocationModelFromJson(json);

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
      remoteLong: locationMap['lng'] as double,
      remoteLat: locationMap['lat'] as double,
      city: searchCity,
      state: AddressFormatter.formatState(country: country, state: state),
      country: country,
      longNameList: AddressFormatter.initStringList(searchCity: searchCity),
    );
  }
}
