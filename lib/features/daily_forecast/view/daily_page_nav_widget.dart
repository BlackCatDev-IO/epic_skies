part of 'daily_forecast_page.dart';

class _DailyPageNavWidget extends StatelessWidget {
  const _DailyPageNavWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyForecastCubit, DailyForecastState>(
      builder: (context, state) {
        final dailyCubit = context.read<DailyForecastCubit>();

        final navButtonModelList = dailyCubit.state.navButtonModelList;

        final dailyPageList = navButtonModelList
            .map(
              (navModel) => _DailyNavButton(
                model: navModel,
                onTap: () => dailyCubit.updatedSelectedDay(
                  navModel.date,
                  autoScroll: true,
                ),
              ),
            )
            .toList();

        return _HorizontalScrollView(widgetList: dailyPageList);
      },
    );
  }
}

class _HorizontalScrollView extends StatelessWidget {
  _HorizontalScrollView({
    required this.widgetList,
  });

  final List<Widget> widgetList;

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(
            label: 'Daily Forecast',
          ),
          BlocBuilder<ColorCubit, ColorState>(
            builder: (context, state) {
              return PartialRoundedContainer(
                height: 80,
                color: state.theme.soloCardColor,
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
