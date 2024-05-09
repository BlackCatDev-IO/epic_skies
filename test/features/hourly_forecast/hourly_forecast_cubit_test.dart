import 'package:bloc_test/bloc_test.dart';
import 'package:epic_skies/features/hourly_forecast/cubit/hourly_forecast_cubit.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_classes.dart';
import '../main_weather/mock_weather_state.dart';

class MockHourlyForecastCubit extends MockCubit<HourlyForecastState>
    implements HourlyForecastCubit {}

void main() async {
  late Storage storage;

  setUpAll(() {
    storage = MockHydratedStorage();
    HydratedBloc.storage = storage;
    when(
      () => storage.write(any(), any<dynamic>()),
    ).thenAnswer((_) async {});
    HydratedBloc.storage = storage;

    GetIt.I.registerSingleton(TimeZoneUtil());
  });
  group('HourlyForecastCubit:', () {
    test(
      '2 Suntimes added to each block of 24 hours',
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
  });
}
