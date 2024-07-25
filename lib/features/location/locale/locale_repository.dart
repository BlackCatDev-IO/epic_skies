import 'dart:ui';

import 'package:country_codes/country_codes.dart';

class LocaleRepository {
  Future<void> init() async {
    await CountryCodes.init();
  }

  Locale getLocale() =>
      CountryCodes.getDeviceLocale() ??
      const Locale(
        'en, US',
      );
}
