import 'package:epic_skies/features/hourly_forecast/models/sorted_hourly_list_model/sorted_hourly_list_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/hourly_forecast_model/hourly_forecast_model.dart';

part 'hourly_forecast_state.freezed.dart';
part 'hourly_forecast_state.g.dart';

@freezed
class HourlyForecastState with _$HourlyForecastState {
  factory HourlyForecastState({
    @Default([]) List<HourlyForecastModel> houryForecastModelList,
    @Default(SortedHourlyList()) SortedHourlyList sortedHourlyList,
  }) = _HourlyForecastState;

  factory HourlyForecastState.fromJson(Map<String, dynamic> json) =>
      _$HourlyForecastStateFromJson(json);
}
