import 'dart:ui';

import 'package:epic_skies/services/database/storage_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/adaptive_layout_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../test_utils.dart';

void main() {
  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized()
          as TestWidgetsFlutterBinding;
  setUpAll(() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    Get.put(StorageController());
    await StorageController.to.initAllStorage();
    Get.put(AdaptiveLayoutController());
  });
  group('set and store adaptive screen sizes', () {
    test('Storing values for phones without notch', () {
      AdaptiveLayoutController.to.setAppBarHeight(hasNotch: false);
      expect(StorageController.to.appBarPadding(), 18.5);
      expect(StorageController.to.appBarHeight(), 18);
      expect(StorageController.to.settingsHeaderHeight(), 18);
    });

    testWidgets(
        'Set and store values for iPhones with notch under 900 pix height',
        (tester) async {
      binding.window.physicalSizeTestValue = const Size(400, 800);
      binding.window.devicePixelRatioTestValue = 1.0;

      await tester
          .pumpWidget(MaterialWidgetTestAncestorWidget(child: Container()));

      AdaptiveLayoutController.to.setAppBarHeight(hasNotch: true);
      expect(StorageController.to.appBarPadding(), 20.5);
      expect(StorageController.to.appBarHeight(), 14);
      expect(StorageController.to.settingsHeaderHeight(), 18);
    });
    testWidgets(
        'Set and store values for phones with notch equal or greater than 900 pix height',
        (tester) async {
      binding.window.physicalSizeTestValue = const Size(400, 900);
      binding.window.devicePixelRatioTestValue = 1.0;

      await tester
          .pumpWidget(MaterialWidgetTestAncestorWidget(child: Container()));

      AdaptiveLayoutController.to.setAppBarHeight(hasNotch: true);
      expect(StorageController.to.appBarPadding(), 19.5);
      expect(StorageController.to.appBarHeight(), 14);
      expect(StorageController.to.settingsHeaderHeight(), 19);
    });
  });
}
