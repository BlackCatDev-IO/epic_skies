import 'package:black_cat_lib/extensions/string_extensions.dart';
import 'package:black_cat_lib/formatting/us_state_formatting/us_states_formatting.dart';
import 'package:epic_skies/features/location/remote_location/models/search_suggestion.dart';
import 'package:epic_skies/features/location/remote_location/models/search_text.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

class AddressFormatter {
  static String formatLocalSubLocality({
    required Placemark place,
  }) {
    String subLocality = place.subLocality!;
    final locality = place.locality!;
    final country = place.country!;

    if (subLocality == '' && place.subAdministrativeArea != '') {
      subLocality = place.subAdministrativeArea!;
    }

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
    required Placemark place,
  }) {
    String adminArea = place.administrativeArea!;
    final country = place.country!;

    switch (country.toLowerCase()) {
      case 'united states':
        adminArea = USStates.getName(adminArea);
        break;
      case 'colombia':
        adminArea = _formatColombianAdminArea(place);
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
    final noSpaceOrHyphens =
        !searchCity.contains(' ') && !searchCity.contains('-');

    if (searchCity.length <= 12 || noSpaceOrHyphens) {
      return null;
    } else {
      if (searchCity.contains(' ')) {
        final splitCity = searchCity.split(' ');
        for (final word in splitCity) {
          final capWord = word.capitalizeFirst;
          stringList.add(capWord!);
        }
      } else if (searchCity.contains('-')) {
        if (searchCity.length <= 16) {
          stringList.add(searchCity);
        } else {
          final splitCity = searchCity.split('-');
          for (final word in splitCity) {
            final capWord = word.capitalizeFirst;
            stringList.add(capWord!);
          }
        }
      }
      return stringList;
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

  /// Bing Maps backup API often only returns proper city name in the
  /// 'formattedAddress' field, so this grabs the first word after the
  /// first comma from that field to display as local city name
  static String formatCityFromBingApi({required String formattedAddress}) {
    final splitAddressStringList = formattedAddress.split(',');

    String subLocality = splitAddressStringList[1].trim();

    if (subLocality.toLowerCase() == 'bronx') {
      subLocality = 'The Bronx';
    }

    return subLocality;
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
/*                        SEARCH SUGGESTION FORMATTING                        */
/* -------------------------------------------------------------------------- */

  static List<SearchText> getSearchText({
    required String suggestion,
    required String query,
  }) {
    return query.hasNumber
        ? _getRegionSearchText(suggestion: suggestion, query: query)
        : _getCitySearchText(suggestion: suggestion, query: query);
  }

  static List<SearchText> _getCitySearchText({
    required String suggestion,
    required String query,
  }) {
    String boldText = '';
    String regularText = '';

    for (int i = 0; i < query.length; i++) {
      final queryLengthChunkOfSuggestion =
          suggestion.replaceRange(query.length, suggestion.length, '');

      final queryMatchesFirstPortionOfSuggestion =
          query.toLowerCase() == queryLengthChunkOfSuggestion.toLowerCase();

      if (queryMatchesFirstPortionOfSuggestion) {
        boldText = queryLengthChunkOfSuggestion;

        //       if (charIsPartOfQuery && noWhiteSpace) {
        // boldText += char;
        regularText = suggestion.replaceRange(0, query.length, '');
      } else {
        regularText = suggestion;
      }
    }

    return [
      SearchText(text: boldText, isBold: true),
      SearchText(text: regularText, isBold: false)
    ];
  }

  static List<SearchText> _getRegionSearchText({
    required String suggestion,
    required String query,
  }) {
    final searchTextList = <SearchText>[];
    final postalCodeStringList = <String>[];
    final boldIndexList = <int>[];

    final stringList = suggestion.split(' ');

    for (int i = 0; i < stringList.length; i++) {
      final place = stringList[i];
      if (place.hasNumber) {
        postalCodeStringList.add(place);
        boldIndexList.add(i);
      } else {
        searchTextList.add(SearchText(text: '$place ', isBold: false));
      }
    }

    final postalCode = '${postalCodeStringList.join(' ')} ';

    final paramMap = _searchListParams(postalCode: postalCode, query: query);

    final boldSearchText =
        SearchText(text: paramMap['boldText'] as String, isBold: true);
    final regSearchText =
        SearchText(text: paramMap['regText'] as String, isBold: false);

    final postalCodeIndex = boldIndexList[0];

    if (paramMap['firstIndexIsBold'] as bool) {
      searchTextList.insert(postalCodeIndex, boldSearchText);
      searchTextList.insert(postalCodeIndex + 1, regSearchText);
    } else {
      searchTextList.insert(postalCodeIndex, regSearchText);
      searchTextList.insert(postalCodeIndex + 1, boldSearchText);
    }

    return _mergedNonBoldSearchText(
      searchTextList: searchTextList,
      boldIndex: postalCodeIndex,
    );
  }

  static Map<String, dynamic> _searchListParams({
    required String postalCode,
    required String query,
  }) {
    String condensedPostalCode = postalCode;
    String regText = '';
    String boldText = '';
    String condensedQuery = query;
    bool firstIndexIsBold = false;
    bool postalCodeHasSpace = false;

    if (postalCode.trim().contains(' ')) {
      postalCodeHasSpace = true;
      condensedPostalCode = postalCode.replaceAll(' ', '');
    }

    if (query.contains(' ')) {
      condensedQuery = query.replaceAll(' ', '');
    }

    for (int i = 0; i < condensedPostalCode.length; i++) {
      String queryChar = '';
      final postalCodeChar = condensedPostalCode[i].toLowerCase();

      if (i < condensedQuery.length) {
        queryChar = condensedQuery[i].toLowerCase();
        if (queryChar == postalCodeChar) {
          boldText += queryChar.toUpperCase();
          if (i == 0) {
            firstIndexIsBold = true;
          }
        }
      } else {
        queryChar = condensedPostalCode[i];
        regText += queryChar.toUpperCase();
      }
    }

    if (postalCodeHasSpace) {
      final textMap =
          _insertSpace(postalCode: postalCode, bold: boldText, reg: regText);
      boldText = textMap['bold']!;
      regText = textMap['reg']!;
    }

    return {
      'regText': regText,
      'boldText': boldText,
      'firstIndexIsBold': firstIndexIsBold
    };
  }

  static Map<String, String> _insertSpace({
    required String postalCode,
    required String bold,
    required String reg,
  }) {
    final indexOfSpace = postalCode.indexOf(' ');

    String boldText = bold;
    String regText = reg;

    if (bold.length == indexOfSpace) {
      boldText += ' ';
    } else if (bold.length < indexOfSpace) {
      regText = postalCode.substring(indexOfSpace - 1, postalCode.length - 1);
    } else {
      boldText = postalCode.substring(0, bold.length + 1);
    }

    return {
      'bold': boldText,
      'reg': regText,
    };
  }

  static List<SearchText> _mergedNonBoldSearchText({
    required List<SearchText> searchTextList,
    required int boldIndex,
  }) {
    final mergedList = <SearchText>[];
    final boldText = searchTextList[boldIndex];
    final regTextListBeforeBold = <String>[];
    final regTextListAfterBold = <String>[];

    for (int i = 0; i < searchTextList.length; i++) {
      final text = searchTextList[i].text;
      if (i < boldIndex) {
        regTextListBeforeBold.add(text);
      }

      if (i > boldIndex) {
        regTextListAfterBold.add(text);
      }
    }

    if (regTextListBeforeBold.isNotEmpty) {
      mergedList.add(
        SearchText(text: regTextListBeforeBold.join(' '), isBold: false),
      );
      mergedList.add(boldText);
    }

    if (regTextListAfterBold.isNotEmpty && mergedList.isNotEmpty) {
      mergedList
          .add(SearchText(text: regTextListAfterBold.join(' '), isBold: false));
    }

    if (regTextListAfterBold.isNotEmpty && mergedList.isEmpty) {
      mergedList.add(boldText);
      mergedList
          .add(SearchText(text: regTextListAfterBold.join(' '), isBold: false));
    }
    return mergedList;
  }

  /// Sometimes the search suggestions can have imperfect formatting
  /// Anything I notice I add to this function
  static String checkForOddSuggestionFormatting(String description) {
    switch (description.toLowerCase()) {
      case 'bogotá, bogota, colombia':
        return 'Bogotá, Colombia';
      case 'sydney nsw, australia':
        return 'Sydney, NSW, Australia';
      case 'serang, serang city, banten, indonesia':
        return 'Serang, Indonesia';

      default:
        return _formatReturnedSuggestion(description);
    }
  }

  static String _formatReturnedSuggestion(String suggestion) {
    if (suggestion.length < 42) {
      return suggestion;
    }

    final splitString = suggestion.split(' ');

    // final country = splitString[splitString.length - 1].toLowerCase();

    if (suggestion.hasNumber) {
      final indexesToBeRemovedFromResponse = splitString.length - 5;
      splitString.removeRange(0, indexesToBeRemovedFromResponse);
    } else {
      splitString.removeRange(1, splitString.length - 1);
    }

    return splitString.join(' ');
  }

/* -------------------------------------------------------------------------- */
/*                             COLOMBIAN ADDRESSES                            */
/* -------------------------------------------------------------------------- */

  static String _formatColombianSubLocality(String subLocality) {
    switch (subLocality.toLowerCase()) {
      case 'bogota':
      case 'bogotá':
        return 'Bogotá';
      default:
        return subLocality;
    }
  }

  static String _formatColombianAdminArea(Placemark place) {
    final subLocality = place.subLocality!;
    String administrativeArea = place.administrativeArea!;

    switch (subLocality.toLowerCase()) {
      case 'bogota':
      case 'bogotá':
        administrativeArea = 'D.C.';

        break;
    }
    return administrativeArea;
  }
}
