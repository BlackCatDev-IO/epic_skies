import 'package:black_cat_lib/extensions/num_extensions.dart';
import 'package:epic_skies/core/network/weather_kit/models/daily/day_weather_conditions.dart';
import 'package:epic_skies/features/daily_forecast/cubit/daily_forecast_state.dart';
import 'package:epic_skies/features/daily_forecast/models/daily_forecast_model.dart';
import 'package:epic_skies/features/hourly_forecast/cubit/hourly_forecast_cubit.dart';
import 'package:epic_skies/features/hourly_forecast/models/hourly_forecast_model/hourly_forecast_model.dart';
import 'package:epic_skies/features/location/bloc/location_state.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/daily_data/daily_data_model.dart';
import 'package:epic_skies/models/widget_models/daily_nav_button_model.dart';
import 'package:epic_skies/models/widget_models/daily_scroll_widget_model.dart';
import 'package:epic_skies/services/logging_service.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class DailyForecastCubit extends HydratedCubit<DailyForecastState> {
  DailyForecastCubit() : super(DailyForecastState.initial());

  late DayWeatherConditions _weatherKitDailyData;

  late DailyData _data;

  late WeatherState _weatherState;

  late LocationState _locationState;

  late Duration _timezoneOffset;

  late DateTime _now;

  Future<void> refreshDailyData({
    required WeatherState updatedWeatherState,
    required HourlyForecastState sortedHourlyList,
    required LocationState locationState,
  }) async {
    _weatherState = updatedWeatherState;
    _now = _weatherState.refTimes.now!;
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
    final dayColumnModelList = <DailyScrollWidgetModel>[];
    final dailyForecastModelList = <DailyForecastModel>[];
    for (var i = 0; i < weather!.forecastDaily.days.length; i++) {
      _weatherKitDailyData = weather.forecastDaily.days[i];

      final dailyForecastStart = _weatherState.searchIsLocal
          ? _weatherKitDailyData.forecastStart.toLocal().toUtc()
          : _weatherKitDailyData.forecastStart.add(_timezoneOffset).toUtc();

      if (_isSameDayOrBefore(dailyForecastStart)) {
        continue;
      }

      final dailyForecastModel = DailyForecastModel.fromWeatherKit(
        data: _weatherKitDailyData,
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
          ? _weatherKitDailyData.forecastStart.toLocal().toUtc()
          : _weatherKitDailyData.forecastStart.add(_timezoneOffset).toUtc();

      final dayColumnModel = DailyScrollWidgetModel.fromDailyModel(
        dailyForecastModel: dailyForecastModel,
        startTime: startTime,
      );

      final dailyNavButtonModel = DailyNavButtonModel(
        day: dailyForecastModel.day,
        month: DateTimeFormatter.getMonthAbbreviation(time: startTime),
        date: dailyForecastModel.date,
        isSelected: navButtonModelList.isEmpty,
      );

      navButtonModelList.add(dailyNavButtonModel);

      dayColumnModelList.add(dayColumnModel);
      dailyForecastModelList.add(dailyForecastModel);
    }

    emit(
      state.copyWith(
        dayLabelList: dayLabelList,
        dailyForecastModelList: dailyForecastModelList,
        dayColumnModelList: dayColumnModelList,
        navButtonModelList: navButtonModelList,
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
    final dayColumnModelList = <DailyScrollWidgetModel>[];
    final dailyForecastModelList = <DailyForecastModel>[];

    for (var i = 0; i < weatherModel!.days.length - 1; i++) {
      _data = weatherModel.days[i];

      final startTime =
          DateTime.fromMillisecondsSinceEpoch(_data.datetimeEpoch * 1000)
              .add(_timezoneOffset);

      if (startTime.day == _now.day) {
        continue;
      }

      final dailyForecastModel = DailyForecastModel.fromVisualCrossingApi(
        data: _data,
        index: i,
        currentTime: _now,
        hourlyList: _dailyHourList(
          index: i,
          sortedHourlyList: sortedHourlyList,
        ),
        suntime: _weatherState.refTimes.refererenceSuntimes[i],
        unitSettings: _weatherState.unitSettings,
      );

      dayLabelList.add(dailyForecastModel.day);

      final lowTemp = _data.tempmin?.round() ?? dailyForecastModel.dailyTemp;
      final highTemp = _data.tempmax?.round() ?? dailyForecastModel.dailyTemp;

      final dayColumnModel = DailyScrollWidgetModel(
        header: dailyForecastModel.day,
        iconPath: dailyForecastModel.iconPath,
        temp: dailyForecastModel.dailyTemp,
        lowTemp: lowTemp,
        highTemp: highTemp,
        precipitation:
            dailyForecastModel.precipitationProbability.round().toString(),
        month: DateTimeFormatter.getMonthAbbreviation(time: startTime),
        date: dailyForecastModel.date,
      );

      final dailyNavButtonModel = DailyNavButtonModel(
        day: dailyForecastModel.day,
        month: DateTimeFormatter.getMonthAbbreviation(time: startTime),
        date: dailyForecastModel.date,
      );

      if (i.isInRange(0, 10)) {
        navButtonList.add(dailyNavButtonModel);
      }

      dayColumnModelList.add(dayColumnModel);
      dailyForecastModelList.add(dailyForecastModel);
    }

    emit(
      state.copyWith(
        dayLabelList: dayLabelList,
        dailyForecastModelList: dailyForecastModelList,
        dayColumnModelList: dayColumnModelList,
        navButtonModelList: navButtonList,
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

  List<HourlyForecastModel> _dailyHourList({
    required int index,
    required HourlyForecastState sortedHourlyList,
  }) {
    if (index == 0) {
      getIt<LoggingService>().log(
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
