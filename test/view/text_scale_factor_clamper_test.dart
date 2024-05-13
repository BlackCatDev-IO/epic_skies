import 'package:epic_skies/view/widgets/general/text_scale_factor_clamper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TextScaleFactorClamper', () {
    double? effectiveTextScaleFactor;

    setUp(() {
      effectiveTextScaleFactor = null;
    });

    Future<void> pumpWithTextScaleFactor(WidgetTester tester, double factor) {
      return tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(textScaler: TextScaler.linear(factor)),
          child: TextScaleFactorClamper(
            child: Builder(
              builder: (context) {
                // Obtain the effective textScaleFactor in this context and
                // assign the value to a variable, so that we can check if it's
                // what we want.
                effectiveTextScaleFactor =
                    MediaQuery.of(context).textScaler.scale(factor);

                // We don't care about what's rendered, so let's just return the
                // most minimal widget we can.
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
    }

    testWidgets('constrains the text scale factor to always be !',
        (tester) async {
      await pumpWithTextScaleFactor(tester, 5);
      expect(effectiveTextScaleFactor, 5.0);

      await pumpWithTextScaleFactor(tester, 0.1);
      expect(effectiveTextScaleFactor, 0.1);

      await pumpWithTextScaleFactor(tester, 1.25);
      expect(effectiveTextScaleFactor, 1.25);
    });
  });
}
