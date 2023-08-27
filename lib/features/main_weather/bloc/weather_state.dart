import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/core/error_handling/error_model.dart';
import 'package:epic_skies/core/network/weather_kit/models/alerts/weather_alert_collection.dart';
import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';

part 'weather_state.mapper.dart';

@MappableEnum()
enum WeatherStatus { initial, loading, success, unitSettingsUpdate, error }

extension WeatherStatusX on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isUnitSettingsUpdate => this == WeatherStatus.unitSettingsUpdate;
  bool get isError => this == WeatherStatus.error;
}

@MappableClass()
class WeatherState with WeatherStateMappable {
  const WeatherState({
    this.status = WeatherStatus.initial,
    // this.weatherModel,
    this.weather,
    this.alerts = const WeatherAlertCollection(),
    this.isDay = true,
    this.searchIsLocal = true,
    this.refererenceSuntimes = const [],
    this.unitSettings = const UnitSettings(),
    this.errorModel,
  });

  // final WeatherResponseModel? weatherModel;
  final Weather? weather;
  final WeatherStatus status;
  final bool searchIsLocal;
  final UnitSettings unitSettings;
  final List<SunTimesModel> refererenceSuntimes;
  final bool isDay;
  final WeatherAlertCollection? alerts;
  final ErrorModel? errorModel;

  static const fromMap = WeatherStateMapper.fromMap;

  @override
  String toString() {
    final errorModelString = errorModel == null ? '' : 'error: $errorModel';

    final currentCondition = weather?.currentWeather.conditionCode ?? '';

    return '''
Status: $status $errorModelString currentCondition: $currentCondition
''';
  }
}
