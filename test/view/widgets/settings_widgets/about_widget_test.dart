import 'package:epic_skies/services/app_updates/update_controller.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout_controller.dart';
import 'package:epic_skies/view/screens/settings_screens/about_screen.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

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
  late MockStorageController mockStorage;
  late AdaptiveLayoutController adaptiveLayoutController;
  late UpdateController updateController;

  setUpAll(() {
    mockStorage = MockStorageController();
    updateController = UpdateController(mockStorage);
    Get.put(updateController);
    adaptiveLayoutController =
        AdaptiveLayoutController(storage: mockStorage, hasNotch: false);
    Get.put(adaptiveLayoutController);

    adaptiveLayoutController.setAdaptiveHeights();

    updateController.currentAppVersion = '0.1.1';
  });

  tearDownAll(() async {
    await Future.wait([
      Get.delete<UpdateController>(),
      Get.delete<AdaptiveLayoutController>(),
    ]);
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
