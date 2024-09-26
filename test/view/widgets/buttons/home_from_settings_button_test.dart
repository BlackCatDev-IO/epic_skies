import 'package:epic_skies/features/settings/view/settings_list_tile.dart';
import 'package:epic_skies/repositories/system_info_repository.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout.dart';
import 'package:epic_skies/view/widgets/buttons/home_from_settings_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/init_hydrated_storage.dart';
import '../../../test_utils.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  final mockObserver = MockNavigatorObserver();

  setUpAll(() async {
    initHydratedStorage();
    getIt
      ..registerSingleton<SystemInfoRepository>(SystemInfoRepository())
      ..registerSingleton<AdaptiveLayout>(AdaptiveLayout());

    final tabController = TabController(
      vsync: const TestVSync(),
      length: 4,
    );

    final tabNav = TabNavigationController(tabController: tabController);

    getIt.registerSingleton<TabNavigationController>(tabNav);
  });

  group('HomeFromSettingsButton test', () {
    testWidgets('Display "Home" and home icon and arrow icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialWidgetTestAncestorWidget(
          navigatorObserver: mockObserver,
          child: const HomeFromSettingsButton(),
        ),
      );

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
  });
}
