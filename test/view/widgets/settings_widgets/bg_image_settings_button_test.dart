import 'package:epic_skies/core/database/file_controller.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/services/asset_controllers/bg_image_controller.dart';
import 'package:epic_skies/services/asset_controllers/image_gallery_controller.dart';
import 'package:epic_skies/services/settings/bg_image_settings/image_settings.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:epic_skies/view/screens/settings_screens/bg_settings_screen.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../../mocks/mock_classes.dart';
import '../../../mocks/mock_storage_return_values.dart';
import '../../../test_utils.dart';

const path = 'bg_image_settings_button_test';

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

Future<void> main() async {
  PathProviderPlatform.instance = FakePathProviderPlatform();

  late MockStorageController mockStorage;
  late StorageController storage;
  setUp(() async {
    mockStorage = MockStorageController();
    storage = StorageController();
    Get.put(storage);
    // for SettingsHeader that I don't want to pass in a StorageController to
    storage.storeAdaptiveLayoutValues(MockStorageReturns.adaptiveLayoutModel);

    when(() => mockStorage.firstTimeUse()).thenReturn(false);
    when(() => mockStorage.restoreDayOrNight()).thenReturn(false);
    when(() => mockStorage.restoreBgImageSettings())
        .thenReturn(ImageSettings.dynamic);

    when(() => mockStorage.restoreBgImageDynamicPath())
        .thenReturn(MockStorageReturns.bgDynamicImagePath);
    when(() => mockStorage.appDirectoryPath)
        .thenReturn(MockStorageReturns.appDirectoryPath);
    when(() => mockStorage.restoreTimezoneOffset()).thenReturn(4);
    when(() => mockStorage.adaptiveLayoutModel())
        .thenReturn(MockStorageReturns.adaptiveLayoutModel);
    WidgetsFlutterBinding.ensureInitialized();

    Get.put(FileController(storage: mockStorage));
    Get.put(ColorController());
    Get.put(BgImageController(storage: mockStorage));
    Get.put(ImageGalleryController());
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
