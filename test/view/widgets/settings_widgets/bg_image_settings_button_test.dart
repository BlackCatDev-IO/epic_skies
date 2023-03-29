import 'package:bloc_test/bloc_test.dart';
import 'package:epic_skies/features/bg_image/bloc/bg_image_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/view/screens/settings_screens/bg_settings_screen.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../../mocks/mock_classes.dart';
import '../../../test_utils.dart';

const path = 'bg_image_settings_button_test';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

class MockBgImageBloc extends MockBloc<BgImageEvent, BgImageState>
    implements BgImageBloc {}

final mockObserver = MockNavigatorObserver();

class _MockBgImageSettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>.value(value: mockWeatherBloc),
        BlocProvider<BgImageBloc>(
          create: (context) => MockBgImageBloc(),
        ),
      ],
      child: MaterialWidgetTestAncestorWidget(
        navigatorObserver: mockObserver,
        child: SettingsTile(
          title: 'Background Image Settings',
          onPressed: () =>
              Navigator.of(context).pushNamed(BgImageSettingsScreen.id),
          icon: Icons.add_a_photo,
        ),
      ),
    );
  }
}

late MockWeatherBloc mockWeatherBloc;
late BgImageBloc bgImageBloc;

Future<void> main() async {
  late MockStorageController mockStorage;
  setUp(() async {
    mockStorage = MockStorageController();

    mockWeatherBloc = MockWeatherBloc();

    when(() => mockStorage.isNewInstall()).thenReturn(false);

    when(() => mockWeatherBloc.state)
        .thenReturn(MockWeatherResponse.mockWeatherState());

    WidgetsFlutterBinding.ensureInitialized();
  });

  group('Bg Image Settings Widget test', () {
    testWidgets('Display Camera and home icon and arrow icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _MockBgImageSettingsButton(),
      );

      expect(find.byIcon(Icons.add_a_photo), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('finds "Background Image Settings" text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _MockBgImageSettingsButton(),
      );
      expect(find.text('Background Image Settings'), findsOneWidget);
    });
  });
}
