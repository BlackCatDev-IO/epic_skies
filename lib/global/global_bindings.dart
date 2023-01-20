import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:get/get.dart';

import '../core/database/firestore_database.dart';
import '../services/app_updates/update_controller.dart';

class GlobalBindings {
  Future<void> initGetxControllers({
    required StorageController storage,
  }) async {
    Get.put(UpdateController(storage));

    if (storage.firstTimeUse()) {
      Get.put(FirebaseImageController(storage: storage));

      await FirebaseImageController.to.fetchFirebaseImagesAndStoreLocally();
      Get.delete<FirebaseImageController>();
      UpdateController.to.storeCurrentAppVersion();
    }
  }
}
