import 'package:epic_skies/features/settings/view/settings_list_tile.dart';
import 'package:epic_skies/view/screens/settings_screens/about_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils.dart';

class _MockAboutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      title: 'About',
      onPressed: () => Navigator.of(context).pushNamed(AboutPage.id),
      icon: Icons.info,
    );
  }
}

void main() {
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
      });
    });
  });
}
