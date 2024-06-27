import 'dart:ui';

import 'package:country_codes/country_codes.dart';

class LocaleRepository {
  Future<void> init() async {
    await CountryCodes.init();
  }

  Locale getLocale() {
    final deviceLocale =
        CountryCodes.getDeviceLocale() ?? const Locale('en, US');

    return deviceLocale;
  }
}
