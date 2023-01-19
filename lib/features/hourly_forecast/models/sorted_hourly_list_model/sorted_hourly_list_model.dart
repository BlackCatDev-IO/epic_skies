import 'package:freezed_annotation/freezed_annotation.dart';

import '../hourly_vertical_widget_model/hourly_vertical_widget_model.dart';

part 'sorted_hourly_list_model.freezed.dart';
part 'sorted_hourly_list_model.g.dart';

@freezed
class SortedHourlyList with _$SortedHourlyList {
 const factory SortedHourlyList({
    @Default([]) List<HourlyVerticalWidgetModel> next24Hours,
    @Default([]) List<HourlyVerticalWidgetModel> day1,
    @Default([]) List<HourlyVerticalWidgetModel> day2,
    @Default([]) List<HourlyVerticalWidgetModel> day3,
    @Default([]) List<HourlyVerticalWidgetModel> day4,
  }) = _SortedHourlyList;

  factory SortedHourlyList.fromJson(Map<String, dynamic> json) =>
      _$SortedHourlyListFromJson(json);
}
