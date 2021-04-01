
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
      final image = FileImage(file);
      final thumbnail = ImageThumbnail(image: image);
      imageList.add(thumbnail);
    }

    const earth = ImageThumbnail(image: AssetImage(earthFromSpace));

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
            children: imageList(),
          ).expanded()
        ],
      ),
    );
  }
}

class ImageThumbnail extends StatelessWidget {
  final ImageProvider image;
  final double radius;

  const ImageThumbnail({this.radius, this.image});
  @override
  Widget build(BuildContext context) {
// TODO: finish setting up page swipe
    final dialog = PageView(
      controller: ViewController.to.pageController,
      children: [
        ImageSelectorStack(image: image),
      ],
    );

    return GestureDetector(
      onTap: () => Get.dialog(dialog),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 8),
          image: DecorationImage(image: image, fit: BoxFit.cover),
        ),
      ).paddingAll(3.5),
    );
  }
}

class ImageSelectorStack extends StatelessWidget {
  const ImageSelectorStack({
    @required this.image,
  });

  final ImageProvider image;

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RoundedContainer(
                height: screenHeight * 0.8,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(image: image, fit: BoxFit.cover)),
              ),
              DefaultButton(
                  label: 'Set image as background',
                  onPressed: () {
                    Get.to(
                      () => const CustomAnimatedDrawer(),
                    );
                    BgImageController.to.selectImageFromAppGallery(image);
                  }),
            ],
          ).paddingSymmetric(horizontal: 10).center(),
        ).center(),
        RoundedContainer(
          height: 40,
          // color: Colors.blue,
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
