import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/asset_controllers/bg_image/bloc/bg_image_bloc.dart';

class WeatherImageContainer extends StatelessWidget {
  final Widget child;

  const WeatherImageContainer({required this.child});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BgImageBloc, BgImageState>(
      buildWhen: (previous, current) => previous.bgImage != current.bgImage,
      builder: (context, state) {
        return DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: state.bgImage!,
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
