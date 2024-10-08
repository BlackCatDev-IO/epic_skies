import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/daily_data/daily_data_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/visual_crossing_mock.dart';
import '../main_weather/mock_weather_state.dart';

Future<void> main() async {
  late DailyData data;
  late WeatherResponseModel weatherModel;
  late WeatherState weatherState;
  late Duration timezoneOffset;

  setUpAll(() async {
    weatherState = MockWeatherState().mockVisualCrossingState();

    weatherModel = WeatherResponseModel.fromResponse(
      response: nycVisualCrossingResponse,
    );

    data = weatherModel.days[0];
    timezoneOffset =
        Duration(milliseconds: weatherState.refTimes.timezoneOffsetInMs);
  });

  group(
    'SunTimeModel test:',
    () {
      test('fromDailyData initializes as expected', () {
        final modelFromResponse = SunTimesModel.fromVisualCrossing(
          weatherState: weatherState,
          data: data,
        );

        final expectedSunriseTime = DateTime.fromMillisecondsSinceEpoch(
          data.sunriseEpoch!.round() * 1000,
        ).toUtc().add(timezoneOffset);

        final expectedSunsetTime = DateTime.fromMillisecondsSinceEpoch(
          data.sunsetEpoch!.round() * 1000,
        ).toUtc().add(timezoneOffset);

        final regularModel = SunTimesModel(
          sunriseTime: expectedSunriseTime,
          sunsetTime: expectedSunsetTime,
        );

        expect(regularModel, modelFromResponse);
      });

      test('fromDailyData initializes as expected with remote times', () {
        final modelFromResponse = SunTimesModel.fromVisualCrossing(
          weatherState: weatherState,
          data: data,
        );

        final expectedSunriseTime = DateTime.fromMillisecondsSinceEpoch(
          data.sunriseEpoch!.round() * 1000,
        ).toUtc().add(timezoneOffset);

        final expectedSunsetTime = DateTime.fromMillisecondsSinceEpoch(
          data.sunsetEpoch!.round() * 1000,
        ).toUtc().add(timezoneOffset);

        final regularModel = SunTimesModel(
          sunriseTime: expectedSunriseTime,
          sunsetTime: expectedSunsetTime,
        );

        expect(regularModel, modelFromResponse);
      });
    },
  );
}
