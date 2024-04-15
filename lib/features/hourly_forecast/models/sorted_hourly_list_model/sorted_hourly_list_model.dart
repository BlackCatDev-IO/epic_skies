import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/features/hourly_forecast/models/hourly_forecast_model/hourly_forecast_model.dart';

part 'sorted_hourly_list_model.mapper.dart';

@MappableClass()
class SortedHourlyList with SortedHourlyListMappable {
  const SortedHourlyList({
    this.next24Hours = const [],
    this.day1 = const [],
    this.day2 = const [],
    this.day3 = const [],
    this.day4 = const [],
    this.day5 = const [],
    this.day6 = const [],
    this.day7 = const [],
    this.day8 = const [],
    this.day9 = const [],
    this.day10 = const [],
  });

  final List<HourlyForecastModel> next24Hours;
  final List<HourlyForecastModel> day1;
  final List<HourlyForecastModel> day2;
  final List<HourlyForecastModel> day3;
  final List<HourlyForecastModel> day4;
  final List<HourlyForecastModel> day5;
  final List<HourlyForecastModel> day6;
  final List<HourlyForecastModel> day7;
  final List<HourlyForecastModel> day8;
  final List<HourlyForecastModel> day9;
  final List<HourlyForecastModel> day10;

  static const fromMap = SortedHourlyListMapper.fromMap;
}
