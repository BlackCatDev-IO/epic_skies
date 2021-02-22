import 'package:epic_skies/widgets/general/animated_drawer.dart';
import 'package:epic_skies/widgets/general/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

import '../../local_constants.dart';

class BgSettingsScreen extends StatelessWidget {
  static const id = 'bg_settings_screen';

  final List<Widget> imageList = [
    ImageThumbnail(imagePath: cloudyPortrait),
    ImageThumbnail(imagePath: lightingCropped),
    ImageThumbnail(imagePath: snowPortrait),
    ImageThumbnail(imagePath: clearDay1),
    ImageThumbnail(imagePath: earthFromSpacePortrait),
    ImageThumbnail(imagePath: moonPortrait),
    ImageThumbnail(imagePath: snowyCityStreetPortrait),
    ImageThumbnail(imagePath: starryMountainPortrait),
    ImageThumbnail(imagePath: starryMountainPortrait),
    ImageThumbnail(imagePath: starryMountainPortrait),
    ImageThumbnail(imagePath: starryMountainPortrait),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          settingsAppBar(label: 'BG Settings'),
          const Divider(color: Colors.white60, indent: 40, endIndent: 40),
          CustomListTile(title: 'Dynamic based on current weather(Default)'),
          const Divider(color: Colors.white60, indent: 40, endIndent: 40),
          MyTextWidget(
                  fontSize: 17,
                  text:
                      'Fancy yourself a photog? Or just want to look at your cat while checking the weather? Press here to select a background image from your phones gallery')
              .paddingSymmetric(vertical: 5),
          DefaultButton(
                  label: 'Select from gallery',
                  fontColor: Colors.black,
                  onPressed: () {},
                  fontSize: 23,
                  buttonColor: Colors.white54)
              .paddingSymmetric(vertical: 10),
          MyTextWidget(
                  fontSize: 17,
                  text:
                      'Select an image to set it as the permanent background of Epic Skies')
              .paddingSymmetric(vertical: 10),
          GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                return imageList[index];
              }).expanded()
        ],
      ).paddingSymmetric(horizontal: 12),
    );
  }
}

class ImageThumbnail extends StatelessWidget {
  final String imagePath;
  final double radius;

  const ImageThumbnail({@required this.imagePath, this.radius});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
