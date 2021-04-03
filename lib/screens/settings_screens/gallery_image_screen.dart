import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/bg_image_controller.dart';
import 'package:epic_skies/services/utils/view_controller.dart';
import 'package:epic_skies/widgets/general/animated_drawer.dart';
import 'package:epic_skies/widgets/general/settings_widgets/settings_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherImageGallery extends GetView<BgImageController> {
  static const id = 'weather_image_gallery';

  List<Widget> imageList() {
    final List<Widget> imageList = [];
    for (final file in controller.imageFileList) {
      final thumbnail = ImageThumbnail(image: FileImage(file), path: file.path);
      imageList.add(thumbnail);
    }

    const earth = ImageThumbnail(
        image: AssetImage(earthFromSpace), asset: earthFromSpace);

    imageList.add(earth);

    return imageList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SettingsHeader(title: 'Gallery'),
          GridView.count(
            crossAxisCount: 3,
            padding: EdgeInsets.zero,
            children: imageList(),
          ).expanded()
        ],
      ),
    );
  }
}

class ImageThumbnail extends GetView<BgImageController> {
  final ImageProvider image;
  final double radius;
  final String path, asset;

  const ImageThumbnail({this.radius, this.image, this.path, this.asset});

  @override
  Widget build(BuildContext context) {
// TODO: finish setting up page swipe

    return GestureDetector(
      onTap: () => Get.dialog(const GalleryViewPage()),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 8),
          image: DecorationImage(image: image, fit: BoxFit.cover),
        ),
      ).paddingAll(3.5),
    );
  }
}

class ImageSelectorPage extends GetView<BgImageController> {
  final ImageProvider image;

  final String path, asset;

  const ImageSelectorPage({
    @required this.image,
    this.path,
    this.asset,
  });

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
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(image: image, fit: BoxFit.cover)),
          ),
        ],
      ).paddingSymmetric(horizontal: 10).center(),
    ).center();
  }
}

class GalleryViewPage extends GetView<BgImageController> {
  final ImageProvider image;

  final String path, asset;

  const GalleryViewPage({this.image, this.path, this.asset});

  List<Widget> imageList() {
    final List<Widget> imageList = [];

    for (final file in controller.imageFileList) {
      final image = FileImage(file);
      final page = ImageSelectorPage(image: image, path: path, asset: asset);
      imageList.add(page);
    }
    return imageList;
  }

  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RoundedContainer(
                height: screenHeight * 0.9,
                child: PageView(
                  controller: ViewController.to.pageController,
                  // onPageChanged: () => debugPrint('') as,
                  children: imageList(),
                ),
              ),
              DefaultButton(
                label: 'Set image as background',
                onPressed: () {
                  Get.to(
                    () => const CustomAnimatedDrawer(),
                  );
                  controller.selectImageFromAppGallery(
                      image: image, path: path, asset: asset);
                },
              ),
            ],
          ).paddingSymmetric(horizontal: 5).center(),
        ).center(),
        RoundedContainer(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white60,
                  size: 50.0,
                ),
              ),
              GestureDetector(
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white60,
                  size: 50.0,
                ),
              ),
            ],
          ),
        ).center().paddingSymmetric(horizontal: 10),
      ],
    );
  }
}
