import 'package:dart_mappable/dart_mappable.dart';

import 'package:epic_skies/features/daily_forecast/models/daily_forecast_model.dart';
import 'package:epic_skies/models/widget_models/daily_nav_button_model.dart';
import 'package:epic_skies/models/widget_models/daily_scroll_widget_model.dart';

part 'daily_forecast_state.mapper.dart';

@MappableClass()
class DailyForecastState with DailyForecastStateMappable {
  DailyForecastState({
    required this.dayColumnModelList,
    required this.dailyForecastModelList,
    required this.week1NavButtonList,
    required this.week2NavButtonList,
    required this.dayLabelList,
    required this.selectedDayList,
    required this.selectedDayIndex,
  });

  factory DailyForecastState.initial() {
    final selectedDayList = <bool>[];

    for (var i = 0; i <= 13; i++) {
      if (i == 0) {
        selectedDayList.add(true);
      } else {
        selectedDayList.add(false);
      }
    }

    return DailyForecastState(
      selectedDayList: selectedDayList,
      selectedDayIndex: 0,
      dailyForecastModelList: [],
      dayColumnModelList: [],
      dayLabelList: [],
      week1NavButtonList: [],
      week2NavButtonList: [],
    );
  }

  final List<DailyScrollWidgetModel> dayColumnModelList;
  final List<DailyForecastModel> dailyForecastModelList;
  final List<DailyNavButtonModel> week1NavButtonList;
  final List<DailyNavButtonModel> week2NavButtonList;
  final List<String> dayLabelList;
  final List<bool> selectedDayList;
  final int selectedDayIndex;

  static const fromMap = DailyForecastStateMapper.fromMap;
}
