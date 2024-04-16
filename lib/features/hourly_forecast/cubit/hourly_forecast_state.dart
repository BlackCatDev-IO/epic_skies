import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/features/hourly_forecast/models/sorted_hourly_list_model/sorted_hourly_list_model.dart';

part 'hourly_forecast_state.mapper.dart';

@MappableClass()
class HourlyForecastState with HourlyForecastStateMappable {
  HourlyForecastState({
    this.sortedHourlyList = const SortedHourlyList(),
  });

  final SortedHourlyList sortedHourlyList;

  static const fromMap = HourlyForecastStateMapper.fromMap;
}
