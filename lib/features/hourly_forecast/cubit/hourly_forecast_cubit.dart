import 'dart:developer';

import 'package:black_cat_lib/extensions/extensions.dart';
import 'package:dart_date/dart_date.dart';
import 'package:epic_skies/core/network/weather_kit/models/hourly/hour_weather_conditions.dart';
import 'package:epic_skies/features/hourly_forecast/cubit/hourly_forecast_state.dart';
import 'package:epic_skies/features/hourly_forecast/models/hourly_forecast_model/hourly_forecast_model.dart';
import 'package:epic_skies/features/hourly_forecast/models/hourly_vertical_widget_model/hourly_vertical_widget_model.dart';
import 'package:epic_skies/features/hourly_forecast/models/sorted_hourly_list_model/sorted_hourly_list_model.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/hourly_data/hourly_data_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

export 'hourly_forecast_state.dart';

/// This class sorts all hourly forecast data to distribute throughout the app
class HourlyForecastCubit extends HydratedCubit<HourlyForecastState> {
  HourlyForecastCubit() : super(HourlyForecastState());

  static const _next24Hours = 'next24Hours';
  static const _day1 = 'day1';
  static const _day2 = 'day2';
  static const _day3 = 'day3';
  static const _day4 = 'day4';
  static const _day5 = 'day5';
  static const _day6 = 'day6';
  static const _day7 = 'day7';
  static const _day8 = 'day8';
  static const _day9 = 'day9';
  static const _day10 = 'day10';

  final _sortedHourlyMap = <String, List<Map<String, dynamic>>>{
    _next24Hours: [],
    _day1: [],
    _day2: [],
    _day3: [],
    _day4: [],
    _day5: [],
    _day6: [],
    _day7: [],
    _day8: [],
    _day9: [],
    _day10: [],
  };

  late WeatherState _weatherState;

  late HourlyData _hourlyData;

  late HourWeatherConditions _hourlyWeatherKitData;

  late int _nowHour;
  late int _hoursUntilNext6am;

  late HourlyVerticalWidgetModel _hourModel;

  late SunTimesModel _sunTimes;

  late DateTime _now;
  late DateTime _startTime;
  late DateTime _day1StartTime;
  late DateTime _day2StartTime;
  late DateTime _day3StartTime;
  late DateTime _day4StartTime;
  late DateTime _day5StartTime;
  late DateTime _day6StartTime;
  late DateTime _day7StartTime;
  late DateTime _day8StartTime;
  late DateTime _day9StartTime;
  late DateTime _day10StartTime;

  final _timezoneUtil = GetIt.I<TimeZoneUtil>();

  /// Sorts all hourly data from WeatherState and updates UI
  Future<void> refreshHourlyData({
    required WeatherState updatedWeatherState,
  }) async {
    _weatherState = updatedWeatherState;
    _now =  _timezoneUtil.getCurrentLocalOrRemoteTime(
      searchIsLocal: updatedWeatherState.searchIsLocal,
    );
    _nowHour = _now.hour;

    late final List<HourlyForecastModel> updatedList;

    _initHoursUntilNext6am();
    if (updatedWeatherState.useBackupApi) {
      _initReferenceTimes();
      updatedList = _initHourlyDataFromVisualCrossingApi();
    } else {
      _initReferenceTimesFromWeatherKit();
      updatedList = _initHourlyWeatherKitData();
    }

    final sortedHourlyList = SortedHourlyList.fromMap(_sortedHourlyMap);

    emit(
      state.copyWith(
        houryForecastModelList: updatedList,
        sortedHourlyList: sortedHourlyList,
      ),
    );

    _clearHourlyMap();
  }

