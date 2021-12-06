import 'package:charcode/charcode.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/map_keys/timeline_keys.dart';
import 'package:epic_skies/models/location_models/location_model.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/models/widget_models/current_weather_model.dart';
import 'package:epic_skies/repositories/weather_repository.dart';
import 'package:epic_skies/services/location/location_controller.dart';
import 'package:epic_skies/services/ticker_controllers/drawer_animation_controller.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/services/timezone/timezone_controller.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:epic_skies/services/weather_forecast/current_weather_controller.dart';
import 'package:epic_skies/view/widgets/buttons/search_local_weather_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../../mocks/mock_api_responses/mock_local_placemark_response.dart';
import '../../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../../test_utils.dart';

void _initMockWeatherValues() {
  StorageController.to.storeCurrentLocalTemp(temp: 64);
  StorageController.to.storeCurrentLocalCondition(condition: 'Cloudy');
  StorageController.to.storeLocalIsDay(isDay: false);

  LocationController.to.data =
      LocationModel.fromPlacemark(place: MockLocationResponse().theBronx);

  WeatherRepository.to.weatherModel =
      WeatherResponseModel.fromMap(MockWeatherResponse.bronxWeather);

  final weatherModel = WeatherRepository.to.weatherModel!;

  final data = weatherModel.timelines[Timelines.current].intervals[0].data;
  CurrentWeatherController.to.data =
      CurrentWeatherModel.fromWeatherData(data: data);
}

void main() {
  setUp(() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    WidgetsFlutterBinding.ensureInitialized();
    Get.put(StorageController());
    await StorageController.to.initAllStorage();
    Get.put(TimeZoneController());
    Get.put(LocationController());
    Get.put(WeatherRepository());
    Get.put(DrawerAnimationController());
    Get.put(TabNavigationController());
    Get.put(CurrentWeatherController());
    Get.put(TabNavigationController());

    Get.put(ColorController());

    _initMockWeatherValues();
  });

  testWidgets('Displays weather and location icon',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialWidgetTestAncestorWidget(
        child: SearchLocalWeatherButton(isSearchPage: false),
      ),
    );
    final weatherIcon = find.byType(Image);
    final locationIcon = find.byIcon(Icons.near_me);
    expect(weatherIcon, findsOneWidget);
    expect(locationIcon, findsOneWidget);
  });

  testWidgets('Location displayed as expected', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialWidgetTestAncestorWidget(
        child: SearchLocalWeatherButton(isSearchPage: false),
      ),
    );

    expect(find.text('The Bronx'), findsOneWidget);
    expect(find.text('New York'), findsOneWidget);
    expect(find.text('Your location'), findsOneWidget);
  });

  testWidgets('Temperature displayed as expected', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialWidgetTestAncestorWidget(
        child: SearchLocalWeatherButton(isSearchPage: false),
      ),
    );

    final degreeSymbol = String.fromCharCode($deg);

    expect(find.text('64'), findsOneWidget);
    expect(find.text(degreeSymbol), findsOneWidget);
  });

  testWidgets('Temperature unit gets updated when user changes setting',
      (WidgetTester tester) async {
    StorageController.to.storeTempUnitMetricSetting(setting: true);

    final weatherModel = WeatherRepository.to.weatherModel!;

    final data = weatherModel.timelines[Timelines.current].intervals[0].data;

    CurrentWeatherController.to.data =
        CurrentWeatherModel.fromWeatherData(data: data);

    await tester.pumpWidget(
      const MaterialWidgetTestAncestorWidget(
        child: SearchLocalWeatherButton(isSearchPage: false),
      ),
    );

    expect(find.text('C'), findsOneWidget);
  });

  testWidgets('Pressing button navigates to home page',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        const MaterialWidgetTestAncestorWidget(
          child: SearchLocalWeatherButton(isSearchPage: false),
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
