import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:epic_skies/features/bg_image/bloc/bg_image_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/features/main_weather/models/search_local_weather_button_model.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../mocks/mock_classes.dart';
import '../../mocks/mock_image_file_data.dart';

void main() async {
  late MockStorageController mockStorage;
  late MockFileController fileController;
  late String dynamicPath;
  late String clearDay1Path;
  late String appDirectory;
  late WeatherState weatherState;
  late WeatherResponseModel mockWeatherModel;
  late Storage storage;
  late UnitSettings unitSettings;
  late SearchLocalWeatherButtonModel searchButtonModel;
  late List<SunTimesModel> suntimeList;

  late List<String> imageFileList;

  setUpAll(() async {
    storage = MockHydratedStorage();
    HydratedBloc.storage = storage;
    when(
      () => storage.write(any(), any<dynamic>()),
    ).thenAnswer((_) async {});
    HydratedBloc.storage = storage;

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

    searchButtonModel = SearchLocalWeatherButtonModel.fromWeatherModel(
      model: mockWeatherModel,
      unitSettings: unitSettings,
      isDay: true,
    );

    suntimeList = TimeZoneUtil.initSunTimeList(
      weatherModel: mockWeatherModel,
      searchIsLocal: true,
      unitSettings: unitSettings,
    );

    fileController = MockFileController();
    appDirectory = '/test_app_directory';
    dynamicPath = MockImageFileData.testImagePath;
    clearDay1Path = '$dynamicPath/$clearDay1';
    imageFileList = [];

    weatherState = WeatherState(
      weatherModel: mockWeatherModel,
      status: WeatherStatus.success,
      unitSettings: unitSettings,
      searchButtonModel: searchButtonModel,
      refererenceSuntimes: suntimeList,
      searchIsLocal: true,
      isDay: true,
    );

    for (final fileList in MockImageFileData.mockFileMap.values) {
      for (final file in fileList) {
        imageFileList.add(file);
      }
    }

    when(() => mockStorage.restoreAppDirectory()).thenReturn(
      appDirectory,
    );

    when(
      () => fileController.restoreImageFiles(),
    ).thenAnswer((_) async => MockImageFileData.mockFileMap);
  });

  group('BgImageBloc:', () {
    blocTest(
      'BgImageInitDynamicSetting: changes ImageSetting to dynamic and updates to cloudy image when whether is cloudy',
      build: () => BgImageBloc(
        storage: mockStorage,
        fileMap: MockImageFileData.mockFileMap,
      ),
      seed: () => BgImageState(
        bgImagePath: clearDay1Path,
        imageFileList: imageFileList,
        imageFileMap: MockImageFileData.mockFileMap,
        imageSettings: ImageSettings.appGallery,
      ),
      act: (BgImageBloc bloc) =>
          bloc.add(BgImageInitDynamicSetting(weatherState: weatherState)),
      expect: () => [
        BgImageState(
          bgImagePath: clearDay1Path,
          imageFileList: imageFileList,
          imageFileMap: MockImageFileData.mockFileMap,
          imageSettings: ImageSettings.dynamic,
        ),
        BgImageState(
          bgImagePath: '${MockImageFileData.testImagePath}/$cloudyDay1',
          imageFileList: imageFileList,
          imageFileMap: MockImageFileData.mockFileMap,
          imageSettings: ImageSettings.dynamic,
        ),
      ],
    );

    blocTest(
      'BgImageUpdateOnRefresh: emits updated image path as expected',
      build: () => BgImageBloc(
        storage: mockStorage,
        fileMap: MockImageFileData.mockFileMap,
      ),
      seed: () => BgImageState(
        bgImagePath: stormNight1,
        imageFileList: imageFileList,
        imageFileMap: MockImageFileData.mockFileMap,
        imageSettings: ImageSettings.dynamic,
      ),
      act: (BgImageBloc bloc) =>
          bloc.add(BgImageUpdateOnRefresh(weatherState: weatherState)),
      expect: () => [
        BgImageState(
          bgImagePath: '${MockImageFileData.testImagePath}/$cloudyDay1',
          imageFileList: imageFileList,
          imageFileMap: MockImageFileData.mockFileMap,
          imageSettings: ImageSettings.dynamic,
        )
      ],
    );

    blocTest(
      'BgImageUpdateOnRefresh: emits rain image with rain condition as expected',
      build: () => BgImageBloc(
        storage: mockStorage,
        fileMap: MockImageFileData.mockFileMap,
      ),
      seed: () => BgImageState(
        bgImagePath: clearDay1Path,
        imageFileList: imageFileList,
        imageFileMap: MockImageFileData.mockFileMap,
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
          imageFileList: imageFileList,
          imageFileMap: MockImageFileData.mockFileMap,
          imageSettings: ImageSettings.dynamic,
        )
      ],
    );

    blocTest(
      'BgImageUpdateOnRefresh: emits storm image with storm condition as expected',
      build: () => BgImageBloc(
        storage: mockStorage,
        fileMap: MockImageFileData.mockFileMap,
      ),
      seed: () => BgImageState(
        bgImagePath: clearDay1Path,
        imageFileList: imageFileList,
        imageFileMap: MockImageFileData.mockFileMap,
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
          imageFileList: imageFileList,
          imageFileMap: MockImageFileData.mockFileMap,
          imageSettings: ImageSettings.dynamic,
        )
      ],
    );

    blocTest(
      'BgImageSelectFromAppGallery: emits updated image path as expected',
      build: () => BgImageBloc(
        storage: mockStorage,
        fileMap: MockImageFileData.mockFileMap,
      ),
      seed: () => BgImageState(
        bgImagePath: stormNight1,
        imageFileList: imageFileList,
        imageFileMap: MockImageFileData.mockFileMap,
        imageSettings: ImageSettings.appGallery,
      ),
      act: (BgImageBloc bloc) =>
          bloc.add(BgImageSelectFromAppGallery(imageFile: File('test_path'))),
      expect: () => [
        BgImageState(
          bgImagePath: 'test_path',
          imageFileList: imageFileList,
          imageFileMap: MockImageFileData.mockFileMap,
          imageSettings: ImageSettings.appGallery,
        )
      ],
    );
  });
}
