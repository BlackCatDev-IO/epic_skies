import 'package:bloc_test/bloc_test.dart';
import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/core/error_handling/error_messages.dart';
import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/location/remote_location/models/coordinates/coordinates.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_classes.dart';
import '../../mocks/visual_crossing_mock.dart';
import '../../mocks/weather_kit_mocks/weather_kit_mocks.dart';
import 'mock_weather_state.dart';

void main() async {
  late WeatherRepository mockWeatherRepo;
  late UnitSettings unitSettings;
  late UnitSettings metricUnitSettings;
  late LocationState locationState;
  late Coordinates coordinates;
  late WeatherResponseModel mockWeatherModel;
  late Storage storage;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();

    mockWeatherRepo = MockWeatherRepo();
    locationState = const LocationState();
    storage = MockHydratedStorage();
    HydratedBloc.storage = storage;
    when(
      () => storage.write(any(), any<dynamic>()),
    ).thenAnswer((_) async {});

    HydratedBloc.storage = storage;

    unitSettings = const UnitSettings();

    metricUnitSettings = const UnitSettings(
      tempUnitsMetric: true,
      timeIn24Hrs: true,
      precipInMm: true,
      speedInKph: true,
    );

    coordinates = const Coordinates(lat: 40.826, long: -73.925);

    mockWeatherModel = WeatherResponseModel.fromResponse(
      response: nycVisualCrossingResponse,
    );

    metricUnitSettings = const UnitSettings(
      tempUnitsMetric: true,
      precipInMm: true,
      speedInKph: true,
    );

    when(
      () => mockWeatherRepo.getVisualCrossingData(
        coordinates: coordinates,
      ),
    ).thenAnswer(
      (_) async => mockWeatherModel,
    );
  });

/* ------------------------ WeatherUpdate Event Test ------------------------ */

  group('WeatherUpdate Event Test: ', () {
    blocTest<WeatherBloc, WeatherState>(
      '''
emits loading --> success when _weatherRepository returns successful 
WeatherResponse''',
      setUp: () => {
        when(
          () => mockWeatherRepo.getWeatherKitData(
            coordinates: coordinates,
            timezone: 'America/New_York',
            locale: const Locale('en', 'US'),
          ),
        ).thenAnswer(
          (_) async => Weather.fromMap(nycWeatherKitMock),
        ),
      },
      build: () => WeatherBloc(
        weatherRepository: mockWeatherRepo,
      ),
      act: (WeatherBloc bloc) async {
        bloc.add(
          WeatherUpdate(
            locationState: LocationState(
              localCoordinates: coordinates,
            ),
            userLocale: const Locale('en', 'US'),
          ),
        );
      },
      expect: () {
        return [
          const WeatherState(
            status: WeatherStatus.loading,
          ),
          MockWeatherState().mockWeatherKitState(),
        ];
      },
    );

    blocTest<WeatherBloc, WeatherState>(
      '''
emits Errors.noNetworkErrorModel when _weatherRepository throws 
NoConnectionException''',
      setUp: () {
        when(
          () => mockWeatherRepo.getVisualCrossingData(
            coordinates:
                Coordinates(lat: coordinates.lat, long: coordinates.long),
          ),
        ).thenThrow(NoConnectionException());
      },
      build: () => WeatherBloc(
        weatherRepository: mockWeatherRepo,
      ),
      act: (WeatherBloc bloc) => bloc.add(
        WeatherUpdate(
          locationState: locationState,
          userLocale: const Locale('en', 'US'),
        ),
      ),
      expect: () => [
        WeatherState(
          status: WeatherStatus.loading,
          unitSettings: unitSettings,
        ),
        WeatherState(
          status: WeatherStatus.error,
          unitSettings: unitSettings,
          errorModel: Errors.noNetworkErrorModel,
        ),
      ],
    );

    blocTest<WeatherBloc, WeatherState>(
      '''
emits Errors.serverErrorModel when _weatherRepository throws server 
errors''',
      setUp: () {
        when(
          () => mockWeatherRepo.getVisualCrossingData(coordinates: coordinates),
        ).thenThrow(ServerErrorException());
      },
      build: () => WeatherBloc(
        weatherRepository: mockWeatherRepo,
      ),
      act: (WeatherBloc bloc) => bloc.add(
        const WeatherUpdate(
          locationState: LocationState(),
          userLocale: Locale('en', 'US'),
        ),
      ),
      expect: () => [
        WeatherState(
          status: WeatherStatus.loading,
          unitSettings: unitSettings,
        ),
        WeatherState(
          status: WeatherStatus.error,
          unitSettings: unitSettings,
          errorModel: Errors.serverErrorModel,
        ),
      ],
    );
    blocTest<WeatherBloc, WeatherState>(
      '''
emits Errors.networkErrorModel when _weatherRepository throws network 
error''',
      setUp: () {
        when(
          () => mockWeatherRepo.getVisualCrossingData(coordinates: coordinates),
        ).thenThrow(NetworkException());
      },
      build: () => WeatherBloc(
        weatherRepository: mockWeatherRepo,
      ),
      act: (WeatherBloc bloc) => bloc.add(
        const WeatherUpdate(
          locationState: LocationState(),
          userLocale: Locale('en', 'US'),
        ),
      ),
      expect: () => [
        WeatherState(
          status: WeatherStatus.loading,
          unitSettings: unitSettings,
        ),
        WeatherState(
          status: WeatherStatus.error,
          unitSettings: unitSettings,
          errorModel: Errors.networkErrorModel,
        ),
      ],
    );

/* ------------------------ WeatherUnitSettingsUpdate ----------------------- */

    blocTest<WeatherBloc, WeatherState>(
      '''
emits updated UnitSettings corresponding to unitsettings passed into 
event''',
      setUp: () {
        when(
          () => mockWeatherRepo.getVisualCrossingData(coordinates: coordinates),
        ).thenAnswer(
          (_) async => mockWeatherModel,
        );
      },
      build: () => WeatherBloc(
        weatherRepository: mockWeatherRepo,
      ),
      seed: () => WeatherState(
        weatherModel: mockWeatherModel,
        status: WeatherStatus.success,
        unitSettings: unitSettings,
      ),
      act: (WeatherBloc bloc) {
        bloc.add(
          WeatherUnitSettingsUpdate(unitSettings: metricUnitSettings),
        );
      },
      expect: () {
        return [
          WeatherState(
            weatherModel: mockWeatherModel,
            status: WeatherStatus.unitSettingsUpdate,
            unitSettings: metricUnitSettings,
          ),
        ];
      },
    );
  });
}
