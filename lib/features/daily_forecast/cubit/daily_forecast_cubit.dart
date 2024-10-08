import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/extensions/num_extensions.dart';
import 'package:epic_skies/features/daily_forecast/models/daily_forecast_model.dart';
import 'package:epic_skies/features/daily_forecast/models/daily_nav_button_model.dart';
import 'package:epic_skies/features/hourly_forecast/cubit/hourly_forecast_cubit.dart';
import 'package:epic_skies/features/hourly_forecast/models/hourly_forecast_model/hourly_forecast_model.dart';
import 'package:epic_skies/features/location/bloc/location_state.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/remote_logging_service.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'daily_forecast_cubit.mapper.dart';
part 'daily_forecast_state.dart';

class DailyForecastCubit extends HydratedCubit<DailyForecastState> {
  DailyForecastCubit() : super(DailyForecastState.initial());

  late WeatherState _weatherState;

  late LocationState _locationState;

  late Duration _timezoneOffset;

  Future<void> refreshDailyData({
    required WeatherState updatedWeatherState,
    required HourlyForecastState sortedHourlyList,
    required LocationState locationState,
  }) async {
    _weatherState = updatedWeatherState;
    _locationState = locationState;
    _timezoneOffset = Duration(
      milliseconds: _weatherState.refTimes.timezoneOffsetInMs,
    );

    if (_weatherState.useBackupApi) {
      _builDailyModelFromVisualCrossingApi(sortedHourlyList);
    } else {
      _builDailyWeatherKitModels(sortedHourlyList);
    }
  }

  void _builDailyWeatherKitModels(HourlyForecastState sortedHourlyList) {
    final weather = _weatherState.weather;
    final dayLabelList = <String>[];
    final navButtonModelList = <DailyNavButtonModel>[];
    final dailyForecastModelList = <DailyForecastModel>[];
    for (var i = 0; i < weather!.forecastDaily.days.length; i++) {
      final weatherKitDailyData = weather.forecastDaily.days[i];

      final dailyForecastStart = _weatherState.searchIsLocal
          ? weatherKitDailyData.forecastStart.toLocal().toUtc()
          : weatherKitDailyData.forecastStart.add(_timezoneOffset).toUtc();

      if (_isSameDayOrBefore(dailyForecastStart)) {
        continue;
      }

      final dailyForecastModel = DailyForecastModel.fromWeatherKit(
        data: weatherKitDailyData,
        index: i,
        currentTime: _weatherState.refTimes.now!,
        hourlyList: _dailyHourList(
          index: i,
          sortedHourlyList: sortedHourlyList,
        ),
        suntime: _weatherState.refTimes.refererenceSuntimes[i],
        unitSettings: _weatherState.unitSettings,
      );

      dayLabelList.add(dailyForecastModel.day);

      final startTime = _weatherState.searchIsLocal
          ? weatherKitDailyData.forecastStart.toLocal().toUtc()
          : weatherKitDailyData.forecastStart.add(_timezoneOffset).toUtc();

      final dailyNavButtonModel = DailyNavButtonModel(
        day: dailyForecastModel.day,
        month: DateTimeFormatter.getMonthAbbreviation(time: startTime),
        date: dailyForecastModel.date,
        isSelected: navButtonModelList.isEmpty,
      );

      navButtonModelList.add(dailyNavButtonModel);

      dailyForecastModelList.add(dailyForecastModel);
    }

    final minAndMaxTemp = _minAndMaxDailyTemps(dailyForecastModelList);

    emit(
      state.copyWith(
        dayLabelList: dayLabelList,
        dailyForecastModelList: dailyForecastModelList,
        navButtonModelList: navButtonModelList,
        minAndMaxTemps: minAndMaxTemp,
      ),
    );
  }

  bool _isSameDayOrBefore(DateTime forecastStart) {
    final now = DateTime.utc(
      _weatherState.refTimes.now!.year,
      _weatherState.refTimes.now!.month,
      _weatherState.refTimes.now!.day,
    );

    final forecastStartDay = DateTime.utc(
      forecastStart.year,
      forecastStart.month,
      forecastStart.day,
    );

    return forecastStartDay.isBefore(now) ||
        now.isAtSameMomentAs(forecastStartDay);
  }

