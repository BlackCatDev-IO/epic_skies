import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/asset_controllers/bg_image_controller.dart';
import 'package:epic_skies/services/asset_controllers/image_gallery_controller.dart';
import 'package:epic_skies/services/ticker_controllers/drawer_animation_controller.dart';
import 'package:epic_skies/view/widgets/general/notch_dependent_safe_area.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class WeatherImageGallery extends GetView<ImageGalleryController> {
  static const id = '/weather_image_gallery';

  @override
  Widget build(BuildContext context) {
    return NotchDependentSafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            BlurFilter(
              sigmaX: 10,
              sigmaY: 10,
              child: const FixedImageContainer(
                image: earthFromSpace,
                child:
                    SizedBox(height: double.infinity, width: double.infinity),
              ),
            ),
            Column(
              children: [
                const SettingsHeader(title: 'Gallery', backButtonShown: true),
                GridView.count(
                  crossAxisCount: 3,
                  padding: EdgeInsets.zero,
                  children: [
                    for (int i = 0; i < controller.imageFileList.length; i++)
                      ImageThumbnail(
                        image: FileImage(controller.imageFileList[i]),
                        path: controller.imageFileList[i].path,
                        index: i,
                      ),
                  ],
                ).expanded()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ImageThumbnail extends GetView<BgImageController> {
  final ImageProvider image;
  final double? radius;
  final String path;
  final int index;

  const ImageThumbnail({
    this.radius,
    required this.image,
    required this.path,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ImageGalleryController.to
          .jumpToGalleryPage(index: index, image: image, path: path),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 8),
          image: DecorationImage(image: image, fit: BoxFit.cover),
        ),
      ).paddingAll(3.5),
    );
  }
}

class SelectedImage extends GetView<BgImageController> {
  final ImageProvider image;
  final String path;

  const SelectedImage({required this.image, required this.path});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RoundedContainer(
          height: Get.height * 0.8,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(image: image, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 20,
          right: 10,
          child: CircleContainer(
            size: 35,
            color: Colors.black54,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(
                Icons.close,
                color: Colors.white70,
                size: 25.0,
              ),
            ),
          ),
        ),
      ],
    ).center();
  }
}

class SelectedImagePage extends GetView<ImageGalleryController> {
  static const id = 'selected_image_page';

  final ImageProvider image;
  final String path;
  final int index;

  const SelectedImagePage({
    required this.image,
    required this.path,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlurFilter(
          child: const RoundedContainer(
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        RoundedContainer(
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedContainer(
                height: Get.height * 0.9,
                child: PageView(
                  controller: ImageGalleryController.to.pageController,
                  children: [
                    for (final file in controller.imageFileList)
                      SelectedImage(image: FileImage(file), path: path)
                  ],
                ).center(),
              ).expanded(),
              DefaultButton(
                label: 'Set image as background',
                fontSize: 13.sp,
                buttonColor: Colors.black54,
                fontColor: Colors.white70,
                onPressed: () => BgImageController.to.selectImageFromAppGallery(
                  imageFile: controller
                      .imageFileList[ImageGalleryController.to.index.toInt()],
                ),
              ).paddingOnly(top: 15, left: 5, right: 5),
            ],
          ).paddingSymmetric(horizontal: 10),
        ).center(),
        RoundedContainer(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleContainer(
                size: 70,
                child: IconButton(
                  onPressed: () {
                    ImageGalleryController.to.previousPage(
                      index: ImageGalleryController.to.index.toInt(),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white60,
                    size: 35.0,
                  ).paddingOnly(right: 5),
                ),
              ),
              CircleContainer(
                size: 70,
                child: IconButton(
                  onPressed: () => ImageGalleryController.to
                      .nextPage(index: ImageGalleryController.to.index.toInt()),
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white60,
                    size: 35.0,
                  ).paddingOnly(left: 5),
                ),
              )
            ],
          ),
        ).center(),
      ],
    );
  }
}
