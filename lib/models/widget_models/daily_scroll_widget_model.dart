import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_scroll_widget_model.freezed.dart';
part 'daily_scroll_widget_model.g.dart';

@freezed
class DailyScrollWidgetModel with _$DailyScrollWidgetModel {
  factory DailyScrollWidgetModel({
    required String header,
    required String iconPath,
    required String month,
    required String date,
    required int temp,
    required num precipitation,
    required int index,
    int? highTemp,
    int? lowTemp,
  }) = _DailyScrollWidgetModel;

  factory DailyScrollWidgetModel.fromJson(Map<String, dynamic> json) =>
      _$DailyScrollWidgetModelFromJson(json);
}
