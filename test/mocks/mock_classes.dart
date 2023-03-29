import 'package:bloc_test/bloc_test.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/features/current_weather_forecast/cubit/current_weather_cubit.dart';
import 'package:epic_skies/features/daily_forecast/cubit/daily_forecast_cubit.dart';
import 'package:epic_skies/features/daily_forecast/cubit/daily_forecast_state.dart';
import 'package:epic_skies/features/hourly_forecast/cubit/hourly_forecast_cubit.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/main_weather/models/local_weather_button_model.dart';
import 'package:epic_skies/features/main_weather/view/cubit/local_weather_button_cubit.dart';
import 'package:epic_skies/repositories/location_repository.dart';
import 'package:epic_skies/repositories/system_info_repository.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockStorageController with Mock implements StorageController {}

class MockHydratedStorage extends Mock implements Storage {}


class MockBuildContext extends Mock implements BuildContext {}

class MockWeatherRepo with Mock implements WeatherRepository {}

class MockLocationRepo with Mock implements LocationRepository {}

class MockSystemInfoRepo with Mock implements SystemInfoRepository {}

class MockTimeZoneUtil with Mock implements TimeZoneUtil {}

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

class MockLocationBloc extends MockBloc<LocationEvent, LocationState>
    implements LocationBloc {}

class MockCurrentWeatherCubit extends MockCubit<CurrentWeatherState>
    implements CurrentWeatherCubit {}

class MockHourlyForecastCubit extends MockCubit<HourlyForecastState>
    implements HourlyForecastCubit {}

class MockDailyForecastCubit extends MockCubit<DailyForecastState>
    implements DailyForecastCubit {}

class MockSearchLocalWeatherButtonCubit
    extends MockCubit<LocalWeatherButtonModel>
    implements LocalWeatherButtonCubit {}
