import 'package:black_cat_lib/formatting/us_state_formatting/us_states_formatting.dart';
import 'package:epic_skies/services/location/search_controller.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

class AddressFormatter {
  static String formatLocalStreet({
    required Map<String, String?> locationMap,
  }) {
    String street = locationMap['street']!;
    final country = locationMap['country']!;

    switch (country.toLowerCase()) {
      case 'united states':
        if (street.contains('#')) {
          street = _removeUnitNumber(street);
        }
        break;
      case 'colombia':
        street = _formatColombianStreets(street: street);
    }
    return street;
  }

  static String formatLocalSubLocality({
    required Map<String, String?> locationMap,
  }) {
    String subLocality = locationMap['subLocality']!;
    final locality = locationMap['locality']!;
    final country = locationMap['country']!;

    switch (country.toLowerCase()) {
      case 'colombia':
        subLocality = _formatColombianSubLocality(subLocality);
        break;
    }

    /// sublocality variable is what is displayed on screen
    /// this assigns it to locality if sublocality returns empty
    /// and locality has a value. If location is NYC local borough
    /// is displayed in sublocality

    if (!_isNYC(subLocality)) {
      if (subLocality == '' && locality != '') {
        subLocality = locality;
      }
    }

    return _correctedCityFormat(city: subLocality);
  }

  static String formatLocalAdminArea({
    required Map<String, String?> locationMap,
  }) {
    String adminArea = locationMap['administrativeArea']!;
    final country = locationMap['country']!;

    switch (country.toLowerCase()) {
      case 'united states':
        adminArea = USStates.getName(adminArea);
        break;
      case 'colombia':
        adminArea = _formatColombianAdminArea(locationMap);
        break;
    }

    return adminArea;
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

  static String _removeUnitNumber(String street) {
    final splitStreet = street.split(' ');
    final lastIndex = splitStreet.length - 1;

    if (splitStreet[lastIndex].startsWith('#')) {
      splitStreet.removeLast();
      final formattedStreet = StringBuffer();

      for (final unit in splitStreet) {
        formattedStreet.write('$unit ');
      }

      return _rejoinSplit(stringList: splitStreet);
    } else {
      return street;
    }
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
      case 'the bronx':
      case 'bronx':
        return 'The Bronx';
      default:
        return city;
    }
  }

  /// Checks for NYC to ensure local borough is displayed when
  /// user is searching from NYC
  static bool _isNYC(String subLocality) {
    switch (subLocality.toLowerCase()) {
      case 'bronx':
      case 'the bronx':
      case 'manhattan':
      case 'brooklyn':
      case 'queens':
      case 'staten island':
        return true;
      default:
        return false;
    }
  }

/* -------------------------------------------------------------------------- */
/*                         REMOTE LOCATION FORMATTING                         */
/* -------------------------------------------------------------------------- */

  static String formatRemoteCityName({
    required String city,
    SearchSuggestion? suggestion,
  }) {
    if (suggestion != null) {
      final formattedCity =
          _checkForMismatchSuggestionNames(suggestion: suggestion, city: city);
      return _correctedCityFormat(city: formattedCity);
    } else {
      return _correctedCityFormat(city: city);
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
  }

/* -------------------------------------------------------------------------- */
/*                             COLOMBIAN ADDRESSES                            */
/* -------------------------------------------------------------------------- */

  static String _formatColombianStreets({required String street}) {
    String formattedStreet = street;

    if (formattedStreet.contains(' ')) {
      final splitStreet = street.split(' ');

      if (splitStreet[0].toLowerCase().startsWith('cra')) {
        splitStreet[0] = 'Carrera';
      }

      if (splitStreet[2].startsWith('N0')) {
        splitStreet[2] = '#';
      }

      formattedStreet = _rejoinSplit(stringList: splitStreet);
    }

    return formattedStreet;
  }

  static String _formatColombianSubLocality(String subLocality) {
    switch (subLocality.toLowerCase()) {
      case 'bogota':
      case 'bogotá':
        return 'Bogotá';
      default:
        return subLocality;
    }
  }

  static String _formatColombianAdminArea(Map<String, String?> locationMap) {
    final subLocality = locationMap['subLocality']!;
    String administrativeArea = locationMap['administrativeArea']!;

    switch (subLocality.toLowerCase()) {
      case 'bogota':
      case 'bogotá':
        administrativeArea = 'D.C.';

        break;
    }
    return administrativeArea;
  }
}