  List<HourlyForecastModel> _initHourlyWeatherKitData() {
    final hourlyList = _weatherState.weather!.forecastHourly.hours;

    final updatedHourlyList = <HourlyForecastModel>[];

    for (var i = 0; i <= hourlyList.length - 1; i++) {
      _hourlyWeatherKitData = hourlyList[i];

      _initHourlyTimeValuesFromWeatherKit();

      final referenceTime =  _timezoneUtil.currentReferenceSunTimeFromWeatherKit(
        searchIsLocal: _weatherState.searchIsLocal,
        suntimeList: _weatherState.refererenceSuntimes,
        refTime: _hourlyWeatherKitData.forecastStart,
      );

      final isDay =  _timezoneUtil.getForecastDayOrNightFromWeatherKit(
        hourlyForecastStart: _hourlyWeatherKitData.forecastStart,
        referenceTime: referenceTime,
        searchIsLocal: _weatherState.searchIsLocal,
      );

      final hourlyconditions = _hourlyWeatherKitData.conditionCode;

      final iconPath = IconController.getIconImagePath(
        condition: hourlyconditions,
        temp: _hourlyWeatherKitData.temperature.round(),
        tempUnitsMetric: _weatherState.unitSettings.tempUnitsMetric,
        isDay: isDay,
      );

      _hourModel = HourlyVerticalWidgetModel.fromWeatherKitData(
        iconPath: iconPath,
        unitSettings: _weatherState.unitSettings,
        searchIsLocal: _weatherState.searchIsLocal,
        hourlyData: _hourlyWeatherKitData,
      );

      final startTime =  _timezoneUtil.localOrOffsetTime(
        dateTime: _hourlyWeatherKitData.forecastStart,
        searchIsLocal: _weatherState.searchIsLocal,
      );

      final isNext24Hours = startTime.isAfter(_now) &&
          startTime.isBefore(_now.add(const Duration(hours: 24)));

      if (isNext24Hours) {
        final hourlyForecastModel = HourlyForecastModel.fromWeatherKitData(
          iconPath: iconPath,
          unitSettings: _weatherState.unitSettings,
          searchIsLocal: _weatherState.searchIsLocal,
          hourlyData: _hourlyWeatherKitData,
        );

        updatedHourlyList.add(hourlyForecastModel);
      }

      _sortHourlyHorizontalScrollColumns(
        hour: i,
        temp: _hourlyWeatherKitData.temperature.round(),
        isWeatherKit: true,
      );
    }
    return updatedHourlyList;
  }

  List<HourlyForecastModel> _initHourlyDataFromVisualCrossingApi() {
    final dayList = _weatherState.weatherModel!.days;

    final updatedHourlyList = <HourlyForecastModel>[];

    final hourlyList = <HourlyData>[];

    for (final dayModel in dayList) {
      hourlyList.addAll(dayModel.hours!);
    }

    for (var i = 0; i <= hourlyList.length - 1; i++) {
      _hourlyData = hourlyList[i];

      _initHourlyTimeValues();

      final referenceTime =  _timezoneUtil.currentReferenceSunTime(
        searchIsLocal: _weatherState.searchIsLocal,
        suntimeList: _weatherState.refererenceSuntimes,
        refTimeEpochInSeconds: _hourlyData.datetimeEpoch,
      );

      final isDay =  _timezoneUtil.getForecastDayOrNight(
        forecastTimeEpochInSeconds: _hourlyData.datetimeEpoch,
        referenceTime: referenceTime,
        searchIsLocal: _weatherState.searchIsLocal,
      );

      final hourlyconditions = _hourlyData.conditions;

      final iconPath = IconController.getIconImagePath(
        condition: hourlyconditions,
        temp: _hourlyData.temp.round(),
        tempUnitsMetric: _weatherState.unitSettings.tempUnitsMetric,
        isDay: isDay,
      );

      _hourModel = HourlyVerticalWidgetModel.fromWeatherData(
        data: _hourlyData,
        iconPath: iconPath,
        unitSettings: _weatherState.unitSettings,
        searchIsLocal: _weatherState.searchIsLocal,
      );

      final startTime =  _timezoneUtil.secondsFromEpoch(
        secondsSinceEpoch: _hourlyData.datetimeEpoch,
        searchIsLocal: _weatherState.searchIsLocal,
      );

      final isNext24Hours = startTime.isAfter(_now) &&
          startTime.isBefore(_now.add(const Duration(hours: 24)));

      if (isNext24Hours) {
        final hourlyForecastModel = HourlyForecastModel.fromWeatherData(
          data: _hourlyData,
          iconPath: iconPath,
          unitSettings: _weatherState.unitSettings,
          searchIsLocal: _weatherState.searchIsLocal,
        );

        updatedHourlyList.add(hourlyForecastModel);
      }

      _sortHourlyHorizontalScrollColumns(
        hour: i,
        temp: _hourlyData.temp.round(),
        isWeatherKit: false,
      );
    }
    return updatedHourlyList;
  }

  void _initReferenceTimes() {
    final time =  _timezoneUtil.secondsFromEpoch(
      secondsSinceEpoch:
          _weatherState.weatherModel!.currentCondition.datetimeEpoch,
      searchIsLocal: _weatherState.searchIsLocal,
    );

    final startingHourInterval = time;

    _day1StartTime =
        startingHourInterval.add(Duration(hours: _hoursUntilNext6am));
    _day2StartTime =
        startingHourInterval.add(Duration(hours: _hoursUntilNext6am + 24));
    _day3StartTime =
        startingHourInterval.add(Duration(hours: _hoursUntilNext6am + 48));
    _day4StartTime =
        startingHourInterval.add(Duration(hours: _hoursUntilNext6am + 72));

    _sunTimes = _weatherState.refererenceSuntimes[0];
  }

