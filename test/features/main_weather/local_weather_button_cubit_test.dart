import 'package:bloc_test/bloc_test.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/main_weather/models/local_weather_button_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/features/main_weather/view/cubit/local_weather_button_cubit.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
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
  late UnitSettings unitSettings;
  late UnitSettings metricUnitSettings;

  late WeatherResponseModel mockWeatherModel;
  late LocalWeatherButtonModel searchButtonModel;
  late Storage storage;
  late List<SunTimesModel> suntimeList;
  late bool isDay;
  late bool searchIsLocal;
  late WeatherBloc mockWeatherBloc;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    mockWeatherBloc = MockWeatherBloc();
    isDay = true;
    searchIsLocal = true;
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

    mockWeatherModel = WeatherResponseModel.fromResponse(
      response: MockWeatherResponse.nycVisualCrossingResponse,
    );

    suntimeList = TimeZoneUtil.initSunTimeList(
      weatherModel: mockWeatherModel,
      searchIsLocal: searchIsLocal,
      unitSettings: unitSettings,
    );

    searchButtonModel = LocalWeatherButtonModel.fromWeatherModel(
      model: mockWeatherModel,
      unitSettings: unitSettings,
      isDay: isDay,
    );

    metricUnitSettings = const UnitSettings(
      tempUnitsMetric: true,
      precipInMm: true,
      speedInKph: true,
    );

    isDay = TimeZoneUtil.getCurrentIsDay(
      searchIsLocal: searchIsLocal,
      refSuntimes: suntimeList,
      refTimeEpochInSeconds: mockWeatherModel.currentCondition.datetimeEpoch,
    );

    when(() => mockWeatherBloc.state).thenReturn(
      MockWeatherResponse.mockWeatherState(),
    );

    searchButtonModel = LocalWeatherButtonModel.fromWeatherModel(
      model: mockWeatherBloc.state.weatherModel!,
      unitSettings: mockWeatherBloc.state.unitSettings,
      isDay: TimeZoneUtil.getCurrentIsDay(
        searchIsLocal: mockWeatherBloc.state.searchIsLocal,
        refSuntimes: mockWeatherBloc.state.refererenceSuntimes,
        refTimeEpochInSeconds:
            mockWeatherBloc.state.weatherModel!.currentCondition.datetimeEpoch,
      ),
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
          weatherState: mockWeatherBloc.state,
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
          weatherState: mockWeatherBloc.state,
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
        cubit.updateSearchLocalWeatherButtonUnitSettings(
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
        cubit.updateSearchLocalWeatherButtonUnitSettings(
          tempUnitsMetric: true,
        );
      },
      expect: () {
        return [searchButtonModel];
      },
    );
  });
}
