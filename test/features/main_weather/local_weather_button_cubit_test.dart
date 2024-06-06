import 'package:bloc_test/bloc_test.dart';
import 'package:epic_skies/core/network/weather_kit/models/current/current_weather_data.dart';
import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/features/main_weather/models/local_weather_button_model/local_weather_button_model.dart';
import 'package:epic_skies/features/main_weather/view/cubit/local_weather_button_cubit.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/conversions/unit_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/init_hydrated_storage.dart';
import '../../mocks/mock_api_responses/mock_weather_responses.dart';

void main() async {
  late UnitSettings metricUnitSettings;
  late LocalWeatherButtonModel searchButtonModel;
  late CurrentWeatherModel currentWeatherModel;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();

    initHydratedStorage();

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
      build: LocalWeatherButtonCubit.new,
      seed: () => searchButtonModel,
      act: (LocalWeatherButtonCubit cubit) async {
        cubit.updateLocalWeatherButtonUnitSettings(
          tempUnitsMetric: false,
        );
      },
      expect: () {
        return [
          searchButtonModel.copyWith(
            temp: UnitConverter.toFahrenheight(searchButtonModel.temp),
          ),
        ];
      },
    );
  });
}
