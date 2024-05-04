import 'package:charcode/charcode.dart';
import 'package:epic_skies/core/network/weather_kit/models/current/current_weather_data.dart';
import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/location/user_location/models/location_model.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/main_weather/models/local_weather_button_model.dart';
import 'package:epic_skies/features/main_weather/view/cubit/local_weather_button_cubit.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:epic_skies/view/widgets/buttons/local_weather_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../features/main_weather/mock_weather_state.dart';
import '../../../mocks/init_hydrated_storage.dart';
import '../../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../../mocks/mock_classes.dart';
import '../../../test_utils.dart';

const fahrenheitTemp = 41;
const celciusTemp = 6;

class _MockSearchLocalWeatherButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorCubit>(
          create: (context) => ColorCubit(),
        ),
      ],
      child: const MaterialWidgetTestAncestorWidget(
        child: LocalWeatherButton(
          isSearchPage: false,
        ),
      ),
    );
  }
}

void main() {
  late UnitSettings metricUnitSettings;
  late WeatherBloc mockWeatherBloc;
  // late CurrentData data;
  late LocalWeatherButtonCubit mockSearchLocalButtonCubit;
  late LocalWeatherButtonModel searchButtonModel;

  late MockLocationBloc mockLocationBloc;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    getIt.registerSingleton<TimeZoneUtil>(TimeZoneUtil());

    initHydratedStorage();

    mockWeatherBloc = MockWeatherBloc();
    mockLocationBloc = MockLocationBloc();
    mockSearchLocalButtonCubit = MockSearchLocalWeatherButtonCubit();

    metricUnitSettings = const UnitSettings(
      speedInKph: true,
      tempUnitsMetric: true,
      precipInMm: true,
    );

    when(() => mockLocationBloc.state).thenReturn(
      const LocationState(
        localData: LocationModel(
          subLocality: 'The Bronx',
          administrativeArea: 'New York',
        ),
      ),
    );

    when(() => mockWeatherBloc.state).thenReturn(
      mockVisualCrossingState(),
    );

    searchButtonModel = LocalWeatherButtonModel.fromCurrentWeather(
      currentWeatherModel: CurrentWeatherModel.fromWeatherKit(
        unitSettings: metricUnitSettings,
        data: CurrentWeatherData.fromMap(
          MockWeatherResponse.weatherKitCurrentWeather,
        ),
      ),
      isDay: true,
    );
  });

  testWidgets('Displays weather and location icon',
      (WidgetTester tester) async {
    when(() => mockLocationBloc.state).thenReturn(
      const LocationState(
        localData: LocationModel(
          subLocality: 'The Bronx',
          administrativeArea: 'New York',
        ),
      ),
    );

    when(() => mockSearchLocalButtonCubit.state).thenReturn(
      searchButtonModel,
    );

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<LocationBloc>.value(
            value: mockLocationBloc,
          ),
          BlocProvider<WeatherBloc>.value(
            value: mockWeatherBloc,
          ),
          BlocProvider<LocalWeatherButtonCubit>.value(
            value: mockSearchLocalButtonCubit,
          ),
        ],
        child: _MockSearchLocalWeatherButton(),
      ),
    );

    final weatherIcon = find.byType(Image);
    final locationIcon = find.byIcon(Icons.near_me);
    expect(weatherIcon, findsOneWidget);
    expect(locationIcon, findsOneWidget);
  });

  testWidgets('Location displayed as expected', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<LocationBloc>.value(
            value: mockLocationBloc,
          ),
          BlocProvider<WeatherBloc>.value(
            value: mockWeatherBloc,
          ),
          BlocProvider<LocalWeatherButtonCubit>.value(
            value: mockSearchLocalButtonCubit,
          ),
        ],
        child: _MockSearchLocalWeatherButton(),
      ),
    );

    expect(find.text('The Bronx'), findsOneWidget);
    expect(find.text('New York'), findsOneWidget);
    expect(find.text('Your location'), findsOneWidget);
  });

  testWidgets('Temperature displayed as expected', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<LocationBloc>.value(
            value: mockLocationBloc,
          ),
          BlocProvider<WeatherBloc>.value(
            value: mockWeatherBloc,
          ),
          BlocProvider<LocalWeatherButtonCubit>.value(
            value: mockSearchLocalButtonCubit,
          ),
        ],
        child: _MockSearchLocalWeatherButton(),
      ),
    );

    final degreeSymbol = String.fromCharCode($deg);

    expect(find.text('F'), findsOneWidget);
    expect(find.text(fahrenheitTemp.toString()), findsOneWidget);
    expect(find.text(degreeSymbol), findsOneWidget);
  });

  testWidgets('Temperature gets updated when user changes setting',
      (WidgetTester tester) async {
    when(() => mockWeatherBloc.state).thenReturn(
      mockVisualCrossingState().copyWith(
        unitSettings: metricUnitSettings,
      ),
    );

    when(() => mockSearchLocalButtonCubit.state).thenReturn(
      searchButtonModel.copyWith(tempUnitsMetric: true, temp: celciusTemp),
    );

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<LocationBloc>.value(
            value: mockLocationBloc,
          ),
          BlocProvider<WeatherBloc>.value(
            value: mockWeatherBloc,
          ),
          BlocProvider<LocalWeatherButtonCubit>.value(
            value: mockSearchLocalButtonCubit,
          ),
        ],
        child: _MockSearchLocalWeatherButton(),
      ),
    );

    expect(find.text(celciusTemp.toString()), findsOneWidget);
    expect(find.text('C'), findsOneWidget);
  });
}
