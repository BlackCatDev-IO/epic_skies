import 'dart:io';

import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/bg_image/bloc/bg_image_bloc.dart';
import 'package:epic_skies/features/bg_image/models/weather_image_model.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class WeatherImageGallery extends StatelessWidget {
  WeatherImageGallery({super.key});

  static const id = '/weather_image_gallery';

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final imageList = context
        .read<BgImageBloc>()
        .state
        .bgImageList
        .map((imageModel) => CachedNetworkImageProvider(imageModel.imageUrl))
        .toList();

    final allImages = [const AssetImage(earthFromSpace), ...imageList];

    return Scaffold(
      body: Stack(
        children: [
          BlurFilter(
            sigmaX: 10,
            sigmaY: 10,
            child: const EarthFromSpaceBGContainer(
              child: SizedBox.expand(),
            ),
          ),
          Column(
            children: [
              const SettingsHeader(title: 'Gallery', backButtonShown: true),
              GridView.count(
                crossAxisCount: 3,
                padding: EdgeInsets.zero,
                children: [
                  for (int i = 0; i < allImages.length; i++)
                    _ImageThumbnail(
                      image: allImages[i] as ImageProvider,
                      index: i,
                      pageController: pageController,
                    ),
                ],
              ).expanded(),
            ],
          ),
        ],
      ),
    );
  }
}

class _ImageThumbnail extends StatelessWidget {
  const _ImageThumbnail({
    required this.image,
    required this.index,
    required this.pageController,
  });

  final ImageProvider image;
  final int index;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog<void>(
          context: context,
          builder: (context) => _SelectedImagePage(
            image: image,
            index: index,
            pageController: pageController,
          ),
        );

        Future.delayed(const Duration(milliseconds: 50), () {
          if (pageController.hasClients) {
            pageController.jumpToPage(index);
          }
        });
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(image: image, fit: BoxFit.cover),
        ),
      ).paddingAll(3.5),
    );
  }
}

class _SelectedImage extends StatelessWidget {
  const _SelectedImage({required this.image});
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          height: height * 0.8,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 10,
          child: CircleContainer(
            size: 35,
            color: Colors.black54,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.close,
                color: Colors.white70,
                size: 25,
              ),
            ),
          ),
        ),
      ],
    ).center();
  }
}

class _SelectedImagePage extends StatefulWidget {
  const _SelectedImagePage({
    required this.image,
    required this.index,
    required this.pageController,
  });

  final ImageProvider image;
  final int index;
  final PageController pageController;

  @override
  State<_SelectedImagePage> createState() => _SelectedImagePageState();
}

class _SelectedImagePageState extends State<_SelectedImagePage> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() {
      _index = widget.pageController.page!.toInt();
    });
  }

  void _selectImageAndNavigateToHome(
    BuildContext context, {
    required String imagePath,
  }) {
    context.read<BgImageBloc>().add(
          BgImageSelectFromAppGallery(
            imageFile: File(imagePath),
          ),
        );

    GetIt.instance<TabNavigationController>().navigateToHome(context);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final imageList = [
      const WeatherImageModel(
        imageUrl: earthFromSpace,
        isDay: false,
        condition: WeatherImageType.clear,
      ),
      ...context.read<BgImageBloc>().state.bgImageList,
    ];

    final imageProviderList = imageList.map((imageModel) {
      if (imageModel.imageUrl == earthFromSpace) {
        return const AssetImage(earthFromSpace);
      }

      return CachedNetworkImageProvider(imageModel.imageUrl);
    }).toList();

    return Stack(
      children: [
        BlurFilter(
          child: const RoundedContainer(
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        RoundedContainer(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedContainer(
                height: height * 0.9,
                child: PageView(
                  controller: widget.pageController,
                  children: imageProviderList
                      .map(
                        (imageProvider) => _SelectedImage(
                          image: imageProvider as ImageProvider,
                        ),
                      )
                      .toList(),
                ).center(),
              ).expanded(),
              DefaultButton(
                label: 'Set image as background',
                fontSize: 16,
                buttonColor: Colors.black54,
                fontColor: Colors.white70,
                onPressed: () => _selectImageAndNavigateToHome(
                  context,
                  imagePath: imageList[_index].imageUrl,
                ),
              ).paddingOnly(top: 15, left: 5, right: 5),
            ],
          ).paddingSymmetric(horizontal: 10),
        ).center(),
        RoundedContainer(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleContainer(
                size: 70,
                child: IconButton(
                  onPressed: () {
                    var newIndex = _index - 1;
                    final length = imageList.length;
                    if (_index == 0) {
                      newIndex = length - 1;
                    }
                    if (widget.pageController.hasClients) {
                      widget.pageController.jumpToPage(newIndex);
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white60,
                    size: 35,
                  ).paddingOnly(right: 5),
                ),
              ),
              CircleContainer(
                size: 70,
                child: IconButton(
                  onPressed: () {
                    var newIndex = _index + 1;
                    final length = imageList.length;

                    if (newIndex == length) {
                      newIndex = 0;
                    }

                    if (widget.pageController.hasClients) {
                      widget.pageController.jumpToPage(newIndex);
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white60,
                    size: 35,
                  ).paddingOnly(left: 5),
                ),
              ),
            ],
          ),
        ).center(),
      ],
    );
  }
}
