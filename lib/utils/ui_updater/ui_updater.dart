import '../../features/daily_forecast/controllers/daily_forecast_controller.dart';
import '../../features/hourly_forecast/controllers/hourly_forecast_controller.dart';
import '../../features/main_weather/bloc/weather_bloc.dart';
import '../../features/sun_times/controllers/sun_time_controller.dart';
import '../../services/asset_controllers/bg_image_controller.dart';
import '../timezone/timezone_util.dart';

class UiUpdater {
  static void refreshUI(WeatherState state) {
    SunTimeController.to.initSunTimeList(weatherState: state);

    HourlyForecastController.to.refreshHourlyData(
      updatedWeatherState: state,
    );

    DailyForecastController.to.refreshDailyData(
      updatedWeatherState: state,
    );

    if (state.status.isSuccess) {
      final condition = state.weatherModel!.currentCondition!.condition;

      final currentTime = TimeZoneUtil.getCurrentLocalOrRemoteTime(
        searchIsLocal: state.searchIsLocal,
      );
      final referenceTime =
          SunTimeController.to.referenceSuntime(refTime: currentTime);

      final isDay = TimeZoneUtil.getCurrentIsDay(
        searchIsLocal: state.searchIsLocal,
        // currentTime: currentTime,
        referenceTime: referenceTime,
      );
      BgImageController.to.updateBgImageOnRefresh(
        condition: condition,
        isDay: isDay,
      );
    }
  }
}
