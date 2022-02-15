import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout_controller.dart';
import 'package:epic_skies/view/screens/settings_screens/about_screen.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../../mocks/mock_classes.dart';
import '../../../test_utils.dart';

class _MockAboutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      title: 'About',
      onPressed: () => Get.toNamed(AboutPage.id),
      icon: Icons.info,
    );
  }
}

void main() {
  late StorageController storage;
  late AdaptiveLayoutController adaptiveLayoutController;
  late MockBuildContext context;
  adaptiveLayoutController = AdaptiveLayoutController();
  Get.put(adaptiveLayoutController);
  context = MockBuildContext();

  adaptiveLayoutController.setAdaptiveHeights(
    context: context,
    hasNotch: false,
  );

  setUpAll(() {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    WidgetsFlutterBinding.ensureInitialized();
    storage = StorageController();
    Get.put(storage);

    storage.storeAppVersion(appVersion: '0.1.1');
  });

  group('About Widget test', () {
    testWidgets('Display info icon and arrow icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialWidgetTestAncestorWidget(
          child: _MockAboutButton(),
        ),
      );

      expect(find.byIcon(Icons.info), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('finds "About" text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialWidgetTestAncestorWidget(
          child: _MockAboutButton(),
        ),
      );
      expect(find.text('About'), findsOneWidget);
    });

    testWidgets('Navigates to About Screen on tap',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialWidgetTestAncestorWidget(
            child: _MockAboutButton(),
          ),
        );

        FlutterError.onError = ignoreOverflowErrors;

        await tester.tap(find.byType(_MockAboutButton));
        await tester.pumpAndSettle();

        expect(find.byType(AboutPage), findsOneWidget);
        expect(Get.currentRoute, AboutPage.id);
      });
    });
  });
}
