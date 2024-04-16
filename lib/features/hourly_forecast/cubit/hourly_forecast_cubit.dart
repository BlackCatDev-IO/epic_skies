import 'package:dart_date/dart_date.dart';
import 'package:epic_skies/features/hourly_forecast/cubit/hourly_forecast_state.dart';
import 'package:epic_skies/features/hourly_forecast/models/hourly_forecast_model/hourly_forecast_model.dart';
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

  late WeatherState _weatherState;

  late HourlyData _hourlyData;

  late SunTimesModel _sunTimes;

  late DateTime _now;
  late DateTime _startTime;

  final _timezoneUtil = GetIt.I<TimeZoneUtil>();

  /// Sorts all hourly data from WeatherState and updates UI
  Future<void> refreshHourlyData({
    required WeatherState updatedWeatherState,
  }) async {
    _weatherState = updatedWeatherState;
    _now = _timezoneUtil.getCurrentLocalOrRemoteTime(
      searchIsLocal: updatedWeatherState.searchIsLocal,
    );

    late final List<HourlyForecastModel> updatedList;

    if (updatedWeatherState.useBackupApi) {
      updatedList = _initHourlyDataFromVisualCrossingApi();
    } else {
      _initReferenceTimesFromWeatherKit();
      _sunTimes = _weatherState.refererenceSuntimes[0];

      updatedList = _initHourlyWeatherKitData();
    }

    final sortedHourlyList = _sortedHourlyState(
      updatedList,
    );

    emit(sortedHourlyList);
  }

  HourlyForecastState _sortedHourlyState(
    List<HourlyForecastModel> conditions,
  ) {
    final next24Hours = <HourlyForecastModel>[];
    final day1 = <HourlyForecastModel>[];
    final day2 = <HourlyForecastModel>[];
    final day3 = <HourlyForecastModel>[];
    final day4 = <HourlyForecastModel>[];
    final day5 = <HourlyForecastModel>[];
    final day6 = <HourlyForecastModel>[];
    final day7 = <HourlyForecastModel>[];
    final day8 = <HourlyForecastModel>[];
    final day9 = <HourlyForecastModel>[];
    final day10 = <HourlyForecastModel>[];

    final now = _timezoneUtil.getCurrentLocalOrRemoteTime(
      searchIsLocal: _weatherState.searchIsLocal,
    );

    final midnight = DateTime(now.year, now.month, now.day);

    for (final condition in conditions) {
      final difference = condition.time.difference(midnight);
      final days = difference.inDays;

      // Sort into next24Hours based on time before next midnight
      if (condition.time.isAfter(now) && next24Hours.length < 24) {
        next24Hours.add(condition);
      }

      if (days >= 1 && days <= 10) {
        // Add to corresponding day list based on difference in days
        switch (days) {
          case 1:
            day1.add(condition);
          case 2:
            day2.add(condition);
          case 3:
            day3.add(condition);
          case 4:
            day4.add(condition);
          case 5:
            day5.add(condition);
          case 6:
            day6.add(condition);
          case 7:
            day7.add(condition);
          case 8:
            day8.add(condition);
          case 9:
            day9.add(condition);
          case 10:
            day10.add(condition);
        }
      }
    }

    // Sort each day list by forecastStart time (ascending)s
    // Probably not necessary since the data is already sorted coming back from
    // the API
    next24Hours.sort((a, b) => a.time.compareTo(b.time));
    day1.sort((a, b) => a.time.compareTo(b.time));
    day2.sort((a, b) => a.time.compareTo(b.time));
    day3.sort((a, b) => a.time.compareTo(b.time));
    day4.sort((a, b) => a.time.compareTo(b.time));
    day5.sort((a, b) => a.time.compareTo(b.time));
    day6.sort((a, b) => a.time.compareTo(b.time));
    day7.sort((a, b) => a.time.compareTo(b.time));
    day8.sort((a, b) => a.time.compareTo(b.time));
    day9.sort((a, b) => a.time.compareTo(b.time));
    day10.sort((a, b) => a.time.compareTo(b.time));

    return HourlyForecastState(
      next24Hours: next24Hours,
      day1: day1,
      day2: day2,
      day3: day3,
      day4: day4,
      day5: day5,
      day6: day6,
      day7: day7,
      day8: day8,
      day9: day9,
      day10: day10,
    );
  }

  List<HourlyForecastModel> _initHourlyWeatherKitData() {
    final hourlyList = _weatherState.weather!.forecastHourly.hours;

    final updatedHourlyList = <HourlyForecastModel>[];

    for (var i = 0; i <= hourlyList.length - 1; i++) {
      final hourlyWeatherKitData = hourlyList[i];

      final referenceTime = _timezoneUtil.currentReferenceSunTimeFromWeatherKit(
        searchIsLocal: _weatherState.searchIsLocal,
        suntimeList: _weatherState.refererenceSuntimes,
        refTime: hourlyWeatherKitData.forecastStart,
      );

      final isDay = _timezoneUtil.getForecastDayOrNightFromWeatherKit(
        hourlyForecastStart: hourlyWeatherKitData.forecastStart,
        referenceTime: referenceTime,
        searchIsLocal: _weatherState.searchIsLocal,
      );

      final hourlyconditions = hourlyWeatherKitData.conditionCode;

      final iconPath = IconController.getIconImagePath(
        condition: hourlyconditions,
        temp: hourlyWeatherKitData.temperature.round(),
        tempUnitsMetric: _weatherState.unitSettings.tempUnitsMetric,
        isDay: isDay,
      );

      final test = hourlyWeatherKitData.forecastStart;

      final hourlyForecastModel = HourlyForecastModel.fromWeatherKitData(
        iconPath: iconPath,
        unitSettings: _weatherState.unitSettings,
        searchIsLocal: _weatherState.searchIsLocal,
        hourlyData: hourlyWeatherKitData,
      );

      updatedHourlyList.add(hourlyForecastModel);
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

      final referenceTime = _timezoneUtil.currentReferenceSunTime(
        searchIsLocal: _weatherState.searchIsLocal,
        suntimeList: _weatherState.refererenceSuntimes,
        refTimeEpochInSeconds: _hourlyData.datetimeEpoch,
      );

      final isDay = _timezoneUtil.getForecastDayOrNight(
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

      final startTime = _timezoneUtil.secondsFromEpoch(
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
    }
    return updatedHourlyList;
  }

  void _initReferenceTimesFromWeatherKit() {
    _sunTimes = _weatherState.refererenceSuntimes[0];
  }

  void _initHourlyTimeValues() {
    _startTime = _timezoneUtil.secondsFromEpoch(
      secondsSinceEpoch: _hourlyData.datetimeEpoch,
      searchIsLocal: _weatherState.searchIsLocal,
    );

    /// accounting for timezones that are offset by 30 minutes to most of the
    /// worlds other timezones
    if (_startTime.minute == 30) {
      _startTime = _startTime.add(const Duration(minutes: 30));
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
