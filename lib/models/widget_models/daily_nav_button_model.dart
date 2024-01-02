import 'package:dart_mappable/dart_mappable.dart';

part 'daily_nav_button_model.mapper.dart';

@MappableClass()
class DailyNavButtonModel with DailyNavButtonModelMappable {
  DailyNavButtonModel({
    required this.day,
    required this.month,
    required this.date,
    required this.index,
  });

  final String day;
  final String month;
  final String date;
  final int index;

  static const fromMap = DailyNavButtonModelMapper.fromMap;
}
