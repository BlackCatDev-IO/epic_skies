import 'package:epic_skies/local_constants.dart';
import 'package:epic_skies/services/weather/weather_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'image_controller.dart';

class StorageController extends GetxController {
  final locationBox = GetStorage(locationMapKey);
  final dataBox = GetStorage(dataMapKey);
  final weatherController = Get.find<WeatherController>();
  final imageController = Get.find<ImageController>();

  @override
  void onInit() async {
    super.onInit();
    // await GetStorage.init(dataMapKey);
    // await GetStorage.init(locationMapKey);
  }

  void storeDataBox() {
    final map = weatherController.dataMap;
    dataBox.write(dataMapKey, map);
  }

  void initDataMap() {
    final Map<String, dynamic> dataMap = dataBox.read(dataMapKey);
    weatherController.dataMap.assignAll(dataMap);
  }

  void storeBgImage() {
    final imageString = imageController.backgroundImageString.value;
    dataBox.write(backgroundImageKey, imageString);
  }

  void initBgImage() {
    String imageString = imageController.backgroundImageString.value;
    imageString = dataBox.read(backgroundImageKey);
  }

  void clearAllStorage() {
    locationBox.erase();
    dataBox.erase();
  }

  bool dataBoxIsNull() => dataBox.read(dataMapKey) == null;
}
