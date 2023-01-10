part of 'weather_bloc.dart';

enum WeatherStatus { initial, loading, success, unitSettingsUpdate, error }

extension WeatherStatusX on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isUnitSettingsUpdate => this == WeatherStatus.unitSettingsUpdate;
  bool get isError => this == WeatherStatus.error;
}

class WeatherState extends Equatable {
  const WeatherState({
    required this.unitSettings,
    this.weatherModel,
    this.status = WeatherStatus.initial,
    this.isLoading = false,
    this.searchIsLocal = true,
    this.searchButtonModel = const SearchLocalWeatherButtonModel(
      temp: 0,
      condition: '',
      isDay: true,
      tempUnitsMetric: true,
    ),
  });

  final WeatherResponseModel? weatherModel;

  final WeatherStatus status;

  final bool isLoading;

  final bool searchIsLocal;

  final UnitSettings unitSettings;

  final SearchLocalWeatherButtonModel searchButtonModel;

  @override
  List<Object?> get props => [
        weatherModel,
        status,
        isLoading,
        searchIsLocal,
        unitSettings,
      ];

  WeatherState copyWith({
    required WeatherStatus status,
    WeatherResponseModel? weatherModel,
    bool? isLoading,
    bool? searchIsLocal,
    UnitSettings? unitSettings,
    SearchLocalWeatherButtonModel? searchButtonModel,
  }) {
    return WeatherState(
      status: status,
      weatherModel: weatherModel ?? this.weatherModel,
      isLoading: isLoading ?? this.isLoading,
      searchIsLocal: searchIsLocal ?? this.searchIsLocal,
      unitSettings: unitSettings ?? this.unitSettings,
      searchButtonModel: searchButtonModel ?? this.searchButtonModel,
    );
  }
}
