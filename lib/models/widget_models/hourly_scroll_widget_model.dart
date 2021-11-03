import 'package:equatable/equatable.dart';

class HourlyScrollWidgetModel extends Equatable {
  final int temp;
  final String iconPath;
  final num precipitation;
  final String header;

  const HourlyScrollWidgetModel({
    required this.temp,
    required this.iconPath,
    required this.precipitation,
    required this.header,
  });

  @override
  List<Object?> get props => [temp, iconPath, precipitation, header];
}
