import 'package:black_cat_lib/widgets/my_custom_widgets.dart';
import 'package:epic_skies/services/view_controllers/color_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HorizontalScrollWidget extends StatelessWidget {
  final List list;
  final bool layeredCard;
  final Widget header;

  HorizontalScrollWidget({
    required this.list,
    required this.layeredCard,
    required this.header,
  });

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header,
          GetBuilder<ColorController>(
            builder: (controller) => PartialRoundedContainer(
              height: 20.h,
              color: layeredCard
                  ? controller.theme.layeredCardColor
                  : controller.theme.soloCardColor,
              bottomLeft: 10,
              bottomRight: 10,
              child: Scrollbar(
                isAlwaysShown: true,
                controller: _scrollController,
                thickness: 2.0,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return list[index] as Widget;
                  },
                ),
              ).paddingSymmetric(horizontal: 5),
            ),
          ),
        ],
      ),
    );
  }
}
