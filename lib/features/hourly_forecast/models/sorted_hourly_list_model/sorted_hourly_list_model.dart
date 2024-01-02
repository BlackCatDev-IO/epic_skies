import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/features/hourly_forecast/models/hourly_vertical_widget_model/hourly_vertical_widget_model.dart';

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

  final List<HourlyVerticalWidgetModel> next24Hours;
  final List<HourlyVerticalWidgetModel> day1;
  final List<HourlyVerticalWidgetModel> day2;
  final List<HourlyVerticalWidgetModel> day3;
  final List<HourlyVerticalWidgetModel> day4;
  final List<HourlyVerticalWidgetModel> day5;
  final List<HourlyVerticalWidgetModel> day6;
  final List<HourlyVerticalWidgetModel> day7;
  final List<HourlyVerticalWidgetModel> day8;
  final List<HourlyVerticalWidgetModel> day9;
  final List<HourlyVerticalWidgetModel> day10;

  static const fromMap = SortedHourlyListMapper.fromMap;
}
