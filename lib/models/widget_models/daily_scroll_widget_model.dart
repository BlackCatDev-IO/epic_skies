import 'package:equatable/equatable.dart';

class DailyScrollWidgetModel extends Equatable {
  final String header;
  final String iconPath;
  final String month;
  final String date;
  final int temp;
  final num precipitation;
  final int index;

  const DailyScrollWidgetModel({
    required this.header,
    required this.iconPath,
    required this.month,
    required this.date,
    required this.temp,
    required this.precipitation,
    required this.index,
  });

  @override
  List<Object?> get props =>
      [header, iconPath, month, date, temp, precipitation, index];
}
