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
    required this.navButtonModelList,
    required this.dayLabelList,
  });

  factory DailyForecastState.initial() {
    return DailyForecastState(
      dailyForecastModelList: [],
      dayColumnModelList: [],
      dayLabelList: [],
      navButtonModelList: [],
    );
  }

  final List<DailyScrollWidgetModel> dayColumnModelList;
  final List<DailyForecastModel> dailyForecastModelList;
  final List<DailyNavButtonModel> navButtonModelList;
  final List<String> dayLabelList;

  static const fromMap = DailyForecastStateMapper.fromMap;
}
