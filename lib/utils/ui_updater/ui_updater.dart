import '../../features/current_weather_forecast/controllers/current_weather_controller.dart';
import '../../features/daily_forecast/controllers/daily_forecast_controller.dart';
import '../../features/hourly_forecast/controllers/hourly_forecast_controller.dart';
import '../../features/main_weather/bloc/weather_bloc.dart';
import '../../features/sun_times/controllers/sun_time_controller.dart';
import '../../services/asset_controllers/bg_image_controller.dart';
import '../timezone/timezone_util.dart';

class UiUpdater {
  static void refreshUI(WeatherState state) {
    SunTimeController.to.initSunTimeList(weatherModel: state.weatherModel!);

    CurrentWeatherController.to.refreshCurrentWeatherData(
      isRefresh: true,
      weatherState: state,
    );

    HourlyForecastController.to.refreshHourlyData(
      updatedWeatherState: state,
    );

    DailyForecastController.to.refreshDailyData(
      updatedWeatherState: state,
    );

    if (state.status.isSucess) {
      final condition = state.weatherModel!.currentCondition!.condition;
      BgImageController.to.updateBgImageOnRefresh(
        condition: condition,
        currentTime: TimeZoneUtil.getCurrentLocalOrRemoteTime(
          searchIsLocal: state.searchIsLocal,
        ),
      );
    }
  }
}
