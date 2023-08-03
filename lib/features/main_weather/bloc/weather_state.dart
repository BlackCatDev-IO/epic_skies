import 'package:dart_mappable/dart_mappable.dart';
import 'package:epic_skies/core/error_handling/error_model.dart';
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
    this.weatherModel,
    this.isDay = true,
    this.searchIsLocal = true,
    this.refererenceSuntimes = const [],
    this.unitSettings = const UnitSettings(),
    this.errorModel,
  });

  factory WeatherState.error({
    required Exception exception,
  }) =>
      WeatherState(
        status: WeatherStatus.error,
        errorModel: ErrorModel.fromException(exception),
      );

  final WeatherResponseModel? weatherModel;
  final WeatherStatus status;
  final bool searchIsLocal;
  final UnitSettings unitSettings;
  final List<SunTimesModel> refererenceSuntimes;
  final bool isDay;
  final ErrorModel? errorModel;

  static const fromMap = WeatherStateMapper.fromMap;

  @override
  String toString() {
    final errorModelString = errorModel == null ? '' : 'error: $errorModel';

    final currentCondition = weatherModel?.currentCondition.conditions;

    return '''
Status: $status $errorModelString currentCondition: $currentCondition
''';
  }
}
