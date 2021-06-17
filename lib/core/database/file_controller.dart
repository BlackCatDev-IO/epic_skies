import 'dart:io';
import 'dart:typed_data';
import 'package:epic_skies/global/local_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'storage_controller.dart';

class FileController extends GetxController {
  static FileController get to => Get.find();

  String path = '';

  late ByteData clearDayBytes;

  late File clearDay1File;

  @override
  void onInit() {
    super.onInit();
    path = StorageController.to.appDirectoryPath;
  }

  Map<String, List<File>> imageFileMap = {};

  Future<void> restoreImageFiles() async {
    try {
      final Map<String, dynamic> map =
          StorageController.to.restoreBgImageFileList();

      map.forEach((key, value) {
        _createFileFromList(name: key, list: value as List);
      });
      await _convertAssetImagesToFiles();
    } catch (e) {
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
        dayList: tempDayFileList, nightList: tempNightFileList, name: name);
  }

  void _sortImageFiles(
      {required List<File> dayList,
      required List<File> nightList,
      required String name}) {
    switch (name) {
      case 'clear':
        imageFileMap['clear_day'] = dayList;
        imageFileMap['clear_night'] = nightList;
        break;
      case 'cloudy':
        imageFileMap['cloudy_day'] = dayList;
        imageFileMap['cloudy_night'] = nightList;
        break;
      case 'rain':
        imageFileMap['rain_day'] = dayList;
        imageFileMap['rain_night'] = nightList;
        break;
      case 'snow':
        imageFileMap['snow_day'] = dayList;
        imageFileMap['snow_night'] = nightList;
        break;
      case 'thunder_storm':
        imageFileMap['storm_day'] = dayList;
        imageFileMap['storm_night'] = nightList;
        break;
    }
  }

  /// This is to simplify image managemant to only deal with File images
  /// The clearDay asset image is a backup in case Firebase storage fails
  Future<void> _convertAssetImagesToFiles() async {
    clearDayBytes = await rootBundle.load(clearDay1);
    clearDay1File = File('$path/$clearDay1');
    await clearDay1File.create(recursive: true);
    await clearDay1File.writeAsBytes(clearDayBytes.buffer
        .asUint8List(clearDayBytes.offsetInBytes, clearDayBytes.lengthInBytes));
    imageFileMap['asset_backup'] = [clearDay1File];
  }
}
