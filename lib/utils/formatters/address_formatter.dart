import 'dart:developer';

import 'package:black_cat_lib/formatting/us_state_formatting/us_states_formatting.dart';
import 'package:epic_skies/map_keys/location_map_keys.dart';
import 'package:epic_skies/services/location/search_controller.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

class AddressFormatter {
  static Map<String, dynamic> formatColombianAddresses({
    required Map<String, dynamic> map,
  }) {
    final Map<String, dynamic> formattedMap = map;

    final splitStreet =
        formattedMap[LocationMapKeys.street].split(' ') as List<String>;
    log(splitStreet.toString(), name: 'AddressFormatter');

    if (splitStreet[0].toLowerCase().startsWith('cra')) {
      splitStreet[0] = 'Carrera';
    }

    if (splitStreet[2].startsWith('N0')) {
      splitStreet[2] = '#';
    }

    formattedMap[LocationMapKeys.street] =
        _rejoinSplit(stringList: splitStreet);

    if (formattedMap[LocationMapKeys.localityKey].toLowerCase() == 'bogota' ||
        formattedMap[LocationMapKeys.localityKey].toLowerCase() == 'bogotá') {
      formattedMap[LocationMapKeys.subLocality] = 'Bogotá';
      formattedMap[LocationMapKeys.administrativeArea] = 'D.C.';
    }
    return formattedMap;
  }

  static Map<String, dynamic> removeUnitNumber({
    required Map<String, dynamic> map,
  }) {
    final Map<String, dynamic> formattedMap = map;
    final splitStreet =
        formattedMap[LocationMapKeys.street].split(' ') as List<String>;
    final lastIndex = splitStreet.length - 1;

    if (splitStreet[lastIndex].startsWith('#')) {
      splitStreet.removeLast();
      final formattedStreet = StringBuffer();

      for (final unit in splitStreet) {
        formattedStreet.write('$unit ');
      }

      formattedMap[LocationMapKeys.street] =
          _rejoinSplit(stringList: splitStreet);
    }
    return formattedMap;
  }

  static String _rejoinSplit({required List<String> stringList}) {
    final stringBuffer = StringBuffer();

    for (final unit in stringList) {
      stringBuffer.write('$unit ');
    }
    return stringBuffer.toString().substring(0, stringBuffer.length - 1);
  }

  /// I add stuff to this function as I see it
  static String _correctedCityFormat({required String city}) {
    switch (city.toLowerCase()) {
      case 'newcastle upon tyne':
        return 'Newcastle';

      default:
        return city;
    }
  }

  static String _checkForMismatchSuggestionNames({
    required SearchSuggestion suggestion,
    required String city,
  }) {
    final searchCity = city;
    final splitDescription = suggestion.description.split(' ');

    final List<String> tempList = [];
    for (String string in splitDescription) {
      tempList.add(string);
      if (string.endsWith(',')) {
        string = string.substring(0, string.length - 1);
        tempList.removeLast();
        tempList.add(string);
        break;
      }
    }

    String suggestionCity = _rejoinSplit(stringList: tempList);

    if (suggestionCity.endsWith(',')) {
      suggestionCity = suggestionCity.substring(0, suggestionCity.length - 1);
    }

    if (searchCity != suggestionCity) {
      return suggestionCity;
    } else {
      return city;
    }
    //   _fixOddCityFormatting();

    //   _formatCityName(city: searchCity);
  }

  static List<String>? initStringList({required String searchCity}) {
    late final List<String> stringList = [];
    if (searchCity.length <= 11) {
      return null;
    } else {
      if (searchCity.contains(' ')) {
        final splitCity = searchCity.split(' ');
        for (final word in splitCity) {
          final capWord = word.capitalizeFirst;
          stringList.add(capWord!);
        }
      }
    }
    return stringList;
  }

  static String formatState({
    required String country,
    required String state,
  }) {
    if (country.toLowerCase() == 'united states') {
      return USStates.getAbbreviation(state);
    } else {
      return '';
    }
  }

  static String formatCityName({
    required String city,
    required SearchSuggestion suggestion,
  }) {
    final formattedCity =
        _checkForMismatchSuggestionNames(suggestion: suggestion, city: city);

    return _correctedCityFormat(city: formattedCity);
  }

  // void _formatAmericanAddresses() {
  //   administrativeArea = USStates.getName(administrativeArea);
  //   locationMap![administrativeArea] = administrativeArea;

  //   /// Sometimes apt # is displayed for local searches
  //   /// It is unnecessary and is often the incorrect apt #
  //   /// anyway so this removes it
  //   if (street.contains('#')) {
  //     locationMap = AddressFormatter.removeUnitNumber(map: locationMap!);
  //     _initValuesFromMap();
  //   }
  //   _initLocationMapForStorage();
  //   StorageController.to.storeLocalLocationData(map: locationMap!);
  // }
}
