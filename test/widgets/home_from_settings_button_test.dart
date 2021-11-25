import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/view/widgets/general/buttons/home_from_settings_button.dart';
import 'package:epic_skies/view/widgets/general/settings_widgets/settings_list_tile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../test_utils.dart';

void main() {
  setUp(() {
    Get.put(ViewController());
  });
  testWidgets('HomeFromSettingsButton', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialWidgetTestAncestorWidget(
        child: HomeFromSettingsButton(),
      ),
    );
    final tile = find.byType(SettingsTile);
    expect(tile, findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    await tester.tap(tile);

    /// verifying home tab
    expect(ViewController.to.tabController.index, 0);

    /// verify animation controller reversed to 0.0
    expect(ViewController.to.animationController.value, 0.0);
  });
}
