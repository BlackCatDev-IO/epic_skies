import 'dart:io';

import 'package:epic_skies/features/bg_image/bloc/bg_image_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherImageContainer extends StatelessWidget {
  const WeatherImageContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BgImageBloc, BgImageState>(
      buildWhen: (previous, current) =>
          previous.bgImagePath != current.bgImagePath,
      builder: (context, state) {
        return DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(File(state.bgImagePath)),
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
