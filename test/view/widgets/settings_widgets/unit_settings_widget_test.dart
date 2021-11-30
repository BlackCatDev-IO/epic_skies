import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/models/adaptive_layout_model.dart';
import 'package:epic_skies/services/settings/unit_settings_controller.dart';
import 'package:epic_skies/view/screens/settings_screens/units_screen.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../../test_utils.dart';

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

void main() {
  setUp(() {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    WidgetsFlutterBinding.ensureInitialized();
    Get.put(StorageController());
    Get.put(UnitSettingsController());
    const model = AdaptiveLayoutModel(
      appBarPadding: 18,
      appBarHeight: 18.5,
      settingsHeaderHeight: 18,
    );

    StorageController.to.storeAdaptiveLayoutValues(model.toMap());
  });

  group('Unit Settings Widget test', () {
    testWidgets('Display Thermostat and home icon and arrow icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialWidgetTestAncestorWidget(
          child: SettingsTile(
            title: 'Unit Settings',
            onPressed: () => Get.toNamed(UnitsScreen.id),
            icon: Icons.thermostat,
          ),
        ),
      );

      expect(find.byIcon(Icons.thermostat), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('finds "Unit Settings" text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialWidgetTestAncestorWidget(
          child: SettingsTile(
            title: 'Unit Settings',
            onPressed: () => Get.toNamed(UnitsScreen.id),
            icon: Icons.thermostat,
          ),
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