  void _initReferenceTimesFromWeatherKit() {
    final time =  _timezoneUtil.localOrOffsetTime(
      dateTime: _weatherState.weather!.currentWeather.asOf,
      searchIsLocal: _weatherState.searchIsLocal,
    );

    final startingHourInterval = time;

    final startTimes = <DateTime>[];

    for (var i = 0; i < 10; i++) {
      startTimes.add(
        startingHourInterval.add(
          Duration(
            hours: _hoursUntilNext6am + (24 * i),
          ),
        ),
      );
    }

    _day1StartTime = startTimes[0];
    _day2StartTime = startTimes[1];
    _day3StartTime = startTimes[2];
    _day4StartTime = startTimes[3];
    _day5StartTime = startTimes[4];
    _day6StartTime = startTimes[5];
    _day7StartTime = startTimes[6];
    _day8StartTime = startTimes[7];
    _day9StartTime = startTimes[8];
    _day10StartTime = startTimes[9];

    _sunTimes = _weatherState.refererenceSuntimes[0];
  }

  void _initHoursUntilNext6am() {
    final searchIsLocal = _weatherState.searchIsLocal;
    if (searchIsLocal) {
      _hoursUntilNext6am = (24 - _nowHour) + 6;
    } else {
      final currentTime =  _timezoneUtil.getCurrentLocalOrRemoteTime(
        searchIsLocal: _weatherState.searchIsLocal,
      );
      final currentHourInSearchCity = currentTime.hour;
      _hoursUntilNext6am = (24 - currentHourInSearchCity) + 6;
    }
  }

  void _initHourlyTimeValues() {
    _startTime =  _timezoneUtil.secondsFromEpoch(
      secondsSinceEpoch: _hourlyData.datetimeEpoch,
      searchIsLocal: _weatherState.searchIsLocal,
    );

    /// accounting for timezones that are offset by 30 minutes to most of the
    /// worlds other timezones
    if (_startTime.minute == 30) {
      _startTime = _startTime.add(const Duration(minutes: 30));
    }
  }

  void _initHourlyTimeValuesFromWeatherKit() {
    _startTime =  _timezoneUtil.localOrOffsetTime(
      dateTime: _hourlyWeatherKitData.forecastStart,
      searchIsLocal: _weatherState.searchIsLocal,
    );

    /// accounting for timezones that are offset by 30 minutes to most of the
    /// worlds other timezones
    if (_startTime.minute == 30) {
      _startTime = _startTime.add(const Duration(minutes: 30));
    }
  }

  void _sortHourlyHorizontalScrollColumns({
    required int hour,
    required int temp,
    required bool isWeatherKit,
  }) {
    log('_sortHourlyHorizontalScrollColumns');
    final nextHour = _startTime.add(const Duration(hours: 1));
    _updateSunTimeValue();

    late DateTime startTime;

    if (isWeatherKit) {
      startTime =  _timezoneUtil.localOrOffsetTime(
        dateTime: _hourlyWeatherKitData.forecastStart,
        searchIsLocal: _weatherState.searchIsLocal,
      );
    } else {
      startTime =  _timezoneUtil.secondsFromEpoch(
        secondsSinceEpoch: _hourlyData.datetimeEpoch,
        searchIsLocal: _weatherState.searchIsLocal,
      );
    }

    final isNext24Hours = startTime.isAfter(_now) &&
        startTime.isBefore(_now.add(const Duration(hours: 24)));

    if (isNext24Hours) {
      _distrubuteToList(hourlyMapKey: _next24Hours, hour: hour, temp: temp);
    }

    final startTimes = <DateTime>[
      _day1StartTime,
      _day2StartTime,
      _day3StartTime,
      _day4StartTime,
      if (!_weatherState.useBackupApi) ...[
        _day5StartTime,
        _day6StartTime,
        _day7StartTime,
        _day8StartTime,
        _day9StartTime,
        _day10StartTime,
      ],
    ];

    final hourlyMapKeys = <String>[
      _day1,
      _day2,
      _day3,
      _day4,
      if (!_weatherState.useBackupApi) ...[
        _day5,
        _day6,
        _day7,
        _day8,
        _day9,
        _day10,
      ],
    ];

    for (var i = 0; i < startTimes.length; i++) {
      if (nextHour.isBetween(
        startTime: startTimes[i],
        endTime: i < startTimes.length - 1
            ? startTimes[i + 1]
            : startTimes[i].add(const Duration(hours: 24)),
        method: 'sortHourly',
      )) {
        _checkForPre6amSunRise(
          sixAM: startTimes[i],
          hourlyMapKey: hourlyMapKeys[i],
        );

        _distrubuteToList(
          temp: temp,
          hour: hour,
          hourlyMapKey: hourlyMapKeys[i],
        );
      }
    }
  }

