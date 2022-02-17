import 'package:epic_skies/core/database/file_controller.dart';
import 'package:epic_skies/services/asset_controllers/bg_image_controller.dart';
import 'package:epic_skies/services/asset_controllers/image_gallery_controller.dart';
import 'package:epic_skies/services/settings/bg_image_settings/image_settings.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout_controller.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:epic_skies/view/screens/settings_screens/bg_settings_screen.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

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
  late MockStorageController mockStorage;
  late AdaptiveLayoutController adaptiveLayoutController;
  late MockBuildContext context;
  late BgImageController bgImageController;
  late FileController fileController;
  late ColorController colorController;
  late ImageGalleryController imageGalleryController;
  setUp(() async {
    mockStorage = MockStorageController();
    bgImageController = BgImageController(storage: mockStorage);
    fileController = FileController(storage: mockStorage);
    colorController = ColorController();
    imageGalleryController = ImageGalleryController();

    adaptiveLayoutController = AdaptiveLayoutController();
    Get.put(adaptiveLayoutController);
    context = MockBuildContext();

    adaptiveLayoutController.setAdaptiveHeights(
      context: context,
      hasNotch: false,
    );

    when(() => mockStorage.firstTimeUse()).thenReturn(false);
    when(() => mockStorage.restoreDayOrNight()).thenReturn(false);
    when(() => mockStorage.restoreBgImageSettings())
        .thenReturn(ImageSettings.dynamic);

    when(() => mockStorage.restoreBgImageDynamicPath())
        .thenReturn(MockStorageReturns.bgDynamicImagePath);
    when(() => mockStorage.restoreAppDirectory())
        .thenReturn(MockStorageReturns.appDirectoryPath);
    when(() => mockStorage.restoreTimezoneOffset()).thenReturn(4);

    WidgetsFlutterBinding.ensureInitialized();

    Get.put(fileController);
    Get.put(colorController);
    Get.put(bgImageController);
    Get.put(imageGalleryController);
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
