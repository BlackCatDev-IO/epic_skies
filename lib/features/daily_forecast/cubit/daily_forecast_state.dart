part of 'daily_forecast_cubit.dart';

@MappableClass()
class DailyForecastState with DailyForecastStateMappable {
  DailyForecastState({
    required this.dailyForecastModelList,
    required this.navButtonModelList,
    required this.dayLabelList,
    required this.minAndMaxTemps,
  });

  factory DailyForecastState.initial() {
    return DailyForecastState(
      dailyForecastModelList: [],
      dayLabelList: [],
      navButtonModelList: [],
      minAndMaxTemps: (0, 100),
    );
  }

  final List<DailyForecastModel> dailyForecastModelList;
  final List<DailyNavButtonModel> navButtonModelList;
  final List<String> dayLabelList;
  final (int minTemp, int maxTemp) minAndMaxTemps;

  static const fromMap = DailyForecastStateMapper.fromMap;
}
