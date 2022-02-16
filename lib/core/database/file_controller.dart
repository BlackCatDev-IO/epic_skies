import 'dart:io';
import 'dart:typed_data';

import 'package:epic_skies/core/error_handling/failure_handler.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/utils/map_keys/image_map_keys.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

import 'storage_controller.dart';

class FileController extends GetxController {
  FileController({required this.storage});

  static FileController get to => Get.find();

  final StorageController storage;

  String path = '';

  late ByteData clearDayBytes, earthFromSpaceBytes;

  late File clearDay1File, earthFromSpaceFile;

  Map<String, List<File>> imageFileMap = {};

  @override
  void onInit() {
    super.onInit();
    path = storage.restoreAppDirectory();
  }

  Future<void> restoreImageFiles() async {
    try {
      final Map map = storage.restoreBgImageFileList();

      map.forEach((key, value) {
        _createFileFromList(name: key as String, list: value as List);
      });
      await _convertAssetImagesToFiles();
    } catch (e) {
      FailureHandler.handleRestoreImageFileError(error: e.toString());
      throw 'error on restoreImageFiles function $e';
    }
  }

  void _createFileFromList({required String name, required List list}) {
    final dayList = list[0] as List;
    final nightList = list[1] as List;

    final List<File> tempDayFileList = [];
    final List<File> tempNightFileList = [];

    for (final dayImage in dayList) {
      final file = File('$path/$dayImage');
      tempDayFileList.add(file);
    }

    for (final nightImage in nightList) {
      final file = File('$path/$nightImage');
      tempNightFileList.add(file);
    }

    _sortImageFiles(
      dayList: tempDayFileList,
      nightList: tempNightFileList,
      name: name,
    );
  }

  void _sortImageFiles({
    required List<File> dayList,
    required List<File> nightList,
    required String name,
  }) {
    switch (name) {
      case 'clear':
        imageFileMap[ImageFileKeys.clearDay] = dayList;
        imageFileMap[ImageFileKeys.clearNight] = nightList;
        break;
      case 'cloudy':
        imageFileMap[ImageFileKeys.cloudyDay] = dayList;
        imageFileMap[ImageFileKeys.cloudyNight] = nightList;
        break;
      case 'rain':
        imageFileMap[ImageFileKeys.rainyDay] = dayList;
        imageFileMap[ImageFileKeys.rainyNight] = nightList;
        break;
      case 'snow':
        imageFileMap[ImageFileKeys.snowyDay] = dayList;
        imageFileMap[ImageFileKeys.snowyNight] = nightList;
        break;
      case 'thunder_storm':
        imageFileMap[ImageFileKeys.stormyDay] = dayList;
        imageFileMap[ImageFileKeys.stormyNight] = nightList;
        break;
    }
  }

  /// This is to simplify image managemant to only deal with File images
  /// The clearDay asset image is a backup in case Firebase storage fails
  Future<void> _convertAssetImagesToFiles() async {
    clearDayBytes = await rootBundle.load(clearDay1);
    earthFromSpaceBytes = await rootBundle.load(earthFromSpace);
    clearDay1File = File('$path/$clearDay1');
    earthFromSpaceFile = File('$path/$earthFromSpace');
    await Future.wait([
      clearDay1File.create(recursive: true),
      earthFromSpaceFile.create(recursive: true),
    ]);

    await Future.wait([
      clearDay1File.writeAsBytes(
        clearDayBytes.buffer.asUint8List(
          clearDayBytes.offsetInBytes,
          clearDayBytes.lengthInBytes,
        ),
      ),
      earthFromSpaceFile.writeAsBytes(
        earthFromSpaceBytes.buffer.asUint8List(
          earthFromSpaceBytes.offsetInBytes,
          earthFromSpaceBytes.lengthInBytes,
        ),
      ),
    ]);

    imageFileMap[ImageFileKeys.clearDay]!.insert(0, clearDay1File);
    imageFileMap[ImageFileKeys.earthFromSpace] = [earthFromSpaceFile];
  }
}
