import 'package:bloc_test/bloc_test.dart';
import 'package:epic_skies/features/settings/unit_settings/bloc/unit_settings_bloc.dart';
import 'package:epic_skies/features/settings/unit_settings/unit_settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  late UnitSettings unitSettings;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();

    unitSettings = const UnitSettings();
  });

  group('UnitSettingsBloc: ', () {
    blocTest(
      '''TempUnitUpdated: emits UnitSettings with toggled tempUnitsMetric setting''',
      build: () => UnitSettingsBloc(
        unitSettings: unitSettings,
      ),
      seed: () => unitSettings,
      act: (UnitSettingsBloc bloc) => bloc.add(TempUnitUpdated()),
      expect: () => [
        unitSettings.copyWith(
          tempUnitsMetric: !unitSettings.tempUnitsMetric,
        ),
      ],
    );

    blocTest(
      '''
TimeIn24HoursUpdated: emits UnitSettings with toggled timeIn24Hrs setting''',
      build: () => UnitSettingsBloc(
        unitSettings: unitSettings,
      ),
      seed: () => unitSettings,
      act: (UnitSettingsBloc bloc) => bloc.add(TimeIn24HoursUpdated()),
      expect: () => [
        unitSettings.copyWith(
          timeIn24Hrs: !unitSettings.timeIn24Hrs,
        ),
      ],
    );

    blocTest(
      '''
PrecipInMmUpdated: emits UnitSettings with toggled precipInMmUpdated setting''',
      build: () => UnitSettingsBloc(
        unitSettings: unitSettings,
      ),
      seed: () => unitSettings,
      act: (UnitSettingsBloc bloc) => bloc.add(PrecipInMmUpdated()),
      expect: () => [
        unitSettings.copyWith(
          precipInMm: !unitSettings.precipInMm,
        ),
      ],
    );

    blocTest(
      '''
SpeedInKphUpdated: emits UnitSettings with toggled speedInKphUpdated setting''',
      build: () => UnitSettingsBloc(
        unitSettings: unitSettings,
      ),
      seed: () => unitSettings,
      act: (UnitSettingsBloc bloc) => bloc.add(SpeedInKphUpdated()),
      expect: () => [
        unitSettings.copyWith(
          speedInKph: !unitSettings.speedInKph,
        ),
      ],
    );
  });
}
