import 'package:charcode/charcode.dart';
import 'package:epic_skies/features/current_weather_forecast/controllers/current_weather_controller.dart';
import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/features/location/user_location/controllers/location_controller.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/services/ticker_controllers/drawer_animation_controller.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:epic_skies/utils/map_keys/timeline_keys.dart';
import 'package:epic_skies/view/widgets/buttons/search_local_weather_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../../mocks/mock_classes.dart';
import '../../../mocks/mock_storage_return_values.dart';
import '../../../test_utils.dart';

void main() {
  late MockStorageController mockStorage;
  late UnitSettings unitSettings;
  late WeatherRepository weatherRepository;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    mockStorage = MockStorageController();
    unitSettings = UnitSettings(
      id: 1,
      timeIn24Hrs: false,
      speedInKph: false,
      tempUnitsMetric: false,
      precipInMm: false,
    );

    when(() => mockStorage.firstTimeUse()).thenReturn(false);
    when(() => mockStorage.restoreTodayData())
        .thenReturn(MockStorageReturns.todayData);
    when(() => mockStorage.savedUnitSettings()).thenReturn(unitSettings);
    when(() => mockStorage.restoreSavedSearchIsLocal()).thenReturn(true);
    when(() => mockStorage.restoreWeatherData())
        .thenReturn(MockWeatherResponse.bronxWeather);
    when(() => mockStorage.restoreLocalLocationData())
        .thenReturn(MockStorageReturns.bronxLocationData);
    when(() => mockStorage.restoreCurrentLocalTemp()).thenReturn(64);
    when(() => mockStorage.restoreCurrentLocalCondition()).thenReturn('cloudy');
    when(() => mockStorage.restoreLocalIsDay()).thenReturn(false);
    weatherRepository = WeatherRepository(storage: mockStorage);

    Get.put(TimeZoneController(storage: mockStorage));
    Get.put(LocationController(storage: mockStorage));
    Get.put(WeatherRepository(storage: mockStorage));
    Get.put(DrawerAnimationController());
    Get.put(TabNavigationController());

    Get.put(
      CurrentWeatherController(
        weatherRepository: weatherRepository,
      ),
    );
    Get.put(TabNavigationController());
    WeatherRepository.to.weatherModel = WeatherResponseModel.fromMap(
      map: MockWeatherResponse.bronxWeather,
      unitSettings: unitSettings,
    );

    final data = WeatherRepository
        .to.weatherModel!.timelines[Timelines.current].intervals[0].data;

    CurrentWeatherController.to.data =
        CurrentWeatherModel.fromWeatherData(data: data);
    Get.put(ColorController());
  });

  testWidgets('Displays weather and location icon',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialWidgetTestAncestorWidget(
        child: SearchLocalWeatherButton(
          isSearchPage: false,
          weatherRepository: weatherRepository,
        ),
      ),
    );
    final weatherIcon = find.byType(Image);
    final locationIcon = find.byIcon(Icons.near_me);
    expect(weatherIcon, findsOneWidget);
    expect(locationIcon, findsOneWidget);
  });

  testWidgets('Location displayed as expected', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialWidgetTestAncestorWidget(
        child: SearchLocalWeatherButton(
          isSearchPage: false,
          weatherRepository: weatherRepository,
        ),
      ),
    );

    expect(find.text('The Bronx'), findsOneWidget);
    expect(find.text('New York'), findsOneWidget);
    expect(find.text('Your location'), findsOneWidget);
  });

  testWidgets('Temperature displayed as expected', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialWidgetTestAncestorWidget(
        child: SearchLocalWeatherButton(
          isSearchPage: false,
          weatherRepository: weatherRepository,
        ),
      ),
    );

    final degreeSymbol = String.fromCharCode($deg);

    expect(find.text('64'), findsOneWidget);
    expect(find.text(degreeSymbol), findsOneWidget);
  });

  testWidgets('Temperature unit gets updated when user changes setting',
      (WidgetTester tester) async {
    final metricUnitSettings = UnitSettings(
      id: 1,
      timeIn24Hrs: true,
      speedInKph: true,
      tempUnitsMetric: true,
      precipInMm: true,
    );

    WeatherRepository.to.weatherModel =
        WeatherResponseModel.updatedUnitSettings(
      model: WeatherRepository.to.weatherModel!,
      updatedSettings: metricUnitSettings,
      oldSettings: unitSettings,
    );

    final weatherModel = WeatherRepository.to.weatherModel!;

    final data = weatherModel.timelines[Timelines.current].intervals[0].data;

    CurrentWeatherController.to.data =
        CurrentWeatherModel.fromWeatherData(data: data);

    await tester.pumpWidget(
      MaterialWidgetTestAncestorWidget(
        child: SearchLocalWeatherButton(
          isSearchPage: false,
          weatherRepository: weatherRepository,
        ),
      ),
    );

    expect(find.text('C'), findsOneWidget);
  });

  testWidgets('Pressing button navigates to home page',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        MaterialWidgetTestAncestorWidget(
          child: SearchLocalWeatherButton(
            isSearchPage: false,
            weatherRepository: weatherRepository,
          ),
        ),
      );

      await tester.tap(find.byType(SearchLocalWeatherButton));

      /// verifying home tab
      expect(TabNavigationController.to.tabController.index, 0);

      /// verify animation controller reversed to 0.0
      expect(DrawerAnimationController.to.animationController.value, 0.0);
    });
  });
}
