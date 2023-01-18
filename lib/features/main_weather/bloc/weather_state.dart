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
    this.unitSettings = const UnitSettings(
      tempUnitsMetric: false,
      timeIn24Hrs: false,
      precipInMm: false,
      speedInKph: false,
    ),
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
    this.refererenceSuntimes = const [],
    this.isDay = true,
  });

  final WeatherResponseModel? weatherModel;

  final WeatherStatus status;

  final bool isLoading;

  final bool searchIsLocal;

  final UnitSettings unitSettings;

  final SearchLocalWeatherButtonModel searchButtonModel;

  final List<SunTimesModel> refererenceSuntimes;

  final bool isDay;

  @override
  List<Object?> get props => [
        weatherModel,
        status,
        isLoading,
        searchIsLocal,
        unitSettings,
        searchButtonModel,
        refererenceSuntimes,
        isDay
      ];

  WeatherState copyWith({
    WeatherResponseModel? weatherModel,
    WeatherStatus? status,
    bool? isLoading,
    bool? searchIsLocal,
    UnitSettings? unitSettings,
    SearchLocalWeatherButtonModel? searchButtonModel,
    List<SunTimesModel>? refererenceSuntimes,
    bool? isDay,
  }) {
    return WeatherState(
      weatherModel: weatherModel ?? this.weatherModel,
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      searchIsLocal: searchIsLocal ?? this.searchIsLocal,
      unitSettings: unitSettings ?? this.unitSettings,
      searchButtonModel: searchButtonModel ?? this.searchButtonModel,
      refererenceSuntimes: refererenceSuntimes ?? this.refererenceSuntimes,
      isDay: isDay ?? this.isDay,
    );
  }

  Map<String, dynamic>? toJson() {
    return {
      'weatherModel': weatherModel?.toMap(),
      'status': EnumToString.convertToString(status),
      'isLoading': isLoading,
      'searchIsLocal': searchIsLocal,
      'unitSettings': unitSettings.toJson(),
      'searchButtonModel': searchButtonModel.toMap(),
      'refererenceSuntimes': refererenceSuntimes.map((x) => x.toJson()).toList(),
      'isDay': isDay,
    };
  }

  factory WeatherState.fromJson(Map<String, dynamic> map) {
    return WeatherState(
      weatherModel: (map['weatherModel'] as Map<String, dynamic>?) != null
          ? WeatherResponseModel.fromMap(
              map['weatherModel'] as Map<String, dynamic>,
            )
          : null,
      unitSettings:
          UnitSettings.fromJson(map['unitSettings'] as Map<String, dynamic>),
      searchButtonModel: SearchLocalWeatherButtonModel.fromMap(
        map['searchButtonModel'] as Map<String, dynamic>,
      ),
      refererenceSuntimes: List<SunTimesModel>.from(
        (map['refererenceSuntimes'] as List)
            .map((x) => SunTimesModel.fromJson(x as Map<String, dynamic>)),
      ).toList(),
      isDay: (map['isDay'] as bool?) ?? false,
    );
  }
}
