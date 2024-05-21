import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/core/error_handling/error_model.dart';
import 'package:epic_skies/core/network/weather_kit/models/weather/weather.dart';
import 'package:epic_skies/features/main_weather/models/alert_model/alert_model.dart';
import 'package:epic_skies/features/main_weather/models/reference_times_model/reference_times_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
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
    this.weatherModel,
    this.weather,
    this.refTimes = const ReferenceTimesModel(),
    this.useBackupApi = false,
    this.searchIsLocal = true,
    this.unitSettings = const UnitSettings(),
    this.alertModel = const AlertModel.none(),
    this.errorModel,
  });

  final WeatherStatus status;
  final WeatherResponseModel? weatherModel;
  final Weather? weather;
  final bool searchIsLocal;
  final UnitSettings unitSettings;
  final ReferenceTimesModel refTimes;
  final bool useBackupApi;
  final AlertModel alertModel;
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
