import '../../features/current_weather_forecast/controllers/current_weather_controller.dart';
import '../../features/daily_forecast/controllers/daily_forecast_controller.dart';
import '../../features/hourly_forecast/controllers/hourly_forecast_controller.dart';
import '../../features/main_weather/bloc/weather_bloc.dart';
import '../../features/sun_times/controllers/sun_time_controller.dart';
import '../../services/asset_controllers/bg_image_controller.dart';
import '../conversions/weather_code_converter.dart';
import '../map_keys/timeline_keys.dart';

class UiUpdater {
  static void refreshUI(WeatherState state) {
    SunTimeController.to.initSunTimeList(weatherModel: state.weatherModel!);

    CurrentWeatherController.to.initCurrentTime(state);

    CurrentWeatherController.to.updateCurrentWeatherData(
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
      final weatherCode = state.weatherModel!.timelines[Timelines.current]
          .intervals[0].data.weatherCode;

      final condition = WeatherCodeConverter.getConditionFromWeatherCode(
        weatherCode,
      );
      BgImageController.to.updateBgImageOnRefresh(
        condition: condition,
        currentTime: CurrentWeatherController.to.currentTime,
      );
    }
  }
}
