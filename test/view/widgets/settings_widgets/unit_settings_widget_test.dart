import 'package:epic_skies/services/settings/unit_settings/unit_settings_controller.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/services/view_controllers/view_controllers.dart';
import 'package:epic_skies/view/screens/settings_screens/units_screen.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../../mocks/mock_classes.dart';
import '../../../mocks/mock_storage_return_values.dart';
import '../../../test_utils.dart';

const path = 'unit_settings_widget_test';

class _MockUnitSettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      title: 'Unit Settings',
      onPressed: () => Get.toNamed(UnitsScreen.id),
      icon: Icons.thermostat,
    );
  }
}

Future<void> main() async {
  PathProviderPlatform.instance = FakePathProviderPlatform();

  late MockStorageController mockStorage;
  late MockWeatherRepo mockWeatherRepo;
  late UnitSettings unitSettings;
  late AdaptiveLayoutController adaptiveLayoutController;
  late MockBuildContext context;
  late UnitSettingsController unitSettingsController;
  setUpAll(() async {
    mockStorage = MockStorageController();
    adaptiveLayoutController = AdaptiveLayoutController();
    Get.put(adaptiveLayoutController);
    context = MockBuildContext();

    adaptiveLayoutController.setAdaptiveHeights(
      context: context,
      hasNotch: false,
    );

    unitSettings = UnitSettings(
      id: 1,
      timeIn24Hrs: false,
      speedInKph: false,
      tempUnitsMetric: false,
      precipInMm: false,
    );

    when(() => mockStorage.savedUnitSettings()).thenReturn(unitSettings);

    when(() => mockStorage.firstTimeUse()).thenReturn(false);
    when(() => mockStorage.restoreDayOrNight()).thenReturn(false);

    when(() => mockStorage.restoreBgImageDynamicPath())
        .thenReturn(MockStorageReturns.bgDynamicImagePath);
    when(() => mockStorage.appDirectoryPath)
        .thenReturn(MockStorageReturns.appDirectoryPath);
    when(() => mockStorage.restoreTimezoneOffset()).thenReturn(4);

    WidgetsFlutterBinding.ensureInitialized();

    mockWeatherRepo = MockWeatherRepo(storage: mockStorage);
    WidgetsFlutterBinding.ensureInitialized();
    unitSettingsController =
        UnitSettingsController(weatherRepo: mockWeatherRepo);
    Get.put(unitSettingsController);
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
          MaterialWidgetTestAncestorWidget(
            child: _MockUnitSettingsButton(),
          ),
        );

        await tester.tap(find.byType(_MockUnitSettingsButton));
        await tester.pumpAndSettle();

        expect(find.byType(UnitsScreen), findsOneWidget);
        expect(Get.currentRoute, UnitsScreen.id);
      });
    });
  });
}
