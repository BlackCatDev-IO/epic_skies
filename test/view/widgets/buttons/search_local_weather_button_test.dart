import 'package:charcode/charcode.dart';
import 'package:epic_skies/features/current_weather_forecast/controllers/current_weather_controller.dart';
import 'package:epic_skies/features/current_weather_forecast/models/current_weather_model.dart';
import 'package:epic_skies/features/location/user_location/controllers/location_controller.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:epic_skies/utils/map_keys/timeline_keys.dart';
import 'package:epic_skies/view/widgets/buttons/search_local_weather_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_api_responses/mock_location_data.dart';
import '../../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../../mocks/mock_classes.dart';
import '../../../test_utils.dart';

void main() {
  late MockStorageController mockStorage;
  late UnitSettings unitSettings;
  late MockWeatherRepo mockWeatherRepo;
  late WeatherDataInitModel dataInitModel;
  late LocationController locationController;
  late CurrentWeatherController currentWeatherController;
  late TabNavigationController tabNavigationController;
  late ColorController colorController;

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

    unitSettings = UnitSettings(
      id: 1,
      timeIn24Hrs: false,
      speedInKph: false,
      tempUnitsMetric: false,
      precipInMm: false,
    );

    dataInitModel = WeatherDataInitModel(
      searchIsLocal: true,
      unitSettings: unitSettings,
    );

    when(() => mockStorage.firstTimeUse()).thenReturn(false);

    when(() => mockStorage.savedUnitSettings()).thenReturn(unitSettings);
    when(() => mockStorage.restoreSavedSearchIsLocal()).thenReturn(true);
    when(() => mockStorage.restoreLocalLocationData())
        .thenReturn(MockLocationData.bronxLocation);
    when(() => mockStorage.restoreCurrentLocalTemp()).thenReturn(64);
    when(() => mockStorage.restoreCurrentLocalCondition()).thenReturn('cloudy');
    when(() => mockStorage.restoreLocalIsDay()).thenReturn(false);

    mockWeatherRepo = MockWeatherRepo(storage: mockStorage);

    when(() => mockWeatherRepo.fetchLocalWeatherData())
        .thenAnswer((_) async {});

    locationController = LocationController(storage: mockStorage);

    Get.put(locationController);
    tabNavigationController = TabNavigationController();
    Get.put(tabNavigationController);

    currentWeatherController =
        CurrentWeatherController(weatherRepository: mockWeatherRepo);
    Get.put(currentWeatherController);

    mockWeatherRepo.weatherModel = WeatherResponseModel.fromResponse(
      response: MockWeatherResponse.bronxWeather,
      model: dataInitModel,
    );

    final data = mockWeatherRepo
        .weatherModel!.timelines[Timelines.current].intervals[0].data;

    currentWeatherController.data =
        CurrentWeatherModel.fromWeatherData(data: data);

    colorController = ColorController();
    Get.put(colorController);
  });

  testWidgets('Displays weather and location icon',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialWidgetTestAncestorWidget(
        child: SearchLocalWeatherButton(
          isSearchPage: false,
          weatherRepository: mockWeatherRepo,
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
          weatherRepository: mockWeatherRepo,
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
          weatherRepository: mockWeatherRepo,
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

    dataInitModel = WeatherDataInitModel(
      searchIsLocal: true,
      unitSettings: metricUnitSettings,
      oldSettings: unitSettings,
    );

    mockWeatherRepo.weatherModel = WeatherResponseModel.updatedUnitSettings(
      model: mockWeatherRepo.weatherModel!,
      data: dataInitModel,
    );

    final weatherModel = mockWeatherRepo.weatherModel!;

    final data = weatherModel.timelines[Timelines.current].intervals[0].data;

    CurrentWeatherController.to.data =
        CurrentWeatherModel.fromWeatherData(data: data);

    await tester.pumpWidget(
      MaterialWidgetTestAncestorWidget(
        child: SearchLocalWeatherButton(
          isSearchPage: false,
          weatherRepository: mockWeatherRepo,
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
            weatherRepository: mockWeatherRepo,
          ),
        ),
      );

      await tester.tap(find.byType(SearchLocalWeatherButton));

      /// verifying home tab
      expect(TabNavigationController.to.tabController.index, 0);
    });
  });
}