  void _builDailyModelFromVisualCrossingApi(
    HourlyForecastState sortedHourlyList,
  ) {
    final weatherModel = _weatherState.weatherModel;
    final dayLabelList = <String>[];
    final navButtonList = <DailyNavButtonModel>[];
    final dailyForecastModelList = <DailyForecastModel>[];

    for (var i = 0; i < weatherModel!.days.length - 1; i++) {
      final data = weatherModel.days[i];

      final startTime =
          DateTime.fromMillisecondsSinceEpoch(data.datetimeEpoch * 1000)
              .add(_timezoneOffset);

      if (_isSameDayOrBefore(startTime)) {
        continue;
      }

      final dailyForecastModel = DailyForecastModel.fromVisualCrossingApi(
        data: data,
        index: i,
        currentTime: _weatherState.refTimes.now!,
        hourlyList: _dailyHourList(
          index: i,
          sortedHourlyList: sortedHourlyList,
        ),
        suntime: _weatherState.refTimes.refererenceSuntimes[i],
        unitSettings: _weatherState.unitSettings,
      );

      dayLabelList.add(dailyForecastModel.day);

      final dailyNavButtonModel = DailyNavButtonModel(
        day: dailyForecastModel.day,
        month: DateTimeFormatter.getMonthAbbreviation(time: startTime),
        date: dailyForecastModel.date,
      );

      if (i.isInRange(0, 10)) {
        navButtonList.add(dailyNavButtonModel);
      }

      dailyForecastModelList.add(dailyForecastModel);
    }

    final minAndMaxTemp = _minAndMaxDailyTemps(dailyForecastModelList);

    emit(
      state.copyWith(
        dayLabelList: dayLabelList,
        dailyForecastModelList: dailyForecastModelList,
        navButtonModelList: navButtonList,
        minAndMaxTemps: minAndMaxTemp,
      ),
    );
  }

  void updatedSelectedDay(int day, {bool autoScroll = false}) {
    final updatedList = state.navButtonModelList
        .map(
          (dayModel) => dayModel.copyWith(
            isSelected: dayModel.date == day,
            autoScroll: autoScroll,
          ),
        )
        .toList();

    emit(state.copyWith(navButtonModelList: updatedList));
  }

  (int minTemp, int maxTemp) _minAndMaxDailyTemps(
    List<DailyForecastModel> dailyList,
  ) {
    final minTemperature = dailyList
        .map((forecast) => forecast.lowTemp ?? 0)
        .reduce((a, b) => a < b ? a : b);

    final maxTemperature = dailyList
        .map((forecast) => forecast.highTemp ?? 100)
        .reduce((a, b) => a > b ? a : b);

    return (minTemperature, maxTemperature);
  }

  List<HourlyForecastModel> _dailyHourList({
    required int index,
    required HourlyForecastState sortedHourlyList,
  }) {
    if (index == 0) {
      getIt<RemoteLoggingService>().log(
        'DailyForecastCubit._dailyHourList',
        data: {
          'index': index,
          'weather': _weatherState.toMap(),
          'location': _locationState.toMap(),
        },
      );
    }

    final hourlyLists = <List<HourlyForecastModel>>[
      sortedHourlyList.day1,
      sortedHourlyList.day2,
      sortedHourlyList.day3,
      sortedHourlyList.day4,
      sortedHourlyList.day5,
      sortedHourlyList.day6,
      sortedHourlyList.day7,
      sortedHourlyList.day8,
      sortedHourlyList.day9,
      sortedHourlyList.day10,
    ];

    // If WeatherKit call fails and the backup API is used, the Visual Crossing
    // API returns 14 days (vs WeatherKit returning 10 days) and will exceed the
    // amount of hours in the [SortedHourlyList]
    if (index >= 10) {
      return [];
    }

    // Today is skipped before passing in the `sortedHourlyList`, so -1 is
    // needed to keep the hours in sync with the daily forecast
    return hourlyLists[index - 1];
  }

  @override
  DailyForecastState? fromJson(Map<String, dynamic> json) {
    return DailyForecastState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(DailyForecastState state) {
    return state.toMap();
  }
}
