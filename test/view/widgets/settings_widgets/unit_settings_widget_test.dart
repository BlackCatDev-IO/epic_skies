import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/settings/view/settings_list_tile.dart';
import 'package:epic_skies/repositories/system_info_repository.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout.dart';
import 'package:epic_skies/view/screens/settings_screens/units_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/init_hydrated_storage.dart';
import '../../../mocks/mock_classes.dart';
import '../../../test_utils.dart';

const path = 'unit_settings_widget_test';

class _MockUnitSettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      title: 'Unit Settings',
      onPressed: () => Navigator.of(context).pushNamed(UnitsScreen.id),
      icon: Icons.thermostat,
    );
  }
}

Future<void> main() async {
  late AdaptiveLayout adaptiveLayout;

  late MockWeatherRepo mockWeatherRepo;

  setUpAll(() async {
    initHydratedStorage();

    getIt.registerSingleton<SystemInfoRepository>(SystemInfoRepository());

    mockWeatherRepo = MockWeatherRepo();
    adaptiveLayout = AdaptiveLayout();

    getIt.registerSingleton<AdaptiveLayout>(
      adaptiveLayout,
    );
  });

  group('Unit Settings Widget test', () {
    testWidgets('Display Thermostat and home icon and arrow icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialWidgetTestAncestorWidget(
          child: _MockUnitSettingsButton(),
        ),
      );

      expect(find.byIcon(Icons.thermostat), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('finds "Unit Settings" text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialWidgetTestAncestorWidget(
          child: _MockUnitSettingsButton(),
        ),
      );
      expect(find.text('Unit Settings'), findsOneWidget);
    });

    testWidgets('Navigates to Unit Settings Screen on tap',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(
              weatherRepository: mockWeatherRepo,
            ),
            child: MaterialWidgetTestAncestorWidget(
              child: _MockUnitSettingsButton(),
            ),
          ),
        );

        await tester.tap(find.byType(_MockUnitSettingsButton));
        await tester.pumpAndSettle();

        expect(find.byType(UnitsScreen), findsOneWidget);
      });
    });
  });
}
