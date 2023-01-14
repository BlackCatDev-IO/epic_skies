import 'package:bloc_test/bloc_test.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/main_weather/model/search_local_weather_button_model.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    mockWeatherRepo = MockWeatherRepo();
    unitSettings = const UnitSettings(
      tempUnitsMetric: false,
      timeIn24Hrs: false,
      precipInMm: false,
      speedInKph: false,
    );
    lat = 0.0;
    long = 0.0;
    mockWeatherModel = WeatherResponseModel.fromResponse(
      response: MockWeatherResponse.nycVisualCrossingResponse,
    );

    searchButtonModel = SearchLocalWeatherButtonModel.fromWeatherModel(
      model: mockWeatherModel,
      unitSettings: unitSettings,
      isDay: true,
    );

    metricUnitSettings = const UnitSettings(
      tempUnitsMetric: true,
      timeIn24Hrs: false,
      precipInMm: true,
      speedInKph: true,
    );
  });

  /* ------------------------ WeatherUpdate Event Test ------------------------ */

  group('WeatherUpdate Event Test: ', () {
    blocTest(
      'emits loading --> success when _weatherRepository returns successful WeatherResponse',
      setUp: () {
        when(() => mockWeatherRepo.hasConnection()).thenAnswer(
          (_) async => true,
        );

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
        unitSettings: unitSettings,
      ),
      act: (WeatherBloc bloc) => bloc
          .add(const WeatherUpdate(lat: 0.0, long: 0.0, searchIsLocal: true)),
      expect: () => [
        WeatherState(
          status: WeatherStatus.loading,
          unitSettings: unitSettings,
        ),
        WeatherState(
          weatherModel: mockWeatherModel,
          status: WeatherStatus.success,
          unitSettings: unitSettings,
          searchButtonModel: searchButtonModel,
        ),
      ],
    );

    blocTest(
      'emits error when _weatherRepository returns no internet connection',
      setUp: () {
        when(() => mockWeatherRepo.hasConnection()).thenAnswer(
          (_) async => false,
        );
      },
      build: () => WeatherBloc(
        weatherRepository: mockWeatherRepo,
        unitSettings: unitSettings,
      ),
      act: (WeatherBloc bloc) => bloc
          .add(const WeatherUpdate(lat: 0.0, long: 0.0, searchIsLocal: true)),
      expect: () => [
        WeatherState(
          status: WeatherStatus.error,
          unitSettings: unitSettings,
        ),
      ],
    );

    blocTest(
      'emits loading --> error when _weatherRepository returns null on fetchWeatherData',
      setUp: () {
        when(() => mockWeatherRepo.hasConnection()).thenAnswer(
          (_) async => true,
        );

        when(() => mockWeatherRepo.fetchWeatherData(lat: lat, long: long))
            .thenAnswer(
          (_) async => null,
        );
      },
      build: () => WeatherBloc(
        weatherRepository: mockWeatherRepo,
        unitSettings: unitSettings,
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
        ),
      ],
    );
  });

  /* ------------------------ WeatherUnitSettingsUpdate ----------------------- */

  group('WeatherUnitSettingsUpdate Event Test: ', () {
    blocTest(
      'emits updated UnitSettings corresponding to unitsettings passed into event',
      setUp: () {
        when(() => mockWeatherRepo.hasConnection()).thenAnswer(
          (_) async => true,
        );

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
        unitSettings: unitSettings,
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
