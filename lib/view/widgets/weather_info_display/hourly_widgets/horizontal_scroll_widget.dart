import 'package:black_cat_lib/widgets/containers_cards.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
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
    return MyCard(
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

class DailyHorizontalScrollWidget extends StatelessWidget {
  DailyHorizontalScrollWidget({
    required this.widgetList,
    required this.layeredCard,
    required this.header,
    this.height,
    super.key,
  });

  final List<Widget> widgetList;
  final bool layeredCard;
  final Widget header;
  final int? height;

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header,
          BlocBuilder<ColorCubit, ColorState>(
            builder: (context, state) {
              return PartialRoundedContainer(
                height: height?.toDouble() ?? 250,
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
                        itemCount: widgetList.length,
                        itemBuilder: (context, index) {
                          return widgetList[index];
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
