import 'dart:ui';

import 'package:country_codes/country_codes.dart';

class LocaleRepository {
  Future<void> init() async {
    await CountryCodes.init();
  }

  Future<Locale?> getLocale() async {
    final deviceLocale = CountryCodes.getDeviceLocale();

    return deviceLocale;
  }
}
