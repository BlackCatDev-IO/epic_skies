import 'package:epic_skies/models/adaptive_layout_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('model', () {
    test('fromMap', () {
      final layoutMap = {
        'appBarPadding': 80.0,
        'appBarHeight': 75.0,
        'settingsHeaderHeight': 50.0
      };
      final model = AdaptiveLayoutModel.fromMap(layoutMap);

      expect(
        model,
        const AdaptiveLayoutModel(
          appBarPadding: 80.0,
          appBarHeight: 75.0,
          settingsHeaderHeight: 50.0,
        ),
      );
    });

    test('toMap', () {
      const model = AdaptiveLayoutModel(
        appBarPadding: 80.0,
        appBarHeight: 75.0,
        settingsHeaderHeight: 50.0,
      );

      final map = model.toMap();

      expect(map, {
        'appBarPadding': 80.0,
        'appBarHeight': 75.0,
        'settingsHeaderHeight': 50.0
      });
    });
  });
}
