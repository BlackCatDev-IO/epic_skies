import 'package:bloc_test/bloc_test.dart';
import 'package:epic_skies/features/locale/cubit/locale_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/init_hydrated_storage.dart';

void main() async {
  late Locale englishLocale;
  late Locale spanishLocale;
  late Locale frenchLocale;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();

    initHydratedStorage();

    englishLocale = const Locale('en', 'US');
    spanishLocale = const Locale('es', 'ES');
    frenchLocale = const Locale('fr', 'FR');
  });

/* --------------------- updateSearchLocalWeatherButton --------------------- */

  group('LocaleCubit Test:', () {
    blocTest<LocaleCubit, LocaleState>(
      '''
Changes the deviceLocale to the locale passed in
''',
      build: LocaleCubit.new,
      seed: () => LocaleState(deviceLocale: frenchLocale),
      act: (LocaleCubit cubit) async {
        cubit.setDeviceLocale(spanishLocale);
      },
      expect: () {
        return [
          LocaleState(deviceLocale: spanishLocale),
        ];
      },
    );

    blocTest<LocaleCubit, LocaleState>(
      '''
Changes the userSetLocal to the locale passed in with no changes to deviceLocale
''',
      build: LocaleCubit.new,
      seed: () => LocaleState(deviceLocale: englishLocale),
      act: (LocaleCubit cubit) async {
        cubit.setPreferredLocale(spanishLocale);
      },
      expect: () {
        return [
          LocaleState(
            deviceLocale: englishLocale,
            userSetLocale: spanishLocale,
          ),
        ];
      },
    );
  });
}
