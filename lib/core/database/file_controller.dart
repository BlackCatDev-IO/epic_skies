import 'dart:io';
import 'dart:typed_data';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/bg_image_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'storage_controller.dart';

class FileController extends GetxController {
  static FileController get to => Get.find();

  String path = '';

  late ByteData earthFromSpaceBytes, clearDayBytes;

  File? earthFromSpaceFile, clearDay1File;

  @override
  void onInit() {
    super.onInit();
    path = StorageController.to.appDirectoryPath;
  }

  Future<void> restoreImageFiles() async {
    final Map<String, dynamic> map =
        StorageController.to.restoreBgImageFileList()!;

    map.forEach((key, value) {
      _createFileFromList(name: key, list: value as List);
    });
    await _convertAssetImagesToFiles();
  }

  Future<void> _createFileFromList({String? name, required List list}) async {
    final dayList = list[0] as List;
    final nightList = list[1] as List;

    final List<File> tempDayFileList = [];
    final List<File> tempNightFileList = [];

    for (final dayImage in dayList) {
      final file = File('$path/$dayImage');
      tempDayFileList.add(file);
      BgImageController.to.imageFileList.add(file);
    }

    for (final nightImage in nightList) {
      final file = File('$path/$nightImage');
      tempNightFileList.add(file);
      BgImageController.to.imageFileList.add(file);
    }

    _sortImageFiles(
        dayList: tempDayFileList, nightList: tempNightFileList, name: name);
  }

  void _sortImageFiles(
      {List<File>? dayList, List<File>? nightList, String? name}) {
    switch (name) {
      case 'clear':
        BgImageController.to.clearImageList[0].addAll(dayList!);
        BgImageController.to.clearImageList[1].addAll(nightList!);
        break;
      case 'cloudy':
        BgImageController.to.cloudyImageList[0].addAll(dayList!);
        BgImageController.to.cloudyImageList[1].addAll(nightList!);
        break;
      case 'rain':
        BgImageController.to.rainImageList[0].addAll(dayList!);
        BgImageController.to.rainImageList[1].addAll(nightList!);
        break;
      case 'snow':
        BgImageController.to.snowImageList[0].addAll(dayList!);
        BgImageController.to.snowImageList[1].addAll(nightList!);
        break;
      case 'thunder_storm':
        BgImageController.to.stormImageList[0].addAll(dayList!);
        BgImageController.to.stormImageList[1].addAll(nightList!);
        break;
    }
  }

  /// This is to simplify image managemant to only deal with File images
  /// The Asset images are backups incase Firebase storage fails
  Future<void> _convertAssetImagesToFiles() async {
    await Future.wait([
      _loadEarchImageBytes(),
      _loadClearDayImageBytes(),
    ]);

    earthFromSpaceFile = File('$path/$earthFromSpace');
    clearDay1File = File('$path/$clearDay1');

    await Future.wait([
      _createEarthImageFile(),
      _createClearDayImageFile(),
    ]);

    await Future.wait([
      _writeEarthImageFilesAsBytes(),
      _writeClearDayImageFilesAsBytes(),
    ]);

    BgImageController.to.imageFileList.add(earthFromSpaceFile);
    BgImageController.to.imageFileList.add(clearDay1File);
    BgImageController.to.clearImageList[0].add(clearDay1File);
  }

  Future<void> _loadEarchImageBytes() async {
    earthFromSpaceBytes = await rootBundle.load(earthFromSpace);
  }

  Future<void> _loadClearDayImageBytes() async {
    clearDayBytes = await rootBundle.load(clearDay1);
  }

  Future<void> _createEarthImageFile() async {
    await earthFromSpaceFile!.create(recursive: true);
  }

  Future<void> _createClearDayImageFile() async {
    await clearDay1File!.create(recursive: true);
  }

  Future<void> _writeEarthImageFilesAsBytes() async {
    await earthFromSpaceFile!.writeAsBytes(earthFromSpaceBytes.buffer
        .asUint8List(earthFromSpaceBytes.offsetInBytes,
            earthFromSpaceBytes.lengthInBytes));
  }

  Future<void> _writeClearDayImageFilesAsBytes() async {
    await clearDay1File!.writeAsBytes(clearDayBytes.buffer
        .asUint8List(clearDayBytes.offsetInBytes, clearDayBytes.lengthInBytes));
  }
}
