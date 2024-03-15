import 'package:epic_skies/services/view_controllers/adaptive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils.dart';

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();

  late AdaptiveLayout adaptiveLayout;
  late AdaptiveLayout adaptiveLayoutWithNotch;

  setUpAll(() async {
    adaptiveLayout = AdaptiveLayout();
    adaptiveLayoutWithNotch = AdaptiveLayout();
  });
  group('Set adaptive screen sizes:', () {
    test('Values for phones without notch', () {
      expect(adaptiveLayout.appBarPadding, 19.5);
      expect(adaptiveLayout.appBarHeight, 19);
    });

    testWidgets('Values for iPhones with notch over 897 pix height',
        (tester) async {
      binding.window.physicalSizeTestValue = const Size(400, 900);
      binding.window.devicePixelRatioTestValue = 1.0;

      await tester
          .pumpWidget(MaterialWidgetTestAncestorWidget(child: Container()));

      expect(adaptiveLayoutWithNotch.appBarPadding, 19.5);
      expect(adaptiveLayoutWithNotch.appBarHeight, 14);
      expect(adaptiveLayoutWithNotch.settingsHeaderHeight, 19);
    });

    testWidgets('Values for iPhones with between 870 and 896 pix height',
        (tester) async {
      binding.window.physicalSizeTestValue = const Size(400, 880);
      binding.window.devicePixelRatioTestValue = 1.0;

      await tester
          .pumpWidget(MaterialWidgetTestAncestorWidget(child: Container()));

      expect(adaptiveLayoutWithNotch.appBarHeight, 15);
      expect(adaptiveLayoutWithNotch.appBarPadding, 20.5);
    });

    testWidgets('Values for iPhones with between 800 and 869 pix height',
        (tester) async {
      binding.window.physicalSizeTestValue = const Size(400, 850);
      binding.window.devicePixelRatioTestValue = 1.0;

      await tester
          .pumpWidget(MaterialWidgetTestAncestorWidget(child: Container()));

      expect(adaptiveLayoutWithNotch.appBarHeight, 14.5);
      expect(adaptiveLayoutWithNotch.appBarPadding, 21);
    });

    testWidgets('Values for phones with notch under 800 pix height',
        (tester) async {
      binding.window.physicalSizeTestValue = const Size(400, 750);
      binding.window.devicePixelRatioTestValue = 1.0;

      await tester
          .pumpWidget(MaterialWidgetTestAncestorWidget(child: Container()));

      adaptiveLayoutWithNotch.setAdaptiveHeights();

      expect(adaptiveLayoutWithNotch.appBarHeight, 14);
      expect(adaptiveLayoutWithNotch.appBarPadding, 20.5);
      expect(adaptiveLayoutWithNotch.settingsHeaderHeight, 18);
    });
  });
}
