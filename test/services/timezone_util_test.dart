import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/main_weather/mock_weather_state.dart';
import '../mocks/weather_kit_mocks/null_suntimes_norway.dart';

void main() async {
  setUpAll(() {});
  group('TimeZoneUtil:', () {
    test(
      '''Returns a list of Suntimes with sunriseTime and sunsetTime not null when getReferenceTimesModel is called with a WeatherState with a WeatherKit response with null suntimes.''',
      () async {
        final timezoneUtil = TimeZoneUtil();
        final weatherState =
            MockWeatherState().mockWeatherKitState(nullSuntimesNorway);

        final refTimes = timezoneUtil.getReferenceTimesModel(
          weatherState: weatherState,
        );

        final suntimes = refTimes.refererenceSuntimes;

        expect(
          suntimes.every(
            (suntime) =>
                suntime.sunriseTime != null && suntime.sunsetTime != null,
          ),
          isTrue,
          reason: 'All sunriseTime and sunsetTime values should not be null',
        );

        expect(
          suntimes.length == weatherState.weather!.forecastDaily.days.length,
          true,
          reason:
              'Suntimes should be equal to the number of days in the response',
        );
      },
    );

    test(
      '''Returns a list of Suntimes with sunriseTime and sunsetTime not null when getReferenceTimesModel''',
      () async {
        final timezoneUtil = TimeZoneUtil();
        final weatherState = MockWeatherState().mockVisualCrossingState();
        final refTimes = timezoneUtil.getReferenceTimesModel(
          weatherState: weatherState,
        );

        final suntimes = refTimes.refererenceSuntimes;

        expect(
          suntimes.every(
            (suntime) =>
                suntime.sunriseTime != null && suntime.sunsetTime != null,
          ),
          isTrue,
          reason: 'All sunriseTime and sunsetTime values should not be null',
        );

        expect(
          suntimes.length == weatherState.weatherModel!.days.length,
          true,
          reason:
              'Suntimes should be equal to the number of days in the response',
        );
      },
    );
  });
}
