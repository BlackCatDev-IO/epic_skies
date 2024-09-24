import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/view/widgets/containers/custom_card.dart';
import 'package:epic_skies/view/widgets/containers/partial_rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HorizontalScrollWidget extends StatelessWidget {
  HorizontalScrollWidget({
    required this.list,
    required this.layeredCard,
    required this.header,
    super.key,
  });

  final List<dynamic> list;
  final bool layeredCard;
  final Widget header;

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header,
          BlocBuilder<ColorCubit, ColorState>(
            builder: (context, state) {
              return PartialRoundedContainer(
                height: 210,
                color: layeredCard
                    ? state.theme.layeredCardColor
                    : state.theme.soloCardColor,
                bottomLeft: 10,
                bottomRight: 10,
                child: Theme(
                  data: ThemeData(
                    highlightColor: Colors.grey,
                    platform: TargetPlatform.android,
                  ),
                  child: MediaQuery(
                    data: MediaQuery.of(context)
                        .removePadding(removeBottom: true),
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
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
