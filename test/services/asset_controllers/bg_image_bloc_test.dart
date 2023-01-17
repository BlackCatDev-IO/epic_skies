import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/asset_controllers/bg_image/bloc/bg_image_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_classes.dart';
import '../../mocks/mock_image_file_data.dart';

void main() async {
  late MockStorageController mockStorage;
  late MockFileController fileController;
  late String dynamicPath;
  late String clearDay1Path;
  late String appDirectory;

  late List<File> imageFileList;

  setUpAll(() async {
    mockStorage = MockStorageController();
    fileController = MockFileController();
    appDirectory = '/test_app_directory';
    dynamicPath = MockImageFileData.testImagePath;
    clearDay1Path = '$dynamicPath/$clearDay1';
    imageFileList = [];

    for (final fileList in MockImageFileData.mockFileMap.values) {
      for (final file in fileList) {
        imageFileList.add(file);
      }
    }

    when(() => mockStorage.restoreBgImageSettings()).thenReturn(
      ImageSettings.dynamic,
    );

    when(() => mockStorage.restoreAppDirectory()).thenReturn(
      appDirectory,
    );

    when(() => mockStorage.restoreBgImageDynamicPath()).thenReturn(
      clearDay1Path,
    );

    when(
      () => fileController.restoreImageFiles(),
    ).thenAnswer((_) async => MockImageFileData.mockFileMap);
  });

  group('BgImageBloc:', () {
    blocTest(
      'BgImageInitFromStorage: initializes as expected from storage',
      setUp: () {
        when(() => mockStorage.restoreBgImageSettings()).thenReturn(
          ImageSettings.dynamic,
        );
      },
      build: () => BgImageBloc(
        storage: mockStorage,
        fileMap: MockImageFileData.mockFileMap,
      ),
      act: (BgImageBloc bloc) => bloc.add(BgImageInitFromStorage()),
      expect: () => [
        BgImageState(
          bgImagePath: clearDay1Path,
          imageFileList: imageFileList,
          imageFileMap: MockImageFileData.mockFileMap,
        ),
      ],
    );

    blocTest(
      'BgImageUpdateOnRefresh: emits updated image path as expected',
      setUp: () {
        when(() => mockStorage.restoreBgImageSettings()).thenReturn(
          ImageSettings.dynamic,
        );

        when(() => mockStorage.restoreSavedSearchIsLocal()).thenReturn(
          true,
        );
      },
      build: () => BgImageBloc(
        storage: mockStorage,
        fileMap: MockImageFileData.mockFileMap,
      ),
      seed: () => BgImageState(
        bgImagePath: stormNight1,
        imageFileList: imageFileList,
        imageFileMap: MockImageFileData.mockFileMap,
      ),
      act: (BgImageBloc bloc) =>
          bloc.add(BgImageUpdateOnRefresh(condition: 'clear', isDay: true)),
      expect: () => [
        BgImageState(
          bgImagePath: '${MockImageFileData.testImagePath}/$clearDay1',
          imageFileList: imageFileList,
          imageFileMap: MockImageFileData.mockFileMap,
        )
      ],
    );

    blocTest(
      'BgImageUpdateOnRefresh: emits rain image with rain condition as expected',
      setUp: () {
        when(() => mockStorage.restoreBgImageSettings()).thenReturn(
          ImageSettings.dynamic,
        );

        when(() => mockStorage.restoreSavedSearchIsLocal()).thenReturn(
          true,
        );
      },
      build: () => BgImageBloc(
        storage: mockStorage,
        fileMap: MockImageFileData.mockFileMap,
      ),
      seed: () => BgImageState(
        bgImagePath: clearDay1Path,
        imageFileList: imageFileList,
        imageFileMap: MockImageFileData.mockFileMap,
      ),
      act: (BgImageBloc bloc) =>
          bloc.add(BgImageUpdateOnRefresh(condition: 'rainy', isDay: true)),
      expect: () => [
        BgImageState(
          bgImagePath: '${MockImageFileData.testImagePath}/$rainSadFace1',
          imageFileList: imageFileList,
          imageFileMap: MockImageFileData.mockFileMap,
        )
      ],
    );

    blocTest(
      'BgImageSelectFromAppGallery: emits updated image path as expected',
      setUp: () {
        when(() => mockStorage.restoreBgImageSettings()).thenReturn(
          ImageSettings.dynamic,
        );

        when(() => mockStorage.restoreSavedSearchIsLocal()).thenReturn(
          true,
        );
      },
      build: () => BgImageBloc(
        storage: mockStorage,
        fileMap: MockImageFileData.mockFileMap,
      ),
      seed: () => BgImageState(
        bgImagePath: stormNight1,
        imageFileList: imageFileList,
        imageFileMap: MockImageFileData.mockFileMap,
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

    blocTest(
      'BgImageSettingsUpdated: emits updated image path as expected',
      setUp: () {
        when(() => mockStorage.restoreBgImageSettings()).thenReturn(
          ImageSettings.dynamic,
        );

        when(() => mockStorage.restoreSavedSearchIsLocal()).thenReturn(
          true,
        );
      },
      build: () => BgImageBloc(
        storage: mockStorage,
        fileMap: MockImageFileData.mockFileMap,
      ),
      seed: () => const BgImageState(
        bgImagePath: stormNight1,
        imageSettings: ImageSettings.appGallery,
      ),
      act: (BgImageBloc bloc) => bloc.add(
        BgImageSettingsUpdated(imageSetting: ImageSettings.dynamic),
      ),
      expect: () => [
        BgImageState(
          bgImagePath: clearDay1Path,
        )
      ],
    );
  });
}
