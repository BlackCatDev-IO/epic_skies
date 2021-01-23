import 'package:epic_skies/services/utils/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherImageContainer extends StatelessWidget {
  final Widget child;

  const WeatherImageContainer({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<ImageController>(builder: (controller) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(controller.backgroundImageString.value),
              fit: BoxFit.cover),
        ),
        child: child,
      );
    });
  }
}
