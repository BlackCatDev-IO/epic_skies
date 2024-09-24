import 'package:epic_skies/features/daily_forecast/models/daily_forecast_model.dart';
import 'package:epic_skies/features/hourly_forecast/cubit/hourly_forecast_cubit.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/daily_data/daily_data_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/features/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/services/asset_controllers/icon_controller.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/init_hydrated_storage.dart';
import '../../main_weather/mock_weather_state.dart';

void main() {
  late WeatherState weatherState;
  late WeatherResponseModel weatherModel;
  late String dailyCondition;
  late int index;
  late DailyData dailyData;
  late UnitSettings unitSettings;
  late SunTimesModel suntime;
  late HourlyForecastCubit hourlyCubit;

  setUpAll(() async {
    initHydratedStorage();

    weatherState = MockWeatherState().mockVisualCrossingState();
    unitSettings = const UnitSettings();

    weatherModel = weatherState.weatherModel!;

    index = 0;

    dailyData = weatherModel.days[0];

    hourlyCubit = HourlyForecastCubit()
      ..refreshHourlyData(updatedWeatherState: weatherState);

    suntime = SunTimesModel.fromVisualCrossing(
      data: dailyData,
      weatherState: weatherState,
    );

    dailyCondition = dailyData.conditions;
  });

  group('DailyForecastModel model test: ', () {
    test('dailyDetailWidgetModel.fromWeatherData initializes as expected',
        () async {
      final now = weatherState.refTimes.now;

      DateTimeFormatter.initNextDay(
        i: index,
        currentTime: now!,
      );

      final today = now.weekday;

      final modelFromResponse = DailyForecastModel.fromVisualCrossingApi(
        index: index,
        data: dailyData,
        currentTime: now,
        suntime: suntime,
        unitSettings: unitSettings,
        hourlyList: hourlyCubit.state.day1,
      );

      final expectedModel = DailyForecastModel(
        dailyTemp: 96,
        feelsLikeDay: 91,
        highTemp: 45,
        lowTemp: 24,
        precipitationAmount: 0.1,
        windSpeed: 6,
        precipitationProbability: 89,
        precipitationType: 'rain',
        iconPath: IconController.getIconImagePath(
          condition: dailyCondition,
          temp: 96,
          tempUnitsMetric: unitSettings.tempUnitsMetric,
          isDay: true,
        ),
        day: DateTimeFormatter.getNext7Days(
          day: now.weekday + index,
          today: today,
        ),
        month: DateTimeFormatter.getNextDaysMonth(),
        year: DateTimeFormatter.getNextDaysYear(),
        date: DateTimeFormatter.getNextDaysDate(),
        condition: 'Rain',
        suntime: suntime,
        precipIconPath: IconController.getPrecipIconPath(
          precipType: dailyData.preciptype![0]! as String,
        ),
        extendedHourlyList: hourlyCubit.state.day1,
      );

      expect(expectedModel, modelFromResponse);
    });

    test('units update when unit settings change', () {
      final now = weatherState.refTimes.now!;

      const metricUnitSettings = UnitSettings(
        timeIn24Hrs: true,
        speedInKph: true,
        tempUnitsMetric: true,
        precipInMm: true,
      );

      final modelFromResponse = DailyForecastModel.fromVisualCrossingApi(
        index: index,
        data: dailyData,
        currentTime: now,
        suntime: suntime,
        unitSettings: metricUnitSettings,
        hourlyList: hourlyCubit.state.day1,
      );

      final regularModel = DailyForecastModel(
        dailyTemp: 35,
        feelsLikeDay: 33,
        highTemp: dailyData.tempmax?.round(),
        lowTemp: dailyData.tempmin?.round(),
        precipitationAmount: 0.1,
        windSpeed: 9,
        precipitationProbability: 89,
        precipitationType: 'rain',
        iconPath: IconController.getIconImagePath(
          condition: dailyCondition,
          temp: 64.4.round(),
          tempUnitsMetric: unitSettings.tempUnitsMetric,
          isDay: true,
        ),
        day: DateTimeFormatter.getNext7Days(
          day: now.weekday + index,
          today: now.weekday,
        ),
        month: DateTimeFormatter.getNextDaysMonth(),
        year: DateTimeFormatter.getNextDaysYear(),
        date: DateTimeFormatter.getNextDaysDate(),
        condition: 'Rain',
        suntime: suntime,
        precipIconPath: IconController.getPrecipIconPath(
          precipType: dailyData.preciptype![0]! as String,
        ),
        extendedHourlyList: hourlyCubit.state.day1,
      );

      expect(regularModel, modelFromResponse);
    });
  });
}
