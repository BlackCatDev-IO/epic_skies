import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:epic_skies/features/bg_image/bloc/bg_image_bloc.dart';
import 'package:epic_skies/features/bg_image/models/weather_image_model.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/init_hydrated_storage.dart';
import '../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../mocks/mock_classes.dart';
import '../../mocks/mock_image_file_data.dart';

void main() async {
  late MockStorageController mockStorage;
  late String dynamicPath;
  late String clearDay1Path;
  late String appDirectory;
  late WeatherState weatherState;
  late WeatherResponseModel mockWeatherModel;
  late UnitSettings unitSettings;
  late List<SunTimesModel> suntimeList;

  late List<WeatherImageModel> imageFileList;

  setUpAll(() async {
    initHydratedStorage();

    mockStorage = MockStorageController();

    mockWeatherModel = WeatherResponseModel.fromResponse(
      response: MockWeatherResponse.nycVisualCrossingResponse,
    );

    unitSettings = const UnitSettings(
      tempUnitsMetric: false,
      timeIn24Hrs: false,
      precipInMm: false,
      speedInKph: false,
    );

    suntimeList = TimeZoneUtil.initSunTimeList(
      weatherModel: mockWeatherModel,
      searchIsLocal: true,
      unitSettings: unitSettings,
    );

    appDirectory = '/test_app_directory';
    dynamicPath = MockImageFileData.testImagePath;
    clearDay1Path = '$dynamicPath/$clearDay1';
    imageFileList = [];

    weatherState = WeatherState(
      weatherModel: mockWeatherModel,
      status: WeatherStatus.success,
      unitSettings: unitSettings,
      refererenceSuntimes: suntimeList,
      searchIsLocal: true,
      isDay: true,
    );
  });

  group('BgImageBloc:', () {
    blocTest(
      '''BgImageInitDynamicSetting: changes ImageSetting to dynamic and updates to cloudy image when whether is cloudy''',
      build: BgImageBloc.new,
      seed: () => BgImageState(
        bgImagePath: clearDay1Path,
        imageList: imageFileList,
        imageSettings: ImageSettings.appGallery,
      ),
      act: (BgImageBloc bloc) =>
          bloc.add(BgImageInitDynamicSetting(weatherState: weatherState)),
      expect: () => [
        BgImageState(
          bgImagePath: clearDay1Path,
          imageList: imageFileList,
          imageSettings: ImageSettings.dynamic,
        ),
        BgImageState(
          bgImagePath: '${MockImageFileData.testImagePath}/$cloudyDay1',
          imageList: imageFileList,
          imageSettings: ImageSettings.dynamic,
        ),
      ],
    );

    blocTest(
      'BgImageUpdateOnRefresh: emits updated image path as expected',
      build: BgImageBloc.new,
      seed: () => BgImageState(
        bgImagePath: stormNight1,
        imageList: imageFileList,
        imageSettings: ImageSettings.dynamic,
      ),
      act: (BgImageBloc bloc) =>
          bloc.add(BgImageUpdateOnRefresh(weatherState: weatherState)),
      expect: () => [
        BgImageState(
          bgImagePath: '${MockImageFileData.testImagePath}/$cloudyDay1',
          imageList: imageFileList,
          imageSettings: ImageSettings.dynamic,
        )
      ],
    );

    blocTest(
      'BgImageUpdateOnRefresh: emits rain image with rain condition as expected',
      build: BgImageBloc.new,
      seed: () => BgImageState(
        bgImagePath: clearDay1Path,
        imageList: imageFileList,
        imageSettings: ImageSettings.dynamic,
      ),
      act: (BgImageBloc bloc) => bloc.add(
        BgImageUpdateOnRefresh(
          weatherState: weatherState.copyWith(
            weatherModel: mockWeatherModel.copyWith(
              currentCondition: mockWeatherModel.currentCondition
                  .copyWith(conditions: 'rain'),
            ),
          ),
        ),
      ),
      expect: () => [
        BgImageState(
          bgImagePath: '${MockImageFileData.testImagePath}/$rainSadFace1',
          imageList: imageFileList,
          imageSettings: ImageSettings.dynamic,
        )
      ],
    );

    blocTest(
      'BgImageUpdateOnRefresh: emits storm image with storm condition as expected',
      build: BgImageBloc.new,
      seed: () => BgImageState(
        bgImagePath: clearDay1Path,
        imageList: imageFileList,
        imageSettings: ImageSettings.dynamic,
      ),
      act: (BgImageBloc bloc) => bloc.add(
        BgImageUpdateOnRefresh(
          weatherState: weatherState.copyWith(
            weatherModel: mockWeatherModel.copyWith(
              currentCondition: mockWeatherModel.currentCondition
                  .copyWith(conditions: 'storm'),
            ),
          ),
        ),
      ),
      expect: () => [
        BgImageState(
          bgImagePath: '${MockImageFileData.testImagePath}/$stormNight1',
          imageList: imageFileList,
          imageSettings: ImageSettings.dynamic,
        )
      ],
    );

    blocTest(
      'BgImageSelectFromAppGallery: emits updated image path as expected',
      build: BgImageBloc.new,
      seed: () => BgImageState(
        bgImagePath: stormNight1,
        imageList: imageFileList,
        imageSettings: ImageSettings.appGallery,
      ),
      act: (BgImageBloc bloc) =>
          bloc.add(BgImageSelectFromAppGallery(imageFile: File('test_path'))),
      expect: () => [
        BgImageState(
          bgImagePath: 'test_path',
          imageList: imageFileList,
          imageSettings: ImageSettings.appGallery,
        )
      ],
    );
  });
}
