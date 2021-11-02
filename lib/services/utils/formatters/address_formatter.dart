import 'dart:developer';

import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/map_keys/location_map_keys.dart';

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
        rejoinSplit(stringList: splitStreet);

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
          rejoinSplit(stringList: splitStreet);
    }
    return formattedMap;
  }

  static String rejoinSplit({required List<String> stringList}) {
    final stringBuffer = StringBuffer();

    for (final unit in stringList) {
      stringBuffer.write('$unit ');
    }
    return stringBuffer.toString().substring(0, stringBuffer.length - 1);
  }
}
