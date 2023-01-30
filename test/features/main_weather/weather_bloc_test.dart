import 'package:bloc_test/bloc_test.dart';
import 'package:epic_skies/core/error_handling/custom_exceptions.dart';
import 'package:epic_skies/core/error_handling/error_messages.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/main_weather/models/search_local_weather_button_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../mocks/mock_classes.dart';

void main() async {
  late MockWeatherRepo mockWeatherRepo;
  late UnitSettings unitSettings;
  late UnitSettings metricUnitSettings;

  late double lat;
  late double long;
  late WeatherResponseModel mockWeatherModel;
  late SearchLocalWeatherButtonModel searchButtonModel;
  late Storage storage;
  late List<SunTimesModel> suntimeList;
  late bool isDay;
  late bool searchIsLocal;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    isDay = true;
    searchIsLocal = true;
    storage = MockHydratedStorage();
    HydratedBloc.storage = storage;
    when(
      () => storage.write(any(), any<dynamic>()),
    ).thenAnswer((_) async {});
    HydratedBloc.storage = storage;

    mockWeatherRepo = MockWeatherRepo();

    unitSettings = const UnitSettings(
      tempUnitsMetric: false,
      timeIn24Hrs: false,
      precipInMm: false,
      speedInKph: false,
    );

    metricUnitSettings = const UnitSettings(
      tempUnitsMetric: true,
      timeIn24Hrs: true,
      precipInMm: true,
      speedInKph: true,
    );

    lat = 0.0;
    long = 0.0;

    mockWeatherModel = WeatherResponseModel.fromResponse(
      response: MockWeatherResponse.nycVisualCrossingResponse,
    );

    suntimeList = TimeZoneUtil.initSunTimeList(
      weatherModel: mockWeatherModel,
      searchIsLocal: searchIsLocal,
      unitSettings: unitSettings,
    );

    searchButtonModel = SearchLocalWeatherButtonModel.fromWeatherModel(
      model: mockWeatherModel,
      unitSettings: unitSettings,
      isDay: isDay,
    );

    metricUnitSettings = const UnitSettings(
      tempUnitsMetric: true,
      timeIn24Hrs: false,
      precipInMm: true,
      speedInKph: true,
    );

    isDay = TimeZoneUtil.getCurrentIsDay(
      searchIsLocal: searchIsLocal,
      refSuntimes: suntimeList,
      refTimeEpochInSeconds: mockWeatherModel.currentCondition.datetimeEpoch,
    );

    when(() => mockWeatherRepo.fetchWeatherData(lat: lat, long: long))
        .thenAnswer(
      (_) async => mockWeatherModel,
    );

    when(() => mockWeatherRepo.restoreSavedIsDay()).thenReturn(
      true,
    );
  });

  /* ------------------------ WeatherUpdate Event Test ------------------------ */

  group('WeatherUpdate Event Test: ', () {
    blocTest(
      'emits loading --> success when _weatherRepository returns successful WeatherResponse',
      build: () => WeatherBloc(
        weatherRepository: mockWeatherRepo,
      ),
      act: (WeatherBloc bloc) async {
        bloc.add(
          WeatherUpdate(lat: lat, long: long, searchIsLocal: searchIsLocal),
        );
      },
      expect: () {
        return [
          WeatherState(
            status: WeatherStatus.loading,
            unitSettings: unitSettings,
          ),
          WeatherState(
            weatherModel: mockWeatherModel,
            status: WeatherStatus.success,
            unitSettings: unitSettings,
            searchButtonModel: searchButtonModel,
            refererenceSuntimes: suntimeList,
            searchIsLocal: searchIsLocal,
            isDay: isDay,
          ),
        ];
      },
    );

    blocTest(
      'emits Errors.noNetworkErrorModel when _weatherRepository throws NoConnectionException',
      setUp: () {
        when(() => mockWeatherRepo.fetchWeatherData(lat: lat, long: long))
            .thenThrow(NoConnectionException());
      },
      build: () => WeatherBloc(
        weatherRepository: mockWeatherRepo,
      ),
      act: (WeatherBloc bloc) => bloc
          .add(const WeatherUpdate(lat: 0.0, long: 0.0, searchIsLocal: true)),
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

    blocTest(
      'emits Errors.serverErrorModel when _weatherRepository throws server errors',
      setUp: () {
        when(() => mockWeatherRepo.fetchWeatherData(lat: lat, long: long))
            .thenThrow(ServerErrorException());
      },
      build: () => WeatherBloc(
        weatherRepository: mockWeatherRepo,
      ),
      act: (WeatherBloc bloc) => bloc
          .add(const WeatherUpdate(lat: 0.0, long: 0.0, searchIsLocal: true)),
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
    blocTest(
      'emits Errors.networkErrorModel when _weatherRepository throws network error',
      setUp: () {
        when(() => mockWeatherRepo.fetchWeatherData(lat: lat, long: long))
            .thenThrow(NetworkException());
      },
      build: () => WeatherBloc(
        weatherRepository: mockWeatherRepo,
      ),
      act: (WeatherBloc bloc) => bloc
          .add(const WeatherUpdate(lat: 0.0, long: 0.0, searchIsLocal: true)),
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

    blocTest(
      'emits updated UnitSettings corresponding to unitsettings passed into event',
      setUp: () {
        when(() => mockWeatherRepo.restoreSavedIsDay()).thenReturn(
          true,
        );

        when(() => mockWeatherRepo.fetchWeatherData(lat: lat, long: long))
            .thenAnswer(
          (_) async => mockWeatherModel,
        );
      },
      build: () => WeatherBloc(
        weatherRepository: mockWeatherRepo,
      ),
      seed: () => WeatherState(
        weatherModel: mockWeatherModel,
        status: WeatherStatus.success,
        searchButtonModel: searchButtonModel,
        unitSettings: unitSettings,
      ),
      act: (WeatherBloc bloc) {
        bloc.add(
          WeatherUnitSettingsUpdate(unitSettings: metricUnitSettings),
        );
      },
      expect: () {
        final metricSearchButtonModel =
            SearchLocalWeatherButtonModel.fromWeatherModel(
          model: mockWeatherModel,
          unitSettings: metricUnitSettings,
          isDay: true,
        );

        return [
          WeatherState(
            weatherModel: mockWeatherModel,
            status: WeatherStatus.unitSettingsUpdate,
            unitSettings: metricUnitSettings,
            searchButtonModel: metricSearchButtonModel,
          ),
        ];
      },
    );
  });
}
