import 'package:epic_skies/features/settings/view/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils.dart';

class _MockContactButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      title: 'Contact',
      onPressed: () {},
      icon: Icons.email,
    );
  }
}

void main() {
  group('Contact Widget test', () {
    testWidgets('Display email icon arrow icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialWidgetTestAncestorWidget(
          child: _MockContactButton(),
        ),
      );

      expect(find.byIcon(Icons.email), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('finds "Contact" text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialWidgetTestAncestorWidget(
          child: _MockContactButton(),
        ),
      );
      expect(find.text('Contact'), findsOneWidget);
    });
  });
}
