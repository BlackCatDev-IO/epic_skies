import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/widget_models/daily_nav_button_model.dart';
import '../../../models/widget_models/daily_scroll_widget_model.dart';
import '../models/daily_forecast_model.dart';

part 'daily_forecast_state.freezed.dart';
part 'daily_forecast_state.g.dart';

@freezed
class DailyForecastState with _$DailyForecastState {
  const factory DailyForecastState({
    required List<DailyScrollWidgetModel> dayColumnModelList,
    required List<DailyForecastModel> dailyForecastModelList,
    required List<DailyNavButtonModel> week1NavButtonList,
    required List<DailyNavButtonModel> week2NavButtonList,
    required List<String> dayLabelList,
    required List<bool> selectedDayList,
    required int selectedDayIndex,
  }) = _DailyForecastState;

  factory DailyForecastState.initial() {
    final selectedDayList = <bool>[];

    for (int i = 0; i <= 13; i++) {
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

  factory DailyForecastState.fromJson(Map<String, dynamic> json) =>
      _$DailyForecastStateFromJson(json);
}
