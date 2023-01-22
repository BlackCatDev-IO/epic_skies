import 'dart:io';

import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/global/local_constants.dart';
import 'package:epic_skies/services/asset_controllers/bg_image/bloc/bg_image_bloc.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:epic_skies/view/widgets/settings_widgets/settings_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';

import '../../../services/ticker_controllers/tab_navigation_controller.dart';

class WeatherImageGallery extends StatelessWidget {
  static const id = '/weather_image_gallery';

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final imageFileList = context.read<BgImageBloc>().state.imageFileList;
    return NotchDependentSafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            BlurFilter(
              sigmaX: 10,
              sigmaY: 10,
              child: const FixedImageContainer(
                imagePath: earthFromSpace,
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
                    for (int i = 0; i < imageFileList.length; i++)
                      _ImageThumbnail(
                        image: FileImage(File(imageFileList[i])),
                        path: imageFileList[i],
                        index: i,
                        pageController: pageController,
                      ),
                  ],
                ).expanded()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageThumbnail extends StatelessWidget {
  const _ImageThumbnail({
    required this.image,
    required this.path,
    required this.index,
    required this.pageController,
  });

  final ImageProvider image;
  final String path;
  final int index;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => _SelectedImagePage(
            image: image,
            path: path,
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
  final ImageProvider image;
  final String path;

  const _SelectedImage({required this.image, required this.path});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        RoundedContainer(
          height: height * 0.8,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(image: image, fit: BoxFit.cover),
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
                size: 25.0,
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
    required this.path,
    required this.index,
    required this.pageController,
  });

  final ImageProvider image;
  final String path;
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
    final imageFileList = context.read<BgImageBloc>().state.imageFileList;
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
                  children: [
                    for (final file in imageFileList)
                      _SelectedImage(
                        image: FileImage(File(file)),
                        path: widget.path,
                      )
                  ],
                ).center(),
              ).expanded(),
              DefaultButton(
                label: 'Set image as background',
                fontSize: 13.sp,
                buttonColor: Colors.black54,
                fontColor: Colors.white70,
                onPressed: () => _selectImageAndNavigateToHome(
                  context,
                  imagePath: imageFileList[_index],
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
                    int newIndex = _index - 1;
                    final length = imageFileList.length;
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
                    size: 35.0,
                  ).paddingOnly(right: 5),
                ),
              ),
              CircleContainer(
                size: 70,
                child: IconButton(
                  onPressed: () {
                    int newIndex = _index + 1;
                    final length = imageFileList.length;

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
                    size: 35.0,
                  ).paddingOnly(left: 5),
                ),
              )
            ],
          ),
        ).center(),
      ],
    );
  }
}
