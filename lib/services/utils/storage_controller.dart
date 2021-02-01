import 'package:epic_skies/local_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageController extends GetxController {
  final locationBox = GetStorage(locationMapKey);
  final dataBox = GetStorage(dataMapKey);
  Map<String, dynamic> dataMap = {};

  void storeWeatherData({@required Map<String, dynamic> map}) {
    dataMap.addAll(map);
    dataBox.write(dataMapKey, map);
  }

  void storeLocationData({@required Map<String, dynamic> map}) {
    locationBox.write(locationMapKey, map);
  }

  void initDataMap() {
    dataMap.addAll(dataBox.read(dataMapKey));
  }

  void storePlaceId(String placeId) => dataBox.write(placeIdKey, placeId);

  String restorePlaceId() => dataBox.read(placeIdKey);
  
  Map<String, dynamic> restoreLocationData() =>
      locationBox.read(locationMapKey);

  void storeLocalOrRemote({@required bool searchIsLocal}) {
    dataBox.write(searchIsLocalKey, searchIsLocal);
  }

  void storeBgImage(String path) {
    dataBox.write(backgroundImageKey, path);
  }

  bool restoreSavedSearchIsLocal() => dataBox.read(searchIsLocalKey);

  bool dataBoxIsNull() => dataBox.read(dataMapKey) == null;

  String storedImage() => dataBox.read(backgroundImageKey);

  void clearAllStorage() {
    locationBox.erase();
    dataBox.erase();
  }
}
