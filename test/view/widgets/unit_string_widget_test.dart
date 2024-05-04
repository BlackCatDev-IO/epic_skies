import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/view/widgets/weather_info_display/unit_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../features/main_weather/mock_weather_state.dart';
import '../../mocks/init_hydrated_storage.dart';
import '../../mocks/mock_classes.dart';
import '../../mocks/visual_crossing_mock.dart';
import '../../test_utils.dart';

const fahrenheight = 'F';
const celcius = 'C';
const mph = 'mph';
const kph = 'kph';
const inches = 'in';
const millimeters = 'mm';

class _MockSearchLocalWeatherButton extends StatelessWidget {
  const _MockSearchLocalWeatherButton({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorCubit>(
          create: (context) => ColorCubit(),
        ),
      ],
      child: MaterialWidgetTestAncestorWidget(
        child: child,
      ),
    );
  }
}

void main() {
  late UnitSettings metricUnitSettings;
  late MockWeatherRepo mockWeatherRepo;
  late WeatherResponseModel weatherModel;
  late Coordinates coordinates;
  late WeatherBloc mockWeatherBloc;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();

    initHydratedStorage();

    mockWeatherBloc = MockWeatherBloc();

    coordinates = const Coordinates(lat: 0, long: 0);

    metricUnitSettings = const UnitSettings(
      speedInKph: true,
      tempUnitsMetric: true,
      precipInMm: true,
    );

    mockWeatherRepo = MockWeatherRepo();

    weatherModel = WeatherResponseModel.fromResponse(
      response: nycVisualCrossingResponse,
    );

    when(
      () => mockWeatherRepo.getVisualCrossingData(
        coordinates: coordinates,
      ),
    ).thenAnswer((_) async {
      return weatherModel;
    });

    when(() => mockWeatherBloc.state).thenReturn(
      mockVisualCrossingState(),
    );
  });

  group('TempUnitWidget test:', () {
    testWidgets('''Displays displays 'F' when unit settings are fahrenheight''',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<WeatherBloc>.value(
              value: mockWeatherBloc,
            ),
          ],
          child: const _MockSearchLocalWeatherButton(
            child: TempUnitWidget(
              textStyle: TextStyle(),
            ),
          ),
        ),
      );

      expect(find.text(fahrenheight), findsOneWidget);
    });

    testWidgets('''Displays displays 'C' when unit settings are celcius''',
        (WidgetTester tester) async {
      when(() => mockWeatherBloc.state).thenReturn(
        mockVisualCrossingState().copyWith(unitSettings: metricUnitSettings),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<WeatherBloc>.value(
              value: mockWeatherBloc,
            ),
          ],
          child: const _MockSearchLocalWeatherButton(
            child: TempUnitWidget(
              textStyle: TextStyle(),
            ),
          ),
        ),
      );

      expect(find.text(celcius), findsOneWidget);
    });
  });

  group('SpeedUnitWidget test:', () {
    testWidgets('''Displays displays 'mph' when unit settings are mph''',
        (WidgetTester tester) async {
      when(() => mockWeatherBloc.state).thenReturn(
        mockVisualCrossingState(),
      );
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<WeatherBloc>.value(
              value: mockWeatherBloc,
            ),
          ],
          child: const _MockSearchLocalWeatherButton(
            child: SpeedUnitWidget(
              textStyle: TextStyle(),
            ),
          ),
        ),
      );

      expect(find.text(mph), findsOneWidget);
    });

    testWidgets('''Displays displays 'kph' when unit settings are kph''',
        (WidgetTester tester) async {
      when(() => mockWeatherBloc.state).thenReturn(
        mockVisualCrossingState().copyWith(unitSettings: metricUnitSettings),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<WeatherBloc>.value(
              value: mockWeatherBloc,
            ),
          ],
          child: const _MockSearchLocalWeatherButton(
            child: SpeedUnitWidget(
              textStyle: TextStyle(),
            ),
          ),
        ),
      );

      expect(find.text(kph), findsOneWidget);
    });
  });

  group('PrecipUnitWidget test:', () {
    testWidgets('''Displays displays 'in' when unit settings are inches''',
        (WidgetTester tester) async {
      when(() => mockWeatherBloc.state).thenReturn(
        mockVisualCrossingState(),
      );
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<WeatherBloc>.value(
              value: mockWeatherBloc,
            ),
          ],
          child: const _MockSearchLocalWeatherButton(
            child: PrecipUnitWidget(
              textStyle: TextStyle(),
            ),
          ),
        ),
      );

      expect(find.text(inches), findsOneWidget);
    });

    testWidgets('''Displays displays 'mm' when unit settings are millimeters''',
        (WidgetTester tester) async {
      when(() => mockWeatherBloc.state).thenReturn(
        mockVisualCrossingState().copyWith(unitSettings: metricUnitSettings),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<WeatherBloc>.value(
              value: mockWeatherBloc,
            ),
          ],
          child: const _MockSearchLocalWeatherButton(
            child: PrecipUnitWidget(
              textStyle: TextStyle(),
            ),
          ),
        ),
      );

      expect(find.text(millimeters), findsOneWidget);
    });
  });
}
