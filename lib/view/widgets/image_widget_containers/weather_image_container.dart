import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:epic_skies/features/bg_image/bloc/bg_image_bloc.dart';
import 'package:epic_skies/global/local_constants.dart';
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
    return BlocBuilder<BgImageBloc, BgImageState>(
      buildWhen: (previous, current) =>
          (previous.bgImagePath != current.bgImagePath ||
              previous.status != current.status) &&
          !current.status.isLoading,
      builder: (context, state) {
        if (state.status.isError || state.bgImagePath == earthFromSpace) {
          return EarthFromSpaceBGContainer(child: child);
        }

        if (state.imageSettings.isDeviceGallery) {
          return DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(File(state.bgImagePath)),
                fit: BoxFit.cover,
              ),
            ),
            child: child,
          );
        }

        return CachedNetworkImage(
          imageUrl: state.bgImagePath,
          fit: BoxFit.cover,
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

class EarthFromSpaceBGContainer extends StatelessWidget {
  const EarthFromSpaceBGContainer({
    required this.child,
    super.key,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(earthFromSpace),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
