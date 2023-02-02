import 'package:black_cat_lib/extensions/num_extensions.dart';
import 'package:epic_skies/features/daily_forecast/cubit/daily_forecast_state.dart';
import 'package:epic_skies/features/daily_forecast/models/daily_forecast_model.dart';
import 'package:epic_skies/features/hourly_forecast/models/hourly_vertical_widget_model/hourly_vertical_widget_model.dart';
import 'package:epic_skies/features/hourly_forecast/models/sorted_hourly_list_model/sorted_hourly_list_model.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/daily_data/daily_data_model.dart';
import 'package:epic_skies/models/widget_models/daily_nav_button_model.dart';
import 'package:epic_skies/models/widget_models/daily_scroll_widget_model.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class DailyForecastCubit extends HydratedCubit<DailyForecastState> {
  DailyForecastCubit() : super(DailyForecastState.initial());

  late DailyData _data;

  late WeatherState _weatherState;

  Future<void> refreshDailyData({
    required WeatherState updatedWeatherState,
    required SortedHourlyList sortedHourlyList,
  }) async {
    _weatherState = updatedWeatherState;

    _builDailyModels(sortedHourlyList);
  }

  void _builDailyModels(SortedHourlyList sortedHourlyList) {
    final weatherModel = _weatherState.weatherModel;
    final dayLabelList = <String>[];
    final week1NavButtonList = <DailyNavButtonModel>[];
    final week2NavButtonList = <DailyNavButtonModel>[];
    final dayColumnModelList = <DailyScrollWidgetModel>[];
    final dailyForecastModelList = <DailyForecastModel>[];
    for (var i = 0; i < weatherModel!.days.length - 1; i++) {
      final interval = _initDailyInterval(i);
      _data = weatherModel.days[interval];

      final dailyForecastModel = DailyForecastModel.fromWeatherData(
        data: _data,
        index: interval,
        currentTime: TimeZoneUtil.getCurrentLocalOrRemoteTime(
          searchIsLocal: _weatherState.searchIsLocal,
        ),
        extendedHourlyList:
            _hourlyForecastMapKey(index: i, sortedHourlyList: sortedHourlyList),
        suntime: _weatherState.refererenceSuntimes[interval],
        unitSettings: _weatherState.unitSettings,
      );

      dayLabelList.add(dailyForecastModel.day);

      final startTime = TimeZoneUtil.secondsFromEpoch(
        secondsSinceEpoch: _data.datetimeEpoch,
        searchIsLocal: _weatherState.searchIsLocal,
      );

      final dayColumnModel = DailyScrollWidgetModel(
        header: dailyForecastModel.day,
        iconPath: dailyForecastModel.iconPath,
        temp: dailyForecastModel.dailyTemp,
        precipitation: dailyForecastModel.precipitationProbability,
        month: DateTimeFormatter.getMonthAbbreviation(time: startTime),
        date: dailyForecastModel.date,
        index: i,
      );

      final dailyNavButtonModel = DailyNavButtonModel(
        day: dailyForecastModel.day,
        month: DateTimeFormatter.getMonthAbbreviation(time: startTime),
        date: dailyForecastModel.date,
        index: i,
      );

      if (i.isInRange(0, 6)) {
        week1NavButtonList.add(dailyNavButtonModel);
      } else if (i.isInRange(7, 13)) {
        week2NavButtonList.add(dailyNavButtonModel);
      }

      dayColumnModelList.add(dayColumnModel);
      dailyForecastModelList.add(dailyForecastModel);
    }

    emit(
      state.copyWith(
        dayLabelList: dayLabelList,
        dailyForecastModelList: dailyForecastModelList,
        dayColumnModelList: dayColumnModelList,
        week1NavButtonList: week1NavButtonList,
        week2NavButtonList: week2NavButtonList,
      ),
    );
  }

  /// between 12am and 6am day @ index 0 is yesterday due to Tomorrow.io
  /// defining days from 6am to 6am, this accounts for that
  int _initDailyInterval(int i) {
    final searchIsLocal = _weatherState.searchIsLocal;
    var interval = i + 1;
    if (TimeZoneUtil.isBetweenMidnightAnd6Am(searchIsLocal: searchIsLocal)) {
      return interval++;
    } else {
      return interval;
    }
  }

  void updateSelectedDayStatus({required int index}) {
    final selectedDayList = [...state.selectedDayList];
    for (var i = 0; i <= 13; i++) {
      if (index == i) {
        selectedDayList[i] = true;
      } else {
        selectedDayList[i] = false;
      }
    }
    emit(state.copyWith(selectedDayList: selectedDayList));
  }

  void updatedSelectedDayIndex(int index) {
    emit(state.copyWith(selectedDayIndex: index));
  }

  /// Returns null after 4 because a null value tells the DailyDetailWidget
  /// not to try and build the extended hourly forecast as there is no data
  /// available past 108 hours
  List<HourlyVerticalWidgetModel>? _hourlyForecastMapKey({
    required int index,
    required SortedHourlyList sortedHourlyList,
  }) {
    switch (index) {
      case 0:
        return sortedHourlyList.day1;
      case 1:
        return sortedHourlyList.day2;
      case 2:
        return sortedHourlyList.day3;
      case 3:
        return sortedHourlyList.day4;

      default:
        return null;
    }
  }

  @override
  DailyForecastState? fromJson(Map<String, dynamic> json) {
    return DailyForecastState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(DailyForecastState state) {
    return state.toJson();
  }
}
