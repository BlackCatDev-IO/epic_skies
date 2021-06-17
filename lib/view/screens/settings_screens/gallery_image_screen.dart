import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/bg_image_controller.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/view/widgets/general/settings_widgets/settings_header.dart';
import 'package:epic_skies/view/widgets/weather_info_display/weather_image_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iphone_has_notch/iphone_has_notch.dart';

import 'drawer_animator.dart';

class WeatherImageGallery extends GetView<BgImageController> {
  static const id = 'weather_image_gallery';

  List<Widget> imageList() {
    final List<Widget> imageList = [];
    for (final file in controller.imageFileList) {
      final thumbnail = ImageThumbnail(
          image: FileImage(file), path: file.path, index: imageList.length);
      imageList.add(thumbnail);
    }

    return imageList;
  }

  @override
  Widget build(BuildContext context) => IphoneHasNotch.hasNotch
      ? _imageGallery()
      : SafeArea(child: _imageGallery());

  Widget _imageGallery() {
    Get.put<ViewController>(ViewController(), tag: 'gallery');

    return Scaffold(
      body: Stack(
        children: [
          BlurFilter(
            sigmaX: 10,
            sigmaY: 10,
            child: const FixedImageContainer(
              image: earthFromSpace,
              child: SizedBox(height: double.infinity, width: double.infinity),
            ),
          ),
          Column(
            children: [
              const SettingsHeader(title: 'Gallery', backButtonShown: true),
              GridView.count(
                crossAxisCount: 3,
                padding: EdgeInsets.zero,
                children: imageList(),
              ).expanded()
            ],
          ),
        ],
      ),
    );
  }
}

class ImageThumbnail extends GetView<BgImageController> {
  final ImageProvider? image;
  final double? radius;
  final String? path;
  final int? index;

  const ImageThumbnail({
    this.radius,
    this.image,
    this.path,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.find<ViewController>(tag: 'gallery')
          .jumpToGalleryPage(index: index, image: image, path: path),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 8),
          image: DecorationImage(image: image!, fit: BoxFit.cover),
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
          height: screenHeight * 0.8,
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

class SelectedImagePage extends GetView<BgImageController> {
  static const id = 'selected_image_page';

  final ImageProvider? image;
  final String? path;
  final int? index;

  const SelectedImagePage({this.image, this.path, this.index});

  List<Widget> imageList() {
    final List<Widget> imageList = [];

    for (final file in controller.imageFileList) {
      final image = FileImage(file);
      final selectedImage = SelectedImage(image: image, path: path!);
      imageList.add(selectedImage);
    }
    return imageList;
  }

  @override
  Widget build(BuildContext context) {
    final viewController = Get.find<ViewController>(tag: 'gallery');
    return Stack(
      children: [
        BlurFilter(
          child: const RoundedContainer(
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        RoundedContainer(
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const SizedBox(height: 15),
              // const Spacer(),
              RoundedContainer(
                height: screenHeight * 0.9,
                child: PageView(
                  controller: viewController.pageController,
                  children: imageList(),
                  // children: list,
                ).center(),
              ).expanded(),
              DefaultButton(
                label: 'Set image as background',
                fontSize: 18,
                fontColor: Colors.white70,
                onPressed: () {
                  Get.to(() => const CustomAnimatedDrawer());
                  controller.selectImageFromAppGallery(
                    imageFile:
                        controller.imageFileList[viewController.index.toInt()],
                  );
                },
              ).paddingOnly(top: 15),
              // const SizedBox(height: 5),
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
                    viewController.previousPage(
                        index: viewController.index.toInt());
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
                  onPressed: () {
                    viewController.nextPage(
                        index: viewController.index.toInt());
                  },
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
