import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:epic_skies/features/bg_image/bloc/bg_image_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/features/main_weather/models/weather_response_model/weather_data_model.dart';
import 'package:epic_skies/features/sun_times/models/sun_time_model.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/settings/unit_settings/unit_settings_model.dart';
import 'package:epic_skies/utils/timezone/timezone_util.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/init_hydrated_storage.dart';
import '../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../mocks/mock_image_file_data.dart';

void main() async {
  late String dynamicPath;
  late String clearDay1Path;
  late WeatherState weatherState;
  late WeatherResponseModel mockWeatherModel;
  late UnitSettings unitSettings;
  late List<SunTimesModel> suntimeList;

  setUpAll(() async {
    initHydratedStorage();

    mockWeatherModel = WeatherResponseModel.fromResponse(
      response: MockWeatherResponse.nycVisualCrossingResponse,
    );

    unitSettings = const UnitSettings();

    suntimeList = TimeZoneUtil.initSunTimeList(
      weatherModel: mockWeatherModel,
      searchIsLocal: true,
      unitSettings: unitSettings,
    );

    dynamicPath = MockImageFileData.testImagePath;
    clearDay1Path = '$dynamicPath/$clearDay1';

    weatherState = WeatherState(
      weatherModel: mockWeatherModel,
      status: WeatherStatus.success,
      unitSettings: unitSettings,
      refererenceSuntimes: suntimeList,
    );
  });

  group('BgImageBloc:', () {
    blocTest(
      '''BgImageInitDynamicSetting: changes ImageSetting to dynamic and updates to cloudy image when whether is cloudy''',
      build: BgImageBloc.new,
      seed: () => BgImageState(
        bgImagePath: clearDay1Path,
        imageSettings: ImageSettings.appGallery,
      ),
      act: (BgImageBloc bloc) =>
          bloc.add(BgImageInitDynamicSetting(weatherState: weatherState)),
      expect: () => [
        BgImageState(
          bgImagePath: clearDay1Path,
        ),
        const BgImageState(
          bgImagePath: '${MockImageFileData.testImagePath}/$cloudyDay1',
        ),
      ],
    );

    blocTest(
      'BgImageUpdateOnRefresh: emits updated image path as expected',
      build: BgImageBloc.new,
      seed: () => const BgImageState(
        bgImagePath: stormNight1,
      ),
      act: (BgImageBloc bloc) =>
          bloc.add(BgImageUpdateOnRefresh(weatherState: weatherState)),
      expect: () => [
        const BgImageState(
          bgImagePath: '${MockImageFileData.testImagePath}/$cloudyDay1',
        )
      ],
    );

    blocTest(
      '''BgImageUpdateOnRefresh: emits rain image with rain condition as expected''',
      build: BgImageBloc.new,
      seed: () => BgImageState(
        bgImagePath: clearDay1Path,
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
        const BgImageState(
          bgImagePath: '${MockImageFileData.testImagePath}/$rainSadFace1',
        )
      ],
    );

    blocTest(
      '''BgImageUpdateOnRefresh: emits storm image with storm condition as expected''',
      build: BgImageBloc.new,
      seed: () => BgImageState(
        bgImagePath: clearDay1Path,
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
        const BgImageState(
          bgImagePath: '${MockImageFileData.testImagePath}/$stormNight1',
        )
      ],
    );

    blocTest(
      'BgImageSelectFromAppGallery: emits updated image path as expected',
      build: BgImageBloc.new,
      seed: () => const BgImageState(
        bgImagePath: stormNight1,
        imageSettings: ImageSettings.appGallery,
      ),
      act: (BgImageBloc bloc) =>
          bloc.add(BgImageSelectFromAppGallery(imageFile: File('test_path'))),
      expect: () => [
        const BgImageState(
          bgImagePath: 'test_path',
          imageSettings: ImageSettings.appGallery,
        )
      ],
    );
  });
}
