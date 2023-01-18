import 'dart:async';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../models/weather_response_model/weather_data_model.dart';
import '../../../services/settings/unit_settings/unit_settings_model.dart';
import '../../../utils/logging/app_debug_log.dart';
import '../../../utils/timezone/timezone_util.dart';
import '../../sun_times/models/sun_time_model.dart';
import '../models/search_local_weather_button_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends HydratedBloc<WeatherEvent, WeatherState> {
  WeatherBloc({
    required WeatherRepository weatherRepository,
  })  : _weatherRepository = weatherRepository,
        super(const WeatherState()) {
    on<WeatherUpdate>(_onWeatherUpdate);
    on<WeatherUnitSettingsUpdate>(_onWeatherUnitSettingsUpdate);
  }

  final WeatherRepository _weatherRepository;

  Future<void> _onWeatherUpdate(
    WeatherUpdate event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      final hasConnection = await _weatherRepository.hasConnection();

      if (hasConnection) {
        emit(
          state.copyWith(
            status: WeatherStatus.loading,
            searchIsLocal: event.searchIsLocal,
          ),
        );

        _weatherRepository.storeSearchIsLocal(
          searchIsLocal: event.searchIsLocal,
        );

        final data = await _weatherRepository.fetchWeatherData(
          lat: event.lat,
          long: event.long,
        );

        if (data != null) {
          final suntimes = _initSunTimeList(weatherModel: data);

          final isDay = TimeZoneUtil.getCurrentIsDay(
            searchIsLocal: state.searchIsLocal,
            refSuntimes: suntimes,
            refTimeEpochInSeconds: data.currentCondition!.datetimeEpoch!,
          );
          final searchButtonModel =
              SearchLocalWeatherButtonModel.fromWeatherModel(
            model: data,
            unitSettings: state.unitSettings,
            isDay: _weatherRepository.restoreSavedIsDay(),
          );

          emit(
            state.copyWith(
              status: WeatherStatus.success,
              weatherModel: data,
              searchButtonModel: searchButtonModel,
              refererenceSuntimes: suntimes,
              isDay: isDay,
            ),
          );

          _weatherRepository.storeWeatherState(state);
        } else {
          emit(state.copyWith(status: WeatherStatus.error));
        }
      } else {
        emit(state.copyWith(status: WeatherStatus.error));
      }
    } catch (error) {
      emit(state.copyWith(status: WeatherStatus.error));

      _logWeatherBloc('LocalWeatherUpdated error: $error');
      rethrow;
    }
  }

  Future<void> _onWeatherUnitSettingsUpdate(
    WeatherUnitSettingsUpdate event,
    Emitter<WeatherState> emit,
  ) async {
    final searchButtonModel = SearchLocalWeatherButtonModel.fromWeatherModel(
      model: state.weatherModel!,
      unitSettings: event.unitSettings,
      isDay: _weatherRepository.restoreSavedIsDay(),
    );
    emit(
      state.copyWith(
        status: WeatherStatus.unitSettingsUpdate,
        unitSettings: event.unitSettings,
        searchButtonModel: searchButtonModel,
      ),
    );
  }

  void _logWeatherBloc(String message) {
    AppDebug.log(message, name: 'WeatherBloc');
  }

  List<SunTimesModel> _initSunTimeList({
    required WeatherResponseModel weatherModel,
  }) {
    final suntimeList = <SunTimesModel>[];

    int startIndex = 0;

    /// between 12am and 6am day @ index 0 is yesterday due
    /// to Tomorrow.io defining days from 6am to 6am, this accounts for that

    if (TimeZoneUtil.isBetweenMidnightAnd6Am(
      searchIsLocal: state.searchIsLocal,
    )) {
      startIndex++;
    }

    for (int i = startIndex; i <= 14; i++) {
      late SunTimesModel sunTime;

      final weatherData = weatherModel.days[i];

      sunTime = SunTimesModel.fromDailyData(
        data: weatherData,
        unitSettings: state.unitSettings,
        searchIsLocal: state.searchIsLocal,
      );

      suntimeList.add(sunTime);
    }

    /// This is a bit of a hack solution that accounts for when the app has to
    /// bump up the start index for when the remote time is between midnight and
    /// 6am. Sometimes the Tomorrow.io response will have 16 total days,
    /// sometimes it will only have 15. To prevent a range error when populating
    /// the next 14 days of daily forecast widgets, this just copies the sun
    /// times of the 13th day to the 14th day. The sunTimeList always needs to
    /// have at least 15 items. The only scenario where this would actually
    /// happen is if a user was searching the weather of somewhere else in the
    /// world where the local time happens to be between midnight and 6am. Even
    /// then the only not fully accurate data would be the sun times for the
    /// 14th day may be a couple minutes off

    if (suntimeList.length == 14) {
      suntimeList.add(suntimeList[13].clone());
    }

    return suntimeList;
  }

  @override
  WeatherState? fromJson(Map<String, dynamic> map) {
    return WeatherState.fromJson(map);
  }

  @override
  Map<String, dynamic>? toJson(WeatherState state) {
    return state.toJson();
  }
}
