import 'dart:io';

import 'package:epic_skies/core/images.dart';
import 'package:epic_skies/features/bg_image/bloc/bg_image_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherImageContainer extends StatelessWidget {
  const WeatherImageContainer({
    required this.child,
    super.key,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final imageSettings = context.watch<BgImageBloc>().state.imageSettings;
    return BlocSelector<BgImageBloc, BgImageState, String>(
      selector: (state) => state.bgImagePath,
      builder: (context, imagePath) {
        final image = imageSettings.isDeviceGallery
            ? FileImage(File(imagePath))
            : AppImages.imageMap[imagePath]!;
        return DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image as ImageProvider<Object>,
              fit: BoxFit.cover,
            ),
          ),
          child: child,
        );
      },
    );
  }
}

class FixedImageContainer extends StatelessWidget {
  const FixedImageContainer({
    required this.child,
    required this.imagePath,
    super.key,
  });
  final Widget child;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AppImages.imageMap[imagePath]!,
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
