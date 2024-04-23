import 'package:dart_mappable/dart_mappable.dart';

part 'daily_nav_button_model.mapper.dart';

@MappableClass()
class DailyNavButtonModel with DailyNavButtonModelMappable {
  DailyNavButtonModel({
    required this.day,
    required this.month,
    required this.date,
    this.isSelected = false,
    this.autoScroll = false,
  });

  final String day;
  final String month;
  final int date;
  final bool isSelected;
  final bool autoScroll;

  static const fromMap = DailyNavButtonModelMapper.fromMap;
}
