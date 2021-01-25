import 'package:epic_skies/local_constants.dart';
import 'package:epic_skies/services/utils/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherImageContainer extends StatelessWidget {
  final Widget child;

  const WeatherImageContainer({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<ImageController>(builder: (controller) {
      String imagePath = controller.backgroundImageString.value;
      if (imagePath == null || imagePath == '') {
        imagePath = clearDay1;
      }

      return Container(
        decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
        ),
        child: child,
      );
    });
  }
}
