import 'package:epic_skies/core/database/file_controller.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/models/adaptive_layout_model.dart';
import 'package:epic_skies/services/asset_controllers/bg_image_controller.dart';
import 'package:epic_skies/services/asset_controllers/image_gallery_controller.dart';
import 'package:epic_skies/view/screens/settings_screens/bg_settings_screen.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../../test_utils.dart';

class _MockBgImageSettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      title: 'Background Image Settings',
      onPressed: () => Get.toNamed(BgImageSettingsScreen.id),
      icon: Icons.add_a_photo,
    );
  }
}

void main() {
  setUp(() {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    WidgetsFlutterBinding.ensureInitialized();
    Get.put(StorageController());
    Get.put(FileController());
    Get.put(BgImageController());
    Get.put(ImageGalleryController());
    const model = AdaptiveLayoutModel(
      appBarPadding: 18,
      appBarHeight: 18.5,
      settingsHeaderHeight: 18,
    );

    StorageController.to.storeAdaptiveLayoutValues(model.toMap());
  });

  group('Bg Image Settings Widget test', () {
    testWidgets('Display Camera and home icon and arrow icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialWidgetTestAncestorWidget(
          child: _MockBgImageSettingsButton(),
        ),
      );

      expect(find.byIcon(Icons.add_a_photo), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('finds "Background Image Settings" text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialWidgetTestAncestorWidget(
          child: _MockBgImageSettingsButton(),
        ),
      );
      expect(find.text('Background Image Settings'), findsOneWidget);
    });

    testWidgets('Navigates to Bg Image Settings Screen on tap',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        FlutterError.onError = ignoreOverflowErrors;

        await tester.pumpWidget(
          MaterialWidgetTestAncestorWidget(
            child: _MockBgImageSettingsButton(),
          ),
        );

        await tester.tap(find.byType(_MockBgImageSettingsButton));
        await tester.pumpAndSettle();

        expect(find.byType(BgImageSettingsScreen), findsOneWidget);
        expect(Get.currentRoute, BgImageSettingsScreen.id);
      });
    });
  });
}
