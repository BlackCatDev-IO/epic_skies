part of 'current_weather_cubit.dart';

class CurrentWeatherState extends Equatable {
  const CurrentWeatherState({
    this.currentTimeString = '',
    required this.data,
  });

  final String currentTimeString;

  final CurrentWeatherModel? data;

  CurrentWeatherState copyWith({
    String? currentTimeString,
    CurrentWeatherModel? data,
  }) {
    return CurrentWeatherState(
      currentTimeString: currentTimeString ?? this.currentTimeString,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [data, currentTimeString];
}
