import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/features/daily_forecast/models/daily_forecast_model.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';

part 'daily_scroll_widget_model.mapper.dart';

@MappableClass()
class DailyScrollWidgetModel with DailyScrollWidgetModelMappable {
  const DailyScrollWidgetModel({
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

  factory DailyScrollWidgetModel.fromDailyModel({
    required DailyForecastModel dailyForecastModel,
    required int index,
    required DateTime startTime,
  }) {
    return DailyScrollWidgetModel(
      header: dailyForecastModel.day,
      iconPath: dailyForecastModel.iconPath,
      temp: dailyForecastModel.dailyTemp,
      lowTemp: dailyForecastModel.lowTemp,
      highTemp: dailyForecastModel.highTemp,
      precipitation:
          dailyForecastModel.precipitationProbability.toInt().toString(),
      month: DateTimeFormatter.getMonthAbbreviation(time: startTime),
      date: dailyForecastModel.date,
      index: index,
    );
  }

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
