import 'package:epic_skies/services/utils/image_controller.dart';
import 'package:epic_skies/services/utils/view_controller.dart';
import 'package:epic_skies/widgets/general/animated_drawer.dart';
import 'package:epic_skies/widgets/general/my_app_bar.dart';
import 'package:epic_skies/widgets/weather_info_display/weather_image_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

import '../../local_constants.dart';

class BgSettingsScreen extends StatelessWidget {
  static const id = 'bg_settings_screen';
  final imageController = Get.find<BgImageController>();

  @override
  Widget build(BuildContext context) {
    final dynamicImageSetting = ObxValue(
      (settingsBool) => Switch(
          value: imageController.bgImageDynamic.value,
          activeColor: Colors.white,
          activeTrackColor: Colors.greenAccent,
          onChanged: (value) {
            if (!value) {
              imageController.handleDynamicSwitchTap();
              value = true;
            }
            imageController.bgImageDynamic.value = value; // Rx

            // has a _callable_ function! You could use (flag) => data.value = flag,
          }),
      false.obs,
    );

    return Scaffold(
      body: FixedImageContainer(
        image: earthFromSpacePortrait,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            settingsAppBar(label: 'BG Settings'),
            const Divider(color: Colors.white60, indent: 40, endIndent: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomListTile(
                    title: 'Dynamic (based on current weather)',
                    settingsSwitch: dynamicImageSetting,
                    height: 60,
                    onPressed: (() =>
                        imageController.handleDynamicSwitchTap())),

                DefaultButton(
                        label: 'Select image from your device',
                        fontColor: Colors.white70,
                        onPressed: () {
                          imageController.selectImageFromDeviceGallery();
                        },
                        fontSize: 20,
                        buttonColor: blackCustom)
                    .paddingSymmetric(vertical: 10),
  
                DefaultButton(
                        label: 'Select from Epic Skies weather image gallery',
                        fontColor: Colors.white70,
                        onPressed: () {
                          Get.to(() => WeatherImageGallery());
                        },
                        fontSize: 20,
                        buttonColor: blackCustom)
                    .paddingSymmetric(vertical: 10),
                // const Spacer(),
              ],
            ).expanded(),
          ],
        ).paddingSymmetric(horizontal: 12),
      ),
    );
  }
}

class WeatherImageGallery extends StatelessWidget {
  static const id = 'weather_image_gallery';
  final List<Widget> imageList = [
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
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              padding: EdgeInsets.symmetric(vertical: 10),
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
      controller: Get.find<ViewController>().pageController,
      children: [
        ImageSelectorStack(imagePath: imagePath),
      ],
    );

    return GestureDetector(
      onTap: (() {
        Get.dialog(dialog);
      }),
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
  }) ;

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final imageController = Get.find<BgImageController>();
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
                onPressed: (() {
                  Get.offAll(
                    () => CustomAnimatedDrawer(),
                  );
                  imageController.userUpdateBgImageFromAppGallery(imagePath);
                }),
              ),
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
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white60,
                  size: 50.0,
                ),
              ),
              GestureDetector(
                child: Icon(
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
