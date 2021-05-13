import 'package:epic_skies/services/utils/asset_image_controllers/bg_image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherImageContainer extends StatelessWidget {
  final Widget child;

  const WeatherImageContainer({required this.child});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BgImageController>(
      builder: (controller) => Container(
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
  final String image;

  const FixedImageContainer({required this.child, required this.image});
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
