import 'package:epic_skies/services/view_controllers/adaptive_layout_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../../../test_utils.dart';

void main() {
  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    Get.put(AdaptiveLayoutController());
  });
  group('set and store adaptive screen sizes', () {
    testWidgets('Storing values for phones without notch', (tester) async {
      await tester
          .pumpWidget(MaterialWidgetTestAncestorWidget(child: Container()));
      AdaptiveLayoutController.to
          .setAdaptiveHeights(hasNotch: false, context: Get.context!);
      expect(AdaptiveLayoutController.to.appBarPadding, 19.5);
      expect(AdaptiveLayoutController.to.appBarHeight, 19);
      expect(AdaptiveLayoutController.to.settingsHeaderHeight, 19);
    });

    testWidgets(
        'Set and store values for iPhones with notch under 900 pix height',
        (tester) async {
      binding.window.physicalSizeTestValue = const Size(400, 800);
      binding.window.devicePixelRatioTestValue = 1.0;

      await tester
          .pumpWidget(MaterialWidgetTestAncestorWidget(child: Container()));

      Get.put(AdaptiveLayoutController());

      AdaptiveLayoutController.to
          .setAdaptiveHeights(hasNotch: true, context: Get.context!);
      expect(AdaptiveLayoutController.to.appBarPadding, 21);
      expect(AdaptiveLayoutController.to.appBarHeight, 14.5);
      expect(AdaptiveLayoutController.to.settingsHeaderHeight, 18);
    });

    testWidgets(
        'Set and store values for phones with notch equal or greater than 900 pix height',
        (tester) async {
      binding.window.physicalSizeTestValue = const Size(400, 900);
      binding.window.devicePixelRatioTestValue = 1.0;
      Get.put(AdaptiveLayoutController());

      await tester
          .pumpWidget(MaterialWidgetTestAncestorWidget(child: Container()));

      AdaptiveLayoutController.to
          .setAdaptiveHeights(hasNotch: true, context: Get.context!);

      expect(AdaptiveLayoutController.to.appBarPadding, 19.5);
      expect(AdaptiveLayoutController.to.appBarHeight, 14);
      expect(AdaptiveLayoutController.to.settingsHeaderHeight, 19);
    });
  });
}