  /// For when sunrise is before 6am in hourly forecast rows that start at 6am
  void _checkForPre6amSunRise({
    required DateTime sixAM,
    required String hourlyMapKey,
  }) {
    final fourAM = sixAM.subtract(const Duration(hours: 2));

    /// returns true if sunrise is before 6am and _startTime is 6am
    /// so that it will insert the sunrise widget before the regular 6am hourly
    /// widget on the DailyForecastPage
    final isBetween = _sunTimes.sunriseTime!
            .isBetween(startTime: fourAM, endTime: sixAM, method: 'pre5am') &&
        _startTime.isAtSameMomentAs(sixAM);

    if (isBetween) {
      final sunModel = _hourModel.copyWith(
        suntimeString: _sunTimes.sunriseString,
        isSunrise: true,
      );
      _sortedHourlyMap[hourlyMapKey]!.add(sunModel.toMap());
    }
  }

  void _distrubuteToList({
    required String hourlyMapKey,
    required int temp,
    required int hour,
  }) {
    final durationToNextHour = _startTime.minute == 0
        ? const Duration(hours: 1)
        : const Duration(minutes: 30);

    final nextHourRoundedUp = _startTime.add(durationToNextHour);

    _sortedHourlyMap[hourlyMapKey]!.add(_hourModel.toMap());

    /// If a sun time happens to land on an even hour, this replaces the normal
    /// hourly widget with the sun time widget

    if (_sunTimes.sunriseTime!.isSameTime(comparisonTime: _startTime)) {
      _replaceHourlyWithSunTimeWidget(
        key: hourlyMapKey,
        timeString: _sunTimes.sunriseString,
        isSunrise: true,
      );
    }

    if (_sunTimes.sunsetTime!.isSameTime(comparisonTime: _startTime)) {
      _replaceHourlyWithSunTimeWidget(
        key: hourlyMapKey,
        timeString: _sunTimes.sunsetString,
        isSunrise: false,
      );
    }

    final sunriseInBetween = _sunTimes.sunriseTime!.isBetween(
      startTime: _startTime,
      endTime: nextHourRoundedUp,
      method: 'distributeToList',
      offset:  _timezoneUtil.timezoneOffset,
    );

    final sunsetInBetween = _sunTimes.sunsetTime!.isBetween(
      startTime: _startTime,
      endTime: nextHourRoundedUp,
      method: 'distributeToList',
      offset:  _timezoneUtil.timezoneOffset,
    );

    if (sunriseInBetween) {
      final sunModel = _hourModel.copyWith(
        suntimeString: _sunTimes.sunriseString,
        isSunrise: true,
      );
      _sortedHourlyMap[hourlyMapKey]!.add(sunModel.toMap());
    }

    if (sunsetInBetween) {
      final sunModel = _hourModel.copyWith(
        suntimeString: _sunTimes.sunsetString,
        isSunrise: false,
      );

      _sortedHourlyMap[hourlyMapKey]!.add(sunModel.toMap());
    }
  }

  /// Keeps the suntime object in sync with the hourly start times so the
  /// sun times are always being compared to the correct day
  void _updateSunTimeValue() {
    final nextMidnight = _now.endOfDay.add(const Duration(microseconds: 1));

    if (_startTime.isSameDay(_now)) {
      _sunTimes = _weatherState.refererenceSuntimes[0];
    } else if (_startTime.isSameDay(nextMidnight)) {
      _sunTimes = _weatherState.refererenceSuntimes[1];
    } else if (_startTime.isSameDay(
      nextMidnight.add(
        const Duration(days: 1),
      ),
    )) {
      _sunTimes = _weatherState.refererenceSuntimes[2];
    } else if (_startTime.isSameDay(
      nextMidnight.add(
        const Duration(days: 2),
      ),
    )) {
      _sunTimes = _weatherState.refererenceSuntimes[3];
    } else if (_startTime.isSameDay(
      nextMidnight.add(
        const Duration(days: 3),
      ),
    )) {
      _sunTimes = _weatherState.refererenceSuntimes[4];
    } else if (_startTime.isSameDay(
      nextMidnight.add(
        const Duration(days: 4),
      ),
    )) {
      _sunTimes = _weatherState.refererenceSuntimes[5];
    }
  }

  void _replaceHourlyWithSunTimeWidget({
    required String key,
    required String timeString,
    required bool isSunrise,
  }) {
    final list = _sortedHourlyMap[key]!;
    final index = list.length - 1;

    list[index] = _hourModel
        .copyWith(
          isSunrise: isSunrise,
          suntimeString: timeString,
        )
        .toMap();
  }

  void _clearHourlyMap() {
    for (final list in _sortedHourlyMap.values) {
      list.clear();
    }
  }

  @override
  HourlyForecastState? fromJson(Map<String, dynamic> json) {
    return HourlyForecastState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(HourlyForecastState state) {
    return state.toMap();
  }
}
