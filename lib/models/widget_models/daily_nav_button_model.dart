import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_nav_button_model.freezed.dart';
part 'daily_nav_button_model.g.dart';

@freezed
class DailyNavButtonModel with _$DailyNavButtonModel {
  factory DailyNavButtonModel({
    required String day,
    required String month,
    required String date,
    required int index,
  }) = _DailyNavButtonModel;

  factory DailyNavButtonModel.fromJson(Map<String, dynamic> json) =>
      _$DailyNavButtonModelFromJson(json);
}
