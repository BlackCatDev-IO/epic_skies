import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/bg_image_controller.dart';
import 'package:epic_skies/widgets/general/animated_drawer.dart';
import 'package:epic_skies/widgets/general/settings_widgets/settings_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  Widget build(BuildContext context) {
    Get.put(GalleryController());

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
  final int index;

  const ImageThumbnail({
    this.radius,
    this.image,
    this.path,
    this.asset,
    this.index,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => GalleryController.to
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

class ImageSelectorPage extends GetView<BgImageController> {
  final ImageProvider image;

  final String path, asset;

  final int index;

  const ImageSelectorPage(
      {@required this.image, this.path, this.asset, this.index});

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
  final ImageProvider image;

  final String path, asset;

  final int index;

  const GalleryViewPage({this.image, this.path, this.asset, this.index});

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedContainer(
                height: screenHeight * 0.85,
                child: PageView(
                  controller: GalleryController.to.pageController,
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
                      imageFile: controller
                          .imageFileList[GalleryController.to.index.toInt()],
                      asset: asset);
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
                child: IconButton(
                  onPressed: () {
                    final index = GalleryController.to.index.toInt();
                    GalleryController.to.nextOrPreviousPage(index: index - 1);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white60,
                    size: 35.0,
                  ).paddingOnly(right: 5),
                ),
              ),
              CircleContainer(
                child: IconButton(
                  onPressed: () {
                    final index = GalleryController.to.index.toInt();
                    GalleryController.to.nextOrPreviousPage(index: index + 1);
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

class CircleContainer extends StatelessWidget {
  final Color color;
  final double radius;
  final Widget child;

  const CircleContainer({this.color, this.radius, this.child});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
          color: color ?? Colors.black38,
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    ).paddingSymmetric(horizontal: 10);
  }
}

class GalleryController extends GetxController {
  static GalleryController get to => Get.find();

  final pageController = PageController();

  double index;

  void jumpToGalleryPage({ImageProvider image, String path, int index}) {
    Get.dialog(GalleryViewPage(image: image, path: path, index: index));
    Future.delayed(const Duration(milliseconds: 50), () {
      if (pageController.hasClients) {
        pageController.jumpToPage(index);
      }
    });
  }

  void nextOrPreviousPage({int index}) {
    Future.delayed(const Duration(milliseconds: 50), () {
      if (pageController.hasClients) {
        pageController.jumpToPage(index);
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      index = pageController.page;
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    debugPrint('GalleryController onClose');

    super.onClose();
  }
}
