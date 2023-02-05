import 'dart:io';
import 'dart:typed_data';

import 'package:epic_skies/core/database/firestore_database.dart';
import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/core/error_handling/failure_handler.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:epic_skies/utils/map_keys/image_map_keys.dart';
import 'package:flutter/services.dart' show rootBundle;

/// Handles converting image file paths from storage into
class FileController {
  FileController({
    required StorageController storage,
    required this.isNewInstall,
  }) : _storage = storage {
    _path = storage.restoreAppDirectory();
  }

  final StorageController _storage;

  final bool isNewInstall;

  String _path = '';

  late ByteData clearDayBytes;
  late ByteData earthFromSpaceBytes;

  late File clearDay1File;
  late File earthFromSpaceFile;

  Map<String, List<String>> imageFileMap = {};

  Future<Map<String, List<String>>> restoreImageFiles() async {
    if (isNewInstall) {
      final firebaseImageController =
          FirebaseImageController(storage: _storage);

      await firebaseImageController.fetchFirebaseImagesAndStoreLocally();
    }

    try {
      final map = _storage.restoreBgImageFileList();

      for (final imageMap in map.entries) {
        AppDebug.log('test');
        _createFileFromList(
          name: imageMap.key as String,
          list: imageMap.value as List,
        );
      }

      await _convertAssetImagesToFiles();
      return imageFileMap;
    } catch (e) {
      await FailureHandler.handleRestoreImageFileError(error: e.toString());
      throw Exception('error on restoreImageFiles function $e');
    }
  }

  void _createFileFromList({
    required String name,
    required List<dynamic> list,
  }) {
    final dayList = list[0] as List;
    final nightList = list[1] as List;

    final tempDayFileList = <String>[];
    final tempNightFileList = <String>[];

    for (final dayImage in dayList) {
      final file = '$_path/$dayImage';
      tempDayFileList.add(file);
    }

    for (final nightImage in nightList) {
      final file = '$_path/$nightImage';
      tempNightFileList.add(file);
    }

    _sortImageFiles(
      dayList: tempDayFileList,
      nightList: tempNightFileList,
      name: name,
    );
  }

  void _sortImageFiles({
    required List<String> dayList,
    required List<String> nightList,
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
    clearDay1File = File('$_path/$clearDay1');
    earthFromSpaceFile = File('$_path/$earthFromSpace');
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

    imageFileMap[ImageFileKeys.clearDay]!.insert(0, clearDay1File.path);
    imageFileMap[ImageFileKeys.earthFromSpace] = [earthFromSpaceFile.path];
  }
}
