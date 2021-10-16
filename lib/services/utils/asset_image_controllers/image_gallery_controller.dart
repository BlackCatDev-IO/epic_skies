import 'package:epic_skies/view/screens/settings_screens/gallery_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bg_image_controller.dart';

class ImageGalleryController extends GetxController {
  static ImageGalleryController get to => Get.find();

  final pageController = PageController();
  double index = 0;

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      index = pageController.page!;
    });
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }

  void jumpToGalleryPage({ImageProvider? image, String? path, int? index}) {
    Get.dialog(SelectedImagePage(image: image!, path: path!, index: index!))
        .then((value) {
      /// ensures scroll controller is deleted and initialized again in case
      /// user hits back button without selecting an image, and then selects an image thumbnail
      Get.delete<ImageGalleryController>();
      Get.put(ImageGalleryController());
    });
    Future.delayed(const Duration(milliseconds: 50), () {
      if (pageController.hasClients) {
        pageController.jumpToPage(index);
      }
    });
  }

  void previousPage({required int index}) {
    int newIndex = index - 1;
    final length = BgImageController.to.imageFileList.length;

    if (index == 0) {
      newIndex = length - 1;
    }
    if (pageController.hasClients) {
      pageController.jumpToPage(newIndex);
    }
  }

  void nextPage({required int index}) {
    int newIndex = index + 1;
    final length = BgImageController.to.imageFileList.length;

    if (newIndex == length) {
      newIndex = 0;
    }
    if (pageController.hasClients) {
      pageController.jumpToPage(newIndex);
    }
  }
}

class ImageGalleryBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ImageGalleryController());
  }
}
