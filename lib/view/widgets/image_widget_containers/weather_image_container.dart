import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:epic_skies/features/bg_image/bloc/bg_image_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherImageContainer extends StatelessWidget {
  const WeatherImageContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final imageSettings = context.watch<BgImageBloc>().state.imageSettings;
    return BlocSelector<BgImageBloc, BgImageState, String>(
      selector: (state) => state.bgImagePath,
      builder: (context, imagePath) {
        return imageSettings.isDeviceGallery
            ? DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(imagePath)),
                    fit: BoxFit.cover,
                  ),
                ),
                child: child,
              )
            : CachedNetworkImage(
                imageUrl: imagePath,
                imageBuilder: (context, imageProvider) => DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: child,
                ),
              );
      },
    );
  }
}

class FixedImageContainer extends StatelessWidget {
  const FixedImageContainer({
    super.key,
    required this.child,
    required this.imagePath,
  });
  final Widget child;
  final String imagePath;
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
