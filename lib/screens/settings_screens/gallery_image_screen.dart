import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/bg_image_controller.dart';
import 'package:epic_skies/screens/settings_screens/settings_drawer.dart';
import 'package:epic_skies/services/utils/view_controllers/view_controller.dart';
import 'package:epic_skies/widgets/general/settings_widgets/settings_header.dart';
import 'package:epic_skies/widgets/weather_info_display/weather_image_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherImageGallery extends GetView<BgImageController> {
  static const id = 'weather_image_gallery';

  List<Widget> imageList() {
    final List<Widget> imageList = [];
    for (final file in controller.imageFileList) {
      final thumbnail = ImageThumbnail(
          image: FileImage(file!), path: file.path, index: imageList.length);
      imageList.add(thumbnail);
    }

    return imageList;
  }

  @override
  Widget build(BuildContext context) {
    Get.put<ViewController>(ViewController(), tag: 'gallery');

    return Scaffold(
      body: Stack(
        children: [
          BlurFilter(
            sigmaX: 10,
            sigmaY: 10,
            child: FixedImageContainer(
              image: earthFromSpace,
              child: SizedBox(height: screenHeight, width: screenWidth),
            ),
          ),
          Column(
            children: [
              const SettingsHeader(title: 'Gallery'),
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

class ImageSelectorPage extends GetView<BgImageController> {
  final ImageProvider image;

  final String? path;

  final int? index;

  const ImageSelectorPage({required this.image, this.path, this.index});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: screenHeight * 0.99,
      width: screenWidth * 0.99,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundedContainer(
            height: screenHeight * 0.8,
            width: screenWidth * 0.99,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(image: image, fit: BoxFit.cover)),
          ),
        ],
      ),
    );
  }
}

class GalleryViewPage extends GetView<BgImageController> {
  static const id = 'gallery_view_page';
  final ImageProvider? image;

  final String? path;

  final int? index;

  const GalleryViewPage({this.image, this.path, this.index});

  List<Widget> imageList() {
    final List<Widget> imageList = [];

    for (final file in controller.imageFileList) {
      final image = FileImage(file!);
      final page = ImageSelectorPage(image: image, path: path);
      imageList.add(page);
    }
    return imageList;
  }

  @override
  Widget build(BuildContext context) {
    final viewController = Get.find<ViewController>(tag: 'gallery');

    return Stack(
      children: [
        BlurFilter(
          child: RoundedContainer(
            height: screenHeight,
            width: screenWidth,
          ),
        ),
        RoundedContainer(
          height: screenHeight * 0.99,
          width: screenWidth * 0.99,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedContainer(
                height: screenHeight * 0.85,
                child: PageView(
                  controller: viewController.pageController,
                  children: imageList(),
                ),
              ),
              DefaultButton(
                label: 'Set image as background',
                fontSize: 18,
                fontColor: Colors.white70,
                onPressed: () {
                  Get.to(
                    () => const CustomAnimatedDrawer(),
                  );
                  controller.selectImageFromAppGallery(
                    imageFile:
                        controller.imageFileList[viewController.index.toInt()]!,
                  );
                },
              ).paddingSymmetric(horizontal: 5),
              const SizedBox(height: 5),
            ],
          ),
        ),
        RoundedContainer(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleContainer(
                radius: 70,
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
                radius: 70,
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
