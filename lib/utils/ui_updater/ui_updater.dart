import '../../features/daily_forecast/controllers/daily_forecast_controller.dart';
import '../../features/hourly_forecast/controllers/hourly_forecast_controller.dart';
import '../../features/main_weather/bloc/weather_bloc.dart';

class UiUpdater {
  static void refreshUI(WeatherState state) {
    HourlyForecastController.to.refreshHourlyData(
      updatedWeatherState: state,
    );

    DailyForecastController.to.refreshDailyData(
      updatedWeatherState: state,
    );
  }
}
