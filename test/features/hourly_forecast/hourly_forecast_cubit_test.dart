import 'package:bloc_test/bloc_test.dart';
import 'package:epic_skies/features/hourly_forecast/cubit/hourly_forecast_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/init_hydrated_storage.dart';
import '../../mocks/visual_crossing_mocks/visual_crossing_nyc_metric.dart';
import '../main_weather/mock_weather_state.dart';

class MockHourlyForecastCubit extends MockCubit<HourlyForecastState>
    implements HourlyForecastCubit {}

void main() async {
  setUpAll(initHydratedStorage);
  group('HourlyForecastCubit: Expected lengths', () {
    test(
      '2 Suntimes added to each block of 24 hours with WeatherKitAPI',
      () async {
        final hourlyCubit = HourlyForecastCubit()
          ..refreshHourlyData(
            updatedWeatherState: MockWeatherState().mockWeatherKitState(),
          );

        const expectedLengthWithSunTimes = 26;

        expect(
          hourlyCubit.state.next24Hours.length,
          expectedLengthWithSunTimes,
        );
        expect(
          hourlyCubit.state.day1.length,
          expectedLengthWithSunTimes,
        );
        expect(
          hourlyCubit.state.day2.length,
          expectedLengthWithSunTimes,
        );
        expect(
          hourlyCubit.state.day3.length,
          expectedLengthWithSunTimes,
        );
        expect(
          hourlyCubit.state.day4.length,
          expectedLengthWithSunTimes,
        );
        expect(
          hourlyCubit.state.day5.length,
          expectedLengthWithSunTimes,
        );
        expect(
          hourlyCubit.state.day6.length,
          expectedLengthWithSunTimes,
        );
        expect(
          hourlyCubit.state.day7.length,
          expectedLengthWithSunTimes,
        );
        expect(
          hourlyCubit.state.day8.length,
          expectedLengthWithSunTimes,
        );
        expect(
          hourlyCubit.state.day9.length,
          expectedLengthWithSunTimes,
        );
      },
    );

    test(
      '2 Suntimes added to each block of 24 hours with VisualCrossingAPI',
      () async {
        final hourlyCubit = HourlyForecastCubit()
          ..refreshHourlyData(
            updatedWeatherState: MockWeatherState()
                .mockVisualCrossingState(nycVisualCrossingMetric),
          );

        const expectedLengthWithSunTimes = 26;

        expect(
          hourlyCubit.state.next24Hours.length,
          expectedLengthWithSunTimes,
        );
        expect(
          hourlyCubit.state.day1.length,
          expectedLengthWithSunTimes,
        );
        expect(
          hourlyCubit.state.day2.length,
          expectedLengthWithSunTimes,
        );
        expect(
          hourlyCubit.state.day3.length,
          expectedLengthWithSunTimes,
        );
        expect(
          hourlyCubit.state.day4.length,
          expectedLengthWithSunTimes,
        );
        expect(
          hourlyCubit.state.day5.length,
          expectedLengthWithSunTimes,
        );
        expect(
          hourlyCubit.state.day6.length,
          expectedLengthWithSunTimes,
        );
        expect(
          hourlyCubit.state.day7.length,
          expectedLengthWithSunTimes,
        );
        expect(
          hourlyCubit.state.day8.length,
          expectedLengthWithSunTimes,
        );
        expect(
          hourlyCubit.state.day9.length,
          expectedLengthWithSunTimes,
        );
      },
    );
  });

  group(
    '''Suntimes in expected locations with expected values with WeatherKit API''',
    () {
      test(
        'Next24Hours',
        () async {
          final hourlyCubit = HourlyForecastCubit()
            ..refreshHourlyData(
              updatedWeatherState: MockWeatherState().mockWeatherKitState(),
            );

          const expectedSunriseIndex = 20;
          const expectedSunsetIndex = 8;

          expect(
            hourlyCubit.state.next24Hours[expectedSunriseIndex].isSunrise,
            true,
          );

          expect(
            hourlyCubit.state.next24Hours[expectedSunriseIndex].suntimeString !=
                null,
            true,
          );

          expect(
            hourlyCubit.state.next24Hours[expectedSunsetIndex].isSunrise,
            false,
          );

          expect(
            hourlyCubit.state.next24Hours[expectedSunsetIndex].suntimeString !=
                null,
            true,
          );
        },
      );

      test(
        'Day 1',
        () async {
          final hourlyCubit = HourlyForecastCubit()
            ..refreshHourlyData(
              updatedWeatherState: MockWeatherState().mockWeatherKitState(),
            );

          const expectedSunriseIndex = 7;
          const expectedSunsetIndex = 21;

          expect(
            hourlyCubit.state.day1[expectedSunriseIndex].isSunrise,
            true,
          );

          expect(
            hourlyCubit.state.day1[expectedSunriseIndex].suntimeString != null,
            true,
          );

          expect(
            hourlyCubit.state.day1[expectedSunsetIndex].isSunrise,
            false,
          );

          expect(
            hourlyCubit.state.day1[expectedSunsetIndex].suntimeString != null,
            true,
          );
        },
      );

      test('Day 2', () async {
        final hourlyCubit = HourlyForecastCubit()
          ..refreshHourlyData(
            updatedWeatherState: MockWeatherState().mockWeatherKitState(),
          );
        const expectedSunriseIndex = 7;
        const expectedSunsetIndex = 21;
        expect(
          hourlyCubit.state.day2[expectedSunriseIndex].isSunrise,
          true,
        );
        expect(
          hourlyCubit.state.day2[expectedSunriseIndex].suntimeString != null,
          true,
        );
        expect(
          hourlyCubit.state.day2[expectedSunsetIndex].isSunrise,
          false,
        );
        expect(
          hourlyCubit.state.day2[expectedSunsetIndex].suntimeString != null,
          true,
        );
      });

      test('Day 3', () async {
        final hourlyCubit = HourlyForecastCubit()
          ..refreshHourlyData(
            updatedWeatherState: MockWeatherState().mockWeatherKitState(),
          );
        const expectedSunriseIndex = 7;
        const expectedSunsetIndex = 21;
        expect(
          hourlyCubit.state.day3[expectedSunriseIndex].isSunrise,
          true,
        );
        expect(
          hourlyCubit.state.day3[expectedSunriseIndex].suntimeString != null,
          true,
        );
        expect(
          hourlyCubit.state.day3[expectedSunsetIndex].isSunrise,
          false,
        );
        expect(
          hourlyCubit.state.day3[expectedSunsetIndex].suntimeString != null,
          true,
        );
      });

      test('Day 4', () async {
        final hourlyCubit = HourlyForecastCubit()
          ..refreshHourlyData(
            updatedWeatherState: MockWeatherState().mockWeatherKitState(),
          );
        const expectedSunriseIndex = 7;
        const expectedSunsetIndex = 21;
        expect(
          hourlyCubit.state.day4[expectedSunriseIndex].isSunrise,
          true,
        );
        expect(
          hourlyCubit.state.day4[expectedSunriseIndex].suntimeString != null,
          true,
        );
        expect(
          hourlyCubit.state.day4[expectedSunsetIndex].isSunrise,
          false,
        );
        expect(
          hourlyCubit.state.day4[expectedSunsetIndex].suntimeString != null,
          true,
        );
      });

      test('Day 5', () async {
        final hourlyCubit = HourlyForecastCubit()
          ..refreshHourlyData(
            updatedWeatherState: MockWeatherState().mockWeatherKitState(),
          );
        const expectedSunriseIndex = 7;
        const expectedSunsetIndex = 21;
        expect(
          hourlyCubit.state.day5[expectedSunriseIndex].isSunrise,
          true,
        );
        expect(
          hourlyCubit.state.day5[expectedSunriseIndex].suntimeString != null,
          true,
        );
        expect(
          hourlyCubit.state.day5[expectedSunsetIndex].isSunrise,
          false,
        );
        expect(
          hourlyCubit.state.day5[expectedSunsetIndex].suntimeString != null,
          true,
        );
      });

      test('Day 6', () async {
        final hourlyCubit = HourlyForecastCubit()
          ..refreshHourlyData(
            updatedWeatherState: MockWeatherState().mockWeatherKitState(),
          );
        const expectedSunriseIndex = 7;
        const expectedSunsetIndex = 21;
        expect(
          hourlyCubit.state.day6[expectedSunriseIndex].isSunrise,
          true,
        );
        expect(
          hourlyCubit.state.day6[expectedSunriseIndex].suntimeString != null,
          true,
        );
        expect(
          hourlyCubit.state.day6[expectedSunsetIndex].isSunrise,
          false,
        );
        expect(
          hourlyCubit.state.day6[expectedSunsetIndex].suntimeString != null,
          true,
        );
      });

      test('Day 7', () async {
        final hourlyCubit = HourlyForecastCubit()
          ..refreshHourlyData(
            updatedWeatherState: MockWeatherState().mockWeatherKitState(),
          );
        const expectedSunriseIndex = 7;
        const expectedSunsetIndex = 21;
        expect(
          hourlyCubit.state.day7[expectedSunriseIndex].isSunrise,
          true,
        );
        expect(
          hourlyCubit.state.day7[expectedSunriseIndex].suntimeString != null,
          true,
        );
        expect(
          hourlyCubit.state.day7[expectedSunsetIndex].isSunrise,
          false,
        );
        expect(
          hourlyCubit.state.day7[expectedSunsetIndex].suntimeString != null,
          true,
        );
      });

      test('Day 8', () async {
        final hourlyCubit = HourlyForecastCubit()
          ..refreshHourlyData(
            updatedWeatherState: MockWeatherState().mockWeatherKitState(),
          );
        const expectedSunriseIndex = 7;
        const expectedSunsetIndex = 21;
        expect(
          hourlyCubit.state.day8[expectedSunriseIndex].isSunrise,
          true,
        );
        expect(
          hourlyCubit.state.day8[expectedSunriseIndex].suntimeString != null,
          true,
        );
        expect(
          hourlyCubit.state.day8[expectedSunsetIndex].isSunrise,
          false,
        );
        expect(
          hourlyCubit.state.day8[expectedSunsetIndex].suntimeString != null,
          true,
        );
      });

      test('Day 9', () async {
        final hourlyCubit = HourlyForecastCubit()
          ..refreshHourlyData(
            updatedWeatherState: MockWeatherState().mockWeatherKitState(),
          );
        const expectedSunriseIndex = 7;
        const expectedSunsetIndex = 21;
        expect(
          hourlyCubit.state.day9[expectedSunriseIndex].isSunrise,
          true,
        );
        expect(
          hourlyCubit.state.day9[expectedSunriseIndex].suntimeString != null,
          true,
        );
        expect(
          hourlyCubit.state.day9[expectedSunsetIndex].isSunrise,
          false,
        );
        expect(
          hourlyCubit.state.day9[expectedSunsetIndex].suntimeString != null,
          true,
        );
      });
    },
  );

  group(
      '''Suntimes in expected locations with expected values with VisualCrossing API''',
      () {
    test(
      'Next24Hours',
      () async {
        final hourlyCubit = HourlyForecastCubit()
          ..refreshHourlyData(
            updatedWeatherState: MockWeatherState()
                .mockVisualCrossingState(nycVisualCrossingMetric),
          );

        const expectedSunriseIndex = 17;
        const expectedSunsetIndex = 7;

        expect(
          hourlyCubit.state.next24Hours[expectedSunriseIndex].isSunrise,
          true,
        );

        expect(
          hourlyCubit.state.next24Hours[expectedSunriseIndex].suntimeString !=
              null,
          true,
        );

        expect(
          hourlyCubit.state.next24Hours[expectedSunsetIndex].isSunrise,
          false,
        );

        expect(
          hourlyCubit.state.next24Hours[expectedSunsetIndex].suntimeString !=
              null,
          true,
        );
      },
    );
    test(
      'Day 1',
      () async {
        final hourlyCubit = HourlyForecastCubit()
          ..refreshHourlyData(
            updatedWeatherState: MockWeatherState()
                .mockVisualCrossingState(nycVisualCrossingMetric),
          );

        const expectedSunriseIndex = 6;
        const expectedSunsetIndex = 22;

        expect(
          hourlyCubit.state.day1[expectedSunriseIndex].isSunrise,
          true,
        );

        expect(
          hourlyCubit.state.day1[expectedSunriseIndex].suntimeString != null,
          true,
        );

        expect(
          hourlyCubit.state.day1[expectedSunsetIndex].isSunrise,
          false,
        );

        expect(
          hourlyCubit.state.day1[expectedSunsetIndex].suntimeString != null,
          true,
        );
      },
    );

    test(
      'Day 2',
      () async {
        final hourlyCubit = HourlyForecastCubit()
          ..refreshHourlyData(
            updatedWeatherState: MockWeatherState()
                .mockVisualCrossingState(nycVisualCrossingMetric),
          );

        const expectedSunriseIndex = 6;
        const expectedSunsetIndex = 22;

        expect(
          hourlyCubit.state.day2[expectedSunriseIndex].isSunrise,
          true,
        );

        expect(
          hourlyCubit.state.day2[expectedSunriseIndex].suntimeString != null,
          true,
        );

        expect(
          hourlyCubit.state.day2[expectedSunsetIndex].isSunrise,
          false,
        );

        expect(
          hourlyCubit.state.day2[expectedSunsetIndex].suntimeString != null,
          true,
        );
      },
    );

    test('Day 3', () async {
      final hourlyCubit = HourlyForecastCubit()
        ..refreshHourlyData(
          updatedWeatherState: MockWeatherState()
              .mockVisualCrossingState(nycVisualCrossingMetric),
        );
      const expectedSunriseIndex = 6;
      const expectedSunsetIndex = 22;
      expect(
        hourlyCubit.state.day3[expectedSunriseIndex].isSunrise,
        true,
      );
      expect(
        hourlyCubit.state.day3[expectedSunriseIndex].suntimeString != null,
        true,
      );
      expect(
        hourlyCubit.state.day3[expectedSunsetIndex].isSunrise,
        false,
      );
      expect(
        hourlyCubit.state.day3[expectedSunsetIndex].suntimeString != null,
        true,
      );
    });

    test('Day 4', () async {
      final hourlyCubit = HourlyForecastCubit()
        ..refreshHourlyData(
          updatedWeatherState: MockWeatherState()
              .mockVisualCrossingState(nycVisualCrossingMetric),
        );
      const expectedSunriseIndex = 6;
      const expectedSunsetIndex = 22;
      expect(
        hourlyCubit.state.day4[expectedSunriseIndex].isSunrise,
        true,
      );
      expect(
        hourlyCubit.state.day4[expectedSunriseIndex].suntimeString != null,
        true,
      );
      expect(
        hourlyCubit.state.day4[expectedSunsetIndex].isSunrise,
        false,
      );
      expect(
        hourlyCubit.state.day4[expectedSunsetIndex].suntimeString != null,
        true,
      );
    });

    test('Day 5', () async {
      final hourlyCubit = HourlyForecastCubit()
        ..refreshHourlyData(
          updatedWeatherState: MockWeatherState()
              .mockVisualCrossingState(nycVisualCrossingMetric),
        );
      const expectedSunriseIndex = 6;
      const expectedSunsetIndex = 22;
      expect(
        hourlyCubit.state.day5[expectedSunriseIndex].isSunrise,
        true,
      );
      expect(
        hourlyCubit.state.day5[expectedSunriseIndex].suntimeString != null,
        true,
      );
      expect(
        hourlyCubit.state.day5[expectedSunsetIndex].isSunrise,
        false,
      );
      expect(
        hourlyCubit.state.day5[expectedSunsetIndex].suntimeString != null,
        true,
      );
    });

    test('Day 6', () async {
      final hourlyCubit = HourlyForecastCubit()
        ..refreshHourlyData(
          updatedWeatherState: MockWeatherState()
              .mockVisualCrossingState(nycVisualCrossingMetric),
        );
      const expectedSunriseIndex = 6;
      const expectedSunsetIndex = 22;
      expect(
        hourlyCubit.state.day6[expectedSunriseIndex].isSunrise,
        true,
      );
      expect(
        hourlyCubit.state.day6[expectedSunriseIndex].suntimeString != null,
        true,
      );
      expect(
        hourlyCubit.state.day6[expectedSunsetIndex].isSunrise,
        false,
      );
      expect(
        hourlyCubit.state.day6[expectedSunsetIndex].suntimeString != null,
        true,
      );
    });

    test('Day 7', () async {
      final hourlyCubit = HourlyForecastCubit()
        ..refreshHourlyData(
          updatedWeatherState: MockWeatherState()
              .mockVisualCrossingState(nycVisualCrossingMetric),
        );
      const expectedSunriseIndex = 6;
      const expectedSunsetIndex = 22;
      expect(
        hourlyCubit.state.day7[expectedSunriseIndex].isSunrise,
        true,
      );
      expect(
        hourlyCubit.state.day7[expectedSunriseIndex].suntimeString != null,
        true,
      );
      expect(
        hourlyCubit.state.day7[expectedSunsetIndex].isSunrise,
        false,
      );
      expect(
        hourlyCubit.state.day7[expectedSunsetIndex].suntimeString != null,
        true,
      );
    });

    test('Day 8', () async {
      final hourlyCubit = HourlyForecastCubit()
        ..refreshHourlyData(
          updatedWeatherState: MockWeatherState()
              .mockVisualCrossingState(nycVisualCrossingMetric),
        );
      const expectedSunriseIndex = 6;
      const expectedSunsetIndex = 22;
      expect(
        hourlyCubit.state.day8[expectedSunriseIndex].isSunrise,
        true,
      );
      expect(
        hourlyCubit.state.day8[expectedSunriseIndex].suntimeString != null,
        true,
      );
      expect(
        hourlyCubit.state.day8[expectedSunsetIndex].isSunrise,
        false,
      );
      expect(
        hourlyCubit.state.day8[expectedSunsetIndex].suntimeString != null,
        true,
      );
    });

    test('Day 9', () async {
      final hourlyCubit = HourlyForecastCubit()
        ..refreshHourlyData(
          updatedWeatherState: MockWeatherState()
              .mockVisualCrossingState(nycVisualCrossingMetric),
        );
      const expectedSunriseIndex = 6;
      const expectedSunsetIndex = 22;
      expect(
        hourlyCubit.state.day9[expectedSunriseIndex].isSunrise,
        true,
      );
      expect(
        hourlyCubit.state.day9[expectedSunriseIndex].suntimeString != null,
        true,
      );
      expect(
        hourlyCubit.state.day9[expectedSunsetIndex].isSunrise,
        false,
      );
      expect(
        hourlyCubit.state.day9[expectedSunsetIndex].suntimeString != null,
        true,
      );
    });
  });
}
