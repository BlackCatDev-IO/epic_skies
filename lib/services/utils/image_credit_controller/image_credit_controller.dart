import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/image_gallery_controller.dart';
import 'package:epic_skies/view/screens/settings_screens/image_credit_screen.dart';
import 'package:get/get.dart';

class ImageCreditController extends GetxController {
  final Map<String, ImageCreditModel> imageCreditMap = {};

  @override
  void onInit() {
    super.onInit();
    _initImageCreditMap();
  }

  void _initImageCreditMap() {
    for (final file in ImageGalleryController.to.imageFileList) {
      final path = file.path;
      if (path.endsWith(clearDay1)) {
        imageCreditMap[path] =
            ImageCreditModel(label: 'Wa11paper.com', url: clearDay1Url);
      } else if (path.endsWith(clearNight1)) {
        imageCreditMap[path] =
            ImageCreditModel(label: 'Pixy.org', url: clearNight1Url);
      } else if (path.endsWith(clearNight2)) {
        imageCreditMap[path] = ImageCreditModel(
          label: 'desktopbackground.org',
          url: clearNight2Url,
        );
      } else if (path.endsWith(cloudyDay1)) {
        imageCreditMap[path] =
            ImageCreditModel(label: 'Pixy.org', url: cloudyDay1Url);
      } else if (path.endsWith(cloudyDaySunset2)) {
        imageCreditMap[path] =
            ImageCreditModel(label: 'Unsplash.com', url: earthFromSpaceUrl);
      } else if (path.endsWith(cloudyNight1)) {
        imageCreditMap[path] =
            ImageCreditModel(label: 'Unsplash.com', url: earthFromSpaceUrl);
      } else if (path.endsWith(cloudyNight2)) {
        imageCreditMap[path] =
            ImageCreditModel(label: 'Unsplash.com', url: earthFromSpaceUrl);
      } else if (path.endsWith(cloudyNight3)) {
        imageCreditMap[path] =
            ImageCreditModel(label: 'Unsplash.com', url: earthFromSpaceUrl);
      } else if (path.endsWith(cloudyNight4)) {
        imageCreditMap[path] =
            ImageCreditModel(label: 'Unsplash.com', url: earthFromSpaceUrl);
      } else if (path.endsWith(rainSadFace1)) {
        imageCreditMap[path] =
            ImageCreditModel(label: 'Unsplash.com', url: earthFromSpaceUrl);
      } else if (path.endsWith(snowDay1)) {
        imageCreditMap[path] =
            ImageCreditModel(label: 'Unsplash.com', url: earthFromSpaceUrl);

        imageCreditMap[path] =
            ImageCreditModel(label: 'Unsplash.com', url: earthFromSpaceUrl);
      } else if (path.endsWith(snowNight1)) {
        imageCreditMap[path] =
            ImageCreditModel(label: 'Unsplash.com', url: earthFromSpaceUrl);
      } else if (path.endsWith(stormNight1)) {
        imageCreditMap[path] =
            ImageCreditModel(label: 'Unsplash.com', url: earthFromSpaceUrl);
      } else if (path.endsWith(earthFromSpace)) {
        imageCreditMap[path] =
            ImageCreditModel(label: 'Unsplash.com', url: earthFromSpaceUrl);
      }
    }
  }
}

class ImageCreditBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ImageGalleryController());
    Get.put(ImageCreditController());
  }
}
