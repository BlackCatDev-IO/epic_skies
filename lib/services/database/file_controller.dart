import 'dart:io';

import 'package:epic_skies/services/utils/asset_image_controllers/bg_image_controller.dart';
import 'package:get/get.dart';

import 'storage_controller.dart';

class FileController extends GetxController {
  static FileController get to => Get.find();

  String path = '';

  @override
  void onInit() {
    super.onInit();
    path = StorageController.to.appDirectoryPath;
  }

  void restoreImageFiles() {
    final Map<String, dynamic> map =
        StorageController.to.restoreBgImageFileList();

    map.forEach((key, value) {
      _createFileFromList(name: key, list: value as List);
    });
  }

  void _createFileFromList({String name, List list}) {
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
      {List<File> dayList, List<File> nightList, String name}) {
    switch (name) {
      case 'clear':
        BgImageController.to.clearImageList[0].addAll(dayList);
        BgImageController.to.clearImageList[1].addAll(nightList);
        break;
      case 'cloudy':
        BgImageController.to.cloudyImageList[0].addAll(dayList);
        BgImageController.to.cloudyImageList[1].addAll(nightList);
        break;
      case 'rain':
        BgImageController.to.rainImageList[0].addAll(dayList);
        BgImageController.to.rainImageList[1].addAll(nightList);
        break;
      case 'snow':
        BgImageController.to.snowImageList[0].addAll(dayList);
        BgImageController.to.snowImageList[1].addAll(nightList);
        break;
      case 'thunder_storm':
        BgImageController.to.stormImageList[0].addAll(dayList);
        BgImageController.to.stormImageList[1].addAll(nightList);
        break;
    }
  }
}
