@Skip('Pending refactor update')
library;

import 'package:bloc_test/bloc_test.dart';
import 'package:epic_skies/core/network/weather_kit/models/current/current_weather_data.dart';
import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/main_weather/models/local_weather_button_model.dart';
import 'package:epic_skies/features/main_weather/view/cubit/local_weather_button_cubit.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../mocks/mock_classes.dart';

void main() async {
  late UnitSettings metricUnitSettings;

  late LocalWeatherButtonModel searchButtonModel;
  late Storage storage;
  late WeatherBloc mockWeatherBloc;
  late TimeZoneUtil timeZoneUtil;
  late CurrentWeatherModel currentWeatherModel;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();

    timeZoneUtil = TimeZoneUtil();
    getIt.registerSingleton<TimeZoneUtil>(timeZoneUtil);

    mockWeatherBloc = MockWeatherBloc();
    storage = MockHydratedStorage();
    HydratedBloc.storage = storage;
    when(
      () => storage.write(any(), any<dynamic>()),
    ).thenAnswer((_) async {});
    HydratedBloc.storage = storage;

    metricUnitSettings = const UnitSettings(
      tempUnitsMetric: true,
      timeIn24Hrs: true,
      precipInMm: true,
      speedInKph: true,
    );

    currentWeatherModel = CurrentWeatherModel.fromWeatherKit(
      unitSettings: metricUnitSettings,
      data: CurrentWeatherData.fromMap(
        MockWeatherResponse.weatherKitCurrentWeather,
      ),
    );

    searchButtonModel = LocalWeatherButtonModel.fromCurrentWeather(
      currentWeatherModel: currentWeatherModel,
      isDay: true,
    );

    metricUnitSettings = const UnitSettings(
      tempUnitsMetric: true,
      precipInMm: true,
      speedInKph: true,
    );

    when(() => mockWeatherBloc.state).thenReturn(
      MockWeatherResponse.mockWeatherState(),
    );

    searchButtonModel = LocalWeatherButtonModel.fromCurrentWeather(
      currentWeatherModel: currentWeatherModel,
      isDay: true,
    );
  });

/* --------------------- updateSearchLocalWeatherButton --------------------- */

  group('SearchLocalWeatherButtonCubit test:', () {
    blocTest<LocalWeatherButtonCubit, LocalWeatherButtonModel>(
      '''
emits updated SearchLocalWeatherButton model on weather refresh''',
      setUp: () {
        when(() => mockWeatherBloc.state).thenReturn(
          MockWeatherResponse.mockWeatherState(),
        );
      },
      build: LocalWeatherButtonCubit.new,
      seed: LocalWeatherButtonModel.new,
      act: (LocalWeatherButtonCubit cubit) async {
        cubit.updateSearchLocalWeatherButton(
          weatherState: currentWeatherModel,
          isDay: true,
        );
      },
      expect: () {
        return [searchButtonModel];
      },
    );

    blocTest<LocalWeatherButtonCubit, LocalWeatherButtonModel>(
      'does not update on remote search',
      setUp: () {
        when(() => mockWeatherBloc.state).thenReturn(
          MockWeatherResponse.mockWeatherState().copyWith(searchIsLocal: false),
        );
      },
      build: LocalWeatherButtonCubit.new,
      seed: () => searchButtonModel,
      act: (LocalWeatherButtonCubit cubit) async {
        cubit.updateSearchLocalWeatherButton(
          weatherState: currentWeatherModel,
          isDay: true,
        );
      },
      expect: () {
        return <List<dynamic>>[]; // empty list implies no state change
      },
    );

    /* ------------ updateSearchLocalWeatherButtonUnitSettings -------------- */

    blocTest<LocalWeatherButtonCubit, LocalWeatherButtonModel>(
      'temp updates when unit settings change to celcius',
      setUp: () {
        when(() => mockWeatherBloc.state).thenReturn(
          MockWeatherResponse.mockWeatherState()
              .copyWith(unitSettings: metricUnitSettings),
        );
      },
      build: LocalWeatherButtonCubit.new,
      seed: () => searchButtonModel,
      act: (LocalWeatherButtonCubit cubit) async {
        cubit.updateLocalWeatherButtonUnitSettings(
          tempUnitsMetric: true,
        );
      },
      expect: () {
        return [
          searchButtonModel.copyWith(
            temp: UnitConverter.toCelcius(searchButtonModel.temp),
          ),
        ];
      },
    );

    blocTest<LocalWeatherButtonCubit, LocalWeatherButtonModel>(
      'temp updates when unit settings change to fahrenheight',
      setUp: () {
        when(() => mockWeatherBloc.state).thenReturn(
          MockWeatherResponse.mockWeatherState(),
        );
      },
      build: LocalWeatherButtonCubit.new,
      seed: () => searchButtonModel.copyWith(
        temp: UnitConverter.toFahrenheight(searchButtonModel.temp),
      ),
      act: (LocalWeatherButtonCubit cubit) async {
        cubit.updateLocalWeatherButtonUnitSettings(
          tempUnitsMetric: true,
        );
      },
      expect: () {
        return [searchButtonModel];
      },
    );
  });
}
