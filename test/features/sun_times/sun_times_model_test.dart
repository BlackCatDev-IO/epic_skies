import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/models/weather_response_models/weather_data_model.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/formatters/date_time_formatter.dart';
import 'package:epic_skies/utils/map_keys/timeline_keys.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../mocks/mock_classes.dart';

Future<void> main() async {
  late MockWeatherRepo mockWeatherRepo;
  late WeatherData data;
  late MockStorageController mockStorage;
  late UnitSettings unitSettings;
  late WeatherDataInitModel dataInitModel;

  setUpAll(() async {
    mockStorage = MockStorageController();

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

    mockWeatherRepo = MockWeatherRepo(storage: mockStorage);

    mockWeatherRepo.weatherModel = WeatherResponseModel.fromResponse(
      response: MockWeatherResponse.bronxWeather,
      model: dataInitModel,
    );

    data = mockWeatherRepo
        .weatherModel!.timelines[Timelines.daily].intervals[0].data;
  });

  group('SunTimeModel test:', () {
    test('fromWeatherData initializes as expected', () {
      final modelFromResponse = SunTimesModel.fromWeatherData(
        data: data,
      );

      final regularModel = SunTimesModel(
        sunriseTime: data.sunriseTime,
        sunsetTime: data.sunsetTime,
        sunriseString: DateTimeFormatter.formatFullTime(
          time: data.sunriseTime!,
          timeIn24Hrs: unitSettings.timeIn24Hrs,
        ),
        sunsetString: DateTimeFormatter.formatFullTime(
          time: data.sunsetTime!,
          timeIn24Hrs: unitSettings.timeIn24Hrs,
        ),
      );

      expect(regularModel.id, modelFromResponse.id);
      expect(regularModel.sunsetTime, modelFromResponse.sunsetTime);
      expect(regularModel.sunriseTime, modelFromResponse.sunriseTime);
      expect(regularModel.sunsetString, modelFromResponse.sunsetString);
      expect(regularModel.sunriseString, modelFromResponse.sunriseString);
    });

    test('toMap returns expected map', () {
      final modelFromResponse = SunTimesModel.fromWeatherData(
        data: data,
      );

      final modelToMap = modelFromResponse.toMap();

      final map = {
        'sunriseTime': '2021-11-08 06:33:20.000',
        'sunsetTime': '2021-11-08 16:43:20.000',
        'sunriseString': '6:33 AM',
        'sunsetString': '4:43 PM'
      };

      expect(modelToMap, map);
    });
  });
}
