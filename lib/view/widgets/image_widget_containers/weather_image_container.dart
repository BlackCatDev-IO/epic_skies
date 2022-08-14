import 'package:epic_skies/services/asset_controllers/bg_image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherImageContainer extends StatelessWidget {
  final Widget child;

  const WeatherImageContainer({required this.child});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BgImageController>(
      builder: (controller) => DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: controller.bgImage,
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
  }
}

class FixedImageContainer extends StatelessWidget {
  final Widget child;
  final String imagePath;

  const FixedImageContainer({required this.child, required this.imagePath});
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      child: child,
    );
  }
}
