import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:epic_skies/features/bg_image/bloc/bg_image_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_state.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../features/main_weather/mock_weather_state.dart';
import '../../mocks/init_hydrated_storage.dart';
import '../../mocks/mock_image_data.dart';

void main() async {
  late WeatherState weatherState;

  setUpAll(() async {
    initHydratedStorage();
    weatherState = MockWeatherState().mockWeatherKitState();
  });

  group('BgImageBloc:', () {
    blocTest(
      '''BgImageInitDynamicSetting: changes ImageSetting to dynamic and updates to clear image when whether is clear''',
      build: BgImageBloc.new,
      seed: () => const BgImageState(
        bgImagePath: cloudyDay1,
        status: BgImageStatus.loaded,
        imageSettings: ImageSettings.appGallery,
        bgImageList: MockImageData.imageModelList,
      ),
      act: (BgImageBloc bloc) => bloc.add(
        BgImageInitDynamicSetting(
          weatherState: MockWeatherState().mockWeatherKitState(),
        ),
      ),
      expect: () => [
        const BgImageState(
          bgImagePath: cloudyDay1,
          status: BgImageStatus.loaded,
          bgImageList: MockImageData.imageModelList,
        ),
        const BgImageState(
          bgImagePath: clearDay1,
          status: BgImageStatus.loaded,
          bgImageList: MockImageData.imageModelList,
        ),
      ],
    );

    blocTest(
      'BgImageUpdateOnRefresh: emits updated image path as expected',
      build: BgImageBloc.new,
      seed: () => const BgImageState(
        bgImagePath: stormNight1,
        bgImageList: MockImageData.imageModelList,
      ),
      act: (BgImageBloc bloc) =>
          bloc.add(BgImageUpdateOnRefresh(weatherState: weatherState)),
      expect: () => [
        const BgImageState(
          bgImagePath: clearDay1,
          bgImageList: MockImageData.imageModelList,
        ),
      ],
    );

    blocTest(
      '''BgImageUpdateOnRefresh: emits rain image with rain condition as expected''',
      build: BgImageBloc.new,
      seed: () => const BgImageState(
        bgImagePath: stormNight1,
        bgImageList: MockImageData.imageModelList,
      ),
      act: (BgImageBloc bloc) => bloc.add(
        BgImageUpdateOnRefresh(
          weatherState: weatherState,
        ),
      ),
      expect: () => [
        const BgImageState(
          bgImagePath: clearDay1,
          bgImageList: MockImageData.imageModelList,
        ),
      ],
    );

    blocTest(
      '''BgImageUpdateOnRefresh: emits storm image with storm condition as expected''',
      build: BgImageBloc.new,
      seed: () => const BgImageState(
        bgImagePath: stormNight1,
        bgImageList: MockImageData.imageModelList,
      ),
      act: (BgImageBloc bloc) => bloc.add(
        BgImageUpdateOnRefresh(
          weatherState: weatherState,
        ),
      ),
      expect: () => [
        const BgImageState(
          bgImagePath: clearDay1,
          bgImageList: MockImageData.imageModelList,
        ),
      ],
    );

    blocTest(
      'BgImageSelectFromAppGallery: emits updated image path as expected',
      build: BgImageBloc.new,
      seed: () => const BgImageState(
        bgImagePath: stormNight1,
        imageSettings: ImageSettings.appGallery,
        bgImageList: MockImageData.imageModelList,
      ),
      act: (BgImageBloc bloc) =>
          bloc.add(BgImageSelectFromAppGallery(imageFile: File('test_path'))),
      expect: () => [
        const BgImageState(
          bgImagePath: 'test_path',
          imageSettings: ImageSettings.appGallery,
          bgImageList: MockImageData.imageModelList,
        ),
      ],
    );
  });
}
