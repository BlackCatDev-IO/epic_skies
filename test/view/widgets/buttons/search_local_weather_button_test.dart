import 'package:charcode/charcode.dart';
import 'package:epic_skies/features/current_weather_forecast/cubit/current_weather_cubit.dart';
import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:epic_skies/features/location/user_location/models/location_model.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/current_data/current_data_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/view/widgets/buttons/search_local_weather_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/init_hydrated_storage.dart';
import '../../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../../mocks/mock_classes.dart';
import '../../../test_utils.dart';

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
        child: SearchLocalWeatherButton(
          isSearchPage: false,
        ),
      ),
    );
  }
}

void main() {
  late MockStorageController mockStorage;
  late UnitSettings unitSettings;
  late MockWeatherRepo mockWeatherRepo;
  late WeatherResponseModel weatherModel;
  late Coordinates coordinates;
  late WeatherBloc mockWeatherBloc;
  late CurrentData data;

  late MockCurrentWeatherCubit currentWeatherCubit;
  late MockLocationBloc mockLocationBloc;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();

    initHydratedStorage();

    mockWeatherBloc = MockWeatherBloc();
    currentWeatherCubit = MockCurrentWeatherCubit();
    mockLocationBloc = MockLocationBloc();

    coordinates = const Coordinates(lat: 0, long: 0);
    mockStorage = MockStorageController();
    unitSettings = const UnitSettings(
      timeIn24Hrs: false,
      speedInKph: false,
      tempUnitsMetric: false,
      precipInMm: false,
    );

    unitSettings = const UnitSettings(
      timeIn24Hrs: false,
      speedInKph: false,
      tempUnitsMetric: false,
      precipInMm: false,
    );

    when(() => mockStorage.isNewInstall()).thenReturn(false);

    mockWeatherRepo = MockWeatherRepo();

    weatherModel = WeatherResponseModel.fromResponse(
      response: MockWeatherResponse.nycVisualCrossingResponse,
    );

    when(
      () => mockWeatherRepo.fetchWeatherData(
        lat: coordinates.lat,
        long: coordinates.long,
      ),
    ).thenAnswer((_) async {
      return weatherModel;
    });

    data = weatherModel.currentCondition;

    when(() => currentWeatherCubit.state).thenReturn(
      CurrentWeatherState(
        currentTimeString: '',
        data: CurrentWeatherModel.fromWeatherData(
          data: data,
          unitSettings: unitSettings,
        ),
      ),
    );

    when(() => mockLocationBloc.state).thenReturn(
      const LocationState(
        data: LocationModel(
          subLocality: 'The Bronx',
          administrativeArea: 'New York',
        ),
      ),
    );

    when(() => mockWeatherBloc.state).thenReturn(
      MockWeatherResponse.mockWeatherState(),
    );
  });

  testWidgets('Displays weather and location icon',
      (WidgetTester tester) async {
    when(() => mockLocationBloc.state).thenReturn(
      const LocationState(
        data: LocationModel(
          subLocality: 'The Bronx',
          administrativeArea: 'New York',
        ),
      ),
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
          BlocProvider<CurrentWeatherCubit>.value(
            value: currentWeatherCubit,
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
          BlocProvider<CurrentWeatherCubit>.value(
            value: currentWeatherCubit,
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
          BlocProvider<CurrentWeatherCubit>.value(
            value: currentWeatherCubit,
          ),
        ],
        child: _MockSearchLocalWeatherButton(),
      ),
    );

    final degreeSymbol = String.fromCharCode($deg);

    expect(find.text('F'), findsOneWidget);
    expect(find.text('41'), findsOneWidget);
    expect(find.text(degreeSymbol), findsOneWidget);
  });

  testWidgets('Temperature unit gets updated when user changes setting',
      (WidgetTester tester) async {
    when(() => mockWeatherBloc.state).thenReturn(
      MockWeatherResponse.mockWeatherState().copyWith(
        searchButtonModel: mockWeatherBloc.state.searchButtonModel
            .copyWith(tempUnitsMetric: true),
      ),
    );

    when(() => currentWeatherCubit.state).thenReturn(
      CurrentWeatherState(
        currentTimeString: '',
        data: CurrentWeatherModel.fromWeatherData(
          data: data,
          unitSettings: unitSettings.copyWith(tempUnitsMetric: true),
        ),
      ),
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
          BlocProvider<CurrentWeatherCubit>.value(
            value: currentWeatherCubit,
          ),
        ],
        child: _MockSearchLocalWeatherButton(),
      ),
    );

    expect(find.text('C'), findsOneWidget);
  });
}
