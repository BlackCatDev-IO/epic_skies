import 'package:black_cat_lib/widgets/containers_cards.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HorizontalScrollWidget extends StatelessWidget {
  HorizontalScrollWidget({
    super.key,
    required this.list,
    required this.layeredCard,
    required this.header,
  });

  final List<dynamic> list;
  final bool layeredCard;
  final Widget header;

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header,
          BlocBuilder<ColorCubit, ColorState>(
            builder: (context, state) {
              return PartialRoundedContainer(
                height: 20,
                color: layeredCard
                    ? state.theme.layeredCardColor
                    : state.theme.soloCardColor,
                bottomLeft: 10,
                bottomRight: 10,
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: _scrollController,
                  thickness: 2,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return list[index] as Widget;
                    },
                  ),
                ).paddingSymmetric(horizontal: 5),
              );
            },
          ),
        ],
      ),
    );
  }
}
