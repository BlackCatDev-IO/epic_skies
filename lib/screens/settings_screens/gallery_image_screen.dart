import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/bg_image_controller.dart';
import 'package:epic_skies/services/utils/view_controller.dart';
import 'package:epic_skies/widgets/general/animated_drawer.dart';
import 'package:epic_skies/widgets/general/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherImageGallery extends StatelessWidget {
  static const id = 'weather_image_gallery';
  final List<Widget> imageList = const [
    ImageThumbnail(imagePath: cloudyPortrait),
    ImageThumbnail(imagePath: lightingCropped),
    ImageThumbnail(imagePath: snowPortrait),
    ImageThumbnail(imagePath: clearDay1),
    ImageThumbnail(imagePath: earthFromSpacePortrait),
    ImageThumbnail(imagePath: moonPortrait),
    ImageThumbnail(imagePath: snowyCityStreetPortrait),
    ImageThumbnail(imagePath: starryMountainPortrait),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          settingsAppBar(label: 'Gallery'),
          const Divider(color: Colors.white60, indent: 40, endIndent: 40),
          GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                return imageList[index];
              }).expanded(),
        ],
      ),
    );
  }
}

class ImageThumbnail extends StatelessWidget {
  final String imagePath;
  final double radius;

  const ImageThumbnail({@required this.imagePath, this.radius});
  @override
  Widget build(BuildContext context) {
// TODO: finish setting up page swipe
    final dialog = PageView(
      controller: ViewController.to.pageController,
      children: [
        ImageSelectorStack(imagePath: imagePath),
      ],
    );

    return GestureDetector(
      onTap: () => Get.dialog(dialog),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 8),
          image:
              DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
        ),
      ).paddingAll(3.5),
    );
  }
}

class ImageSelectorStack extends StatelessWidget {
  const ImageSelectorStack({
    @required this.imagePath,
  });

  final String imagePath;

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
                    child:
                        Image(image: AssetImage(imagePath), fit: BoxFit.cover)),
              ),
              DefaultButton(
                  label: 'Set image as background',
                  onPressed: () {
                    Get.to(
                      () => const CustomAnimatedDrawer(),
                    );
                    BgImageController.to
                        .selectImageFromAppGallery(imagePath);
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
