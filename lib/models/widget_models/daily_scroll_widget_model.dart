import 'package:dart_mappable/dart_mappable.dart';

part 'daily_scroll_widget_model.mapper.dart';

@MappableClass()
class DailyScrollWidgetModel with DailyScrollWidgetModelMappable {
  DailyScrollWidgetModel({
    required this.header,
    required this.iconPath,
    required this.month,
    required this.date,
    required this.temp,
    required this.precipitation,
    required this.index,
    required this.lowTemp,
    required this.highTemp,
  });

  final String header;
  final String iconPath;
  final String month;
  final String date;
  final int temp;
  final String precipitation;
  final int index;
  final int? lowTemp;
  final int? highTemp;

  static const fromMap = DailyScrollWidgetModelMapper.fromMap;
}
