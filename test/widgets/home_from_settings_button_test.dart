import 'package:epic_skies/services/ticker_controllers/drawer_animation_controller.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/view/widgets/buttons/home_from_settings_button.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../test_utils.dart';

void main() {
  setUp(() {
    Get.put(DrawerAnimationController());
    Get.put(TabNavigationController());
  });

  group('HomeFromSettingsButton test', () {
    testWidgets('Display "Home" and home icon and arrow icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialWidgetTestAncestorWidget(
          child: HomeFromSettingsButton(),
        ),
      );
      expect(find.text('Home'), findsOneWidget);

      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('finds "Home" text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialWidgetTestAncestorWidget(
          child: HomeFromSettingsButton(),
        ),
      );
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('finds SettingsTile', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialWidgetTestAncestorWidget(
          child: HomeFromSettingsButton(),
        ),
      );
      final tile = find.byType(SettingsTile);
      expect(tile, findsOneWidget);
    });

    testWidgets('Navigates to Home Screen on tap', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialWidgetTestAncestorWidget(
          child: HomeFromSettingsButton(),
        ),
      );

      await tester.runAsync(() async {
        await tester.pumpWidget(
          const MaterialWidgetTestAncestorWidget(
            child: HomeFromSettingsButton(),
          ),
        );

        await tester.tap(find.byType(HomeFromSettingsButton));
        final tile = find.byType(SettingsTile);
        expect(tile, findsOneWidget);

        /// verifying home tab
        expect(TabNavigationController.to.tabController.index, 0);

        /// verify animation controller reversed to 0.0
        expect(DrawerAnimationController.to.animationController.value, 0.0);
      });
    });
  });
}
