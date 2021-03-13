import 'package:epic_skies/local_constants.dart';
import 'package:epic_skies/services/utils/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherImageContainer extends StatelessWidget {
  final Widget child;

  const WeatherImageContainer({@required this.child});
  @override
  Widget build(BuildContext context) {
    return GetX<BgImageController>(builder: (controller) {
      bool bgImageFromGallery = controller.bgImageFromDeviceGallery.value;
      bool bgImageDynamic = controller.bgImageDynamic.value;
      String dynamicImagePath = controller.bgDynamicImageString.value;
      String userImagePath = controller.bgUserImageString.value;
      // if (dynamicImagePath == null || dynamicImagePath == '') {
      //   dynamicImagePath = clearDay1;
      // }

      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: bgImageFromGallery
                  ? FileImage(controller.image)
                  : bgImageDynamic
                      ? AssetImage(dynamicImagePath)
                      : AssetImage(userImagePath),
              fit: BoxFit.cover),
        ),
        child: child,
      );
    });
  }
}

class FixedImageContainer extends StatelessWidget {
  final Widget child;
  final String image;

  const FixedImageContainer({@required this.child, @required this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: child,
    );
  }
}
