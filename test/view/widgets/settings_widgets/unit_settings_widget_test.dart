import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout.dart';
import 'package:epic_skies/view/screens/settings_screens/units_screen.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

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

  late Storage storage;

  setUpAll(() async {
    storage = MockHydratedStorage();

    HydratedBloc.storage = storage;

    mockWeatherRepo = MockWeatherRepo();
    adaptiveLayout = AdaptiveLayout(hasNotch: false);

    GetIt.instance.registerSingleton<AdaptiveLayout>(
      adaptiveLayout,
    );

    adaptiveLayout.setAdaptiveHeights();
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
