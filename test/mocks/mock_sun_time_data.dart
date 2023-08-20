import 'package:epic_skies/features/main_weather/models/weather_response_model/daily_data/daily_data_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';

class MockSunTimeData {
  static List<SunTimesModel> sunTimeList({
    required DailyData data,
    required UnitSettings unitSettings,
    required bool searchIsLocal,
  }) =>
      List<SunTimesModel>.from(
        map.map(
          (e) => SunTimesModel.fromDailyData(
            data: data,
            unitSettings: unitSettings,
            searchIsLocal: searchIsLocal,
          ),
        ),
      );

  static const map = [
    {
      'sunriseString': '6:53 AM',
      'sunsetString': '5:26 PM',
      'sunriseTime': '2022-02-12 06:53:20.000',
      'sunsetTime': '2022-02-12 17:26:40.000',
    },
    {
      'sunriseString': '6:53 AM',
      'sunsetString': '5:26 PM',
      'sunriseTime': '2022-02-13 06:53:20.000',
      'sunsetTime': '2022-02-13 17:26:40.000',
    },
    {
      'sunriseString': '6:50 AM',
      'sunsetString': '5:28 PM',
      'sunriseTime': '2022-02-14 06:50:00.000',
      'sunsetTime': '2022-02-14 17:28:20.000',
    },
    {
      'sunriseString': '6:50 AM',
      'sunsetString': '5:28 PM',
      'sunriseTime': '2022-02-15 06:50:00.000',
      'sunsetTime': '2022-02-15 17:28:20.000',
    },
    {
      'sunriseString': '6:48 AM',
      'sunsetString': '5:30 PM',
      'sunriseTime': '2022-02-16 06:48:20.000',
      'sunsetTime': '2022-02-16 17:30:00.000',
    },
    {
      'sunriseString': '6:46 AM',
      'sunsetString': '5:33 PM',
      'sunriseTime': '2022-02-17 06:46:40.000',
      'sunsetTime': '2022-02-17 17:33:20.000',
    },
    {
      'sunriseString': '6:46 AM',
      'sunsetString': '5:33 PM',
      'sunriseTime': '2022-02-18 06:46:40.000',
      'sunsetTime': '2022-02-18 17:33:20.000',
    },
    {
      'sunriseString': '6:43 AM',
      'sunsetString': '5:35 PM',
      'sunriseTime': '2022-02-19 06:43:20.000',
      'sunsetTime': '2022-02-19 17:35:00.000',
    },
    {
      'sunriseString': '6:43 AM',
      'sunsetString': '5:35 PM',
      'sunriseTime': '2022-02-20 06:43:20.000',
      'sunsetTime': '2022-02-20 17:35:00.000',
    },
    {
      'sunriseString': '6:41 AM',
      'sunsetString': '5:36 PM',
      'sunriseTime': '2022-02-21 06:41:40.000',
      'sunsetTime': '2022-02-21 17:36:40.000',
    },
    {
      'sunriseString': '6:40 AM',
      'sunsetString': '5:38 PM',
      'sunriseTime': '2022-02-22 06:40:00.000',
      'sunsetTime': '2022-02-22 17:38:20.000',
    },
    {
      'sunriseString': '6:38 AM',
      'sunsetString': '5:38 PM',
      'sunriseTime': '2022-02-23 06:38:20.000',
      'sunsetTime': '2022-02-23 17:38:20.000',
    },
    {
      'sunriseString': '6:38 AM',
      'sunsetString': '5:38 PM',
      'sunriseTime': '2022-02-24 06:38:20.000',
      'sunsetTime': '2022-02-24 17:38:20.000',
    },
    {
      'sunriseString': '6:35 AM',
      'sunsetString': '5:41 PM',
      'sunriseTime': '2022-02-25 06:35:00.000',
      'sunsetTime': '2022-02-25 17:41:40.000',
    },
    {
      'sunriseString': '6:33 AM',
      'sunsetString': '5:43 PM',
      'sunriseTime': '2022-02-26 06:33:20.000',
      'sunsetTime': '2022-02-26 17:43:20.000',
    }
  ];
}
