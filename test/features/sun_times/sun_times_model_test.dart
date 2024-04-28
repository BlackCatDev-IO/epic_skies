import 'package:epic_skies/features/main_weather/models/weather_response_model/daily_data/daily_data_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../../mocks/mock_api_responses/mock_weather_responses.dart';

Future<void> main() async {
  late DailyData data;
  late WeatherResponseModel weatherModel;
  late UnitSettings unitSettings;

  setUpAll(() async {
    GetIt.I.registerSingleton<TimeZoneUtil>(TimeZoneUtil());

    unitSettings = const UnitSettings();

    weatherModel = WeatherResponseModel.fromResponse(
      response: MockWeatherResponse.nycVisualCrossingResponse,
    );

    data = weatherModel.days[0];
  });

  group(
    'SunTimeModel test:',
    () {
      test('fromDailyData initializes as expected', () {
        final modelFromResponse = SunTimesModel.fromDailyData(
          data: data,
          unitSettings: unitSettings,
          searchIsLocal: true,
        );

        final expectedSunriseTime = TimeZoneUtil().secondsFromEpoch(
          secondsSinceEpoch: data.sunriseEpoch!.round(),
          searchIsLocal: true,
        );

        final expectedSunsetTime = TimeZoneUtil().secondsFromEpoch(
          secondsSinceEpoch: data.sunsetEpoch!.round(),
          searchIsLocal: true,
        );

        final regularModel = SunTimesModel(
          sunriseTime: expectedSunriseTime,
          sunsetTime: expectedSunsetTime,
          sunriseString: DateTimeFormatter.formatFullTime(
            time: expectedSunriseTime,
            timeIn24Hrs: unitSettings.timeIn24Hrs,
          ),
          sunsetString: DateTimeFormatter.formatFullTime(
            time: expectedSunsetTime,
            timeIn24Hrs: unitSettings.timeIn24Hrs,
          ),
        );

        expect(regularModel, modelFromResponse);
      });

      test('fromDailyData initializes as expected with remote times', () {
        final modelFromResponse = SunTimesModel.fromDailyData(
          data: data,
          unitSettings: unitSettings,
          searchIsLocal: false,
        );

        final expectedSunriseTime = TimeZoneUtil().secondsFromEpoch(
          secondsSinceEpoch: data.sunriseEpoch!.round(),
          searchIsLocal: false,
        );

        final expectedSunsetTime = TimeZoneUtil().secondsFromEpoch(
          secondsSinceEpoch: data.sunsetEpoch!.round(),
          searchIsLocal: false,
        );

        final regularModel = SunTimesModel(
          sunriseTime: expectedSunriseTime,
          sunsetTime: expectedSunsetTime,
          sunriseString: DateTimeFormatter.formatFullTime(
            time: expectedSunriseTime,
            timeIn24Hrs: unitSettings.timeIn24Hrs,
          ),
          sunsetString: DateTimeFormatter.formatFullTime(
            time: expectedSunsetTime,
            timeIn24Hrs: unitSettings.timeIn24Hrs,
          ),
        );

        expect(regularModel, modelFromResponse);
      });
    },
  );
}
