import 'dart:async';

import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/banner_ads/bloc/ad_bloc.dart';
import 'package:epic_skies/features/daily_forecast/cubit/daily_forecast_cubit.dart';
import 'package:epic_skies/features/daily_forecast/cubit/daily_forecast_state.dart';
import 'package:epic_skies/features/daily_forecast/models/daily_forecast_model.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/models/widget_models/daily_nav_button_model.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout.dart';
import 'package:epic_skies/services/view_controllers/color_cubit/color_cubit.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:epic_skies/view/widgets/ad_widgets/native_ad_list_tile.dart';
import 'package:epic_skies/view/widgets/general/loading_indicator.dart';
import 'package:epic_skies/view/widgets/labels/remote_location_label.dart';
import 'package:epic_skies/view/widgets/weather_info_display/daily_widgets/daily_forecast_widget.dart';
import 'package:epic_skies/view/widgets/weather_info_display/daily_widgets/weekly_forecast_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DailyForecastPage extends StatefulWidget {
  const DailyForecastPage({super.key});

  static const id = 'daily_forecast_page';

  @override
  State<DailyForecastPage> createState() => _DailyForecastPage();
}

class _DailyForecastPage extends State<DailyForecastPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  late final DailyForecastCubit _dailyCubit;

  List<Widget> _dailyWidgetList = [];

  List<int> _adRemovedWidgetIndexList = [];

  final int _selectedDayIndex = 0;

  late List<(int, int)> _dateIndexRecordList;

  void _initDailyWidgetList(
    List<DailyForecastModel> dailyModelList,
    bool showAds,
  ) {
    _dailyWidgetList = dailyModelList
        // ignore: unnecessary_cast
        .map((model) => DailyForecastWidget(model: model) as Widget)
        .toList();

    _dailyWidgetList.insert(
      _dailyWidgetList.length,
      _BackToTopButton(),
    );

    if (!showAds) {
      _adRemovedWidgetIndexList =
          List.generate(_dailyWidgetList.length, (index) => index);
      return;
    }

    const desiredWidgetListLengthWithAds = 14;

    _adRemovedWidgetIndexList =
        List.generate(desiredWidgetListLengthWithAds, (index) => index);

    for (var i = 0; i < desiredWidgetListLengthWithAds; i++) {
      if (i.isEven && i != 0) {
        _dailyWidgetList.insert(i, const NativeAdListTile());
        _adRemovedWidgetIndexList.remove(i);
      }
    }
    AppDebug.log(
      'adLoadedIndexList $_adRemovedWidgetIndexList',
    );
  }

  void _initScrollPositionListener() {
    _itemPositionsListener.itemPositions.addListener(() {
      final itemLeadingEdge =
          _itemPositionsListener.itemPositions.value.first.itemLeadingEdge;

      final listenerIndex =
          _itemPositionsListener.itemPositions.value.first.index;

      if (listenerIndex == -1) return;

      /// Prevents this from getting called hundreds of times
      /// as user scrolls
      if (itemLeadingEdge != 0.0 && listenerIndex != _selectedDayIndex) {
        final newIndex = _adRemovedWidgetIndexList.indexOf(listenerIndex);
        final selectedDay = _dateIndexRecordList[newIndex].$2;
        final firstDay = _dateIndexRecordList.first.$2;
        final lastDay = _dateIndexRecordList.last.$2;

        /// -1 means no matching index found in `indexOf` which results in
        /// the highlight disappearing
        if (newIndex != -1) {
          _dailyCubit.updatedSelectedDay(selectedDay);
        }

        if (itemLeadingEdge == 0.0 && listenerIndex == 0) {
          _dailyCubit.updatedSelectedDay(firstDay);
        }

        if (itemLeadingEdge < -0.7 && listenerIndex == 23) {
          _dailyCubit.updatedSelectedDay(lastDay);
        }
      }
    });
  }

  Future<void> _scrollToIndex(int index) async {
    _logDailyForecastPage('initial index: $index');

    var updatedIndex = 0;

    if (index < _dailyCubit.state.dailyForecastModelList.length - 1) {
      updatedIndex = _adRemovedWidgetIndexList[index];
    } else {
      updatedIndex = _dailyWidgetList.length - 1;
    }

    _logDailyForecastPage('updated index: $updatedIndex');

    if (_itemScrollController.isAttached) {
      _itemScrollController.jumpTo(
        index: updatedIndex,
      );
    }
  }

  void _logDailyForecastPage(String message) {
    AppDebug.log(message, name: 'DailyForecastPage');
  }

  /// prevents scrollAfterFirstBuild from running if user didn't navigate
  /// to Daily tab from Home tab
  bool navigateToDailyTabFromHome = true;

  /// Call only once after Daily tab is built the first time. And only called
  /// if user has navigated to Daily tab from the home tab right after app start
  /// Without this, if the user navigates to the Daily tab right after
  /// restarting before the Daily tab has been built, scrollToIndex
  /// won't work because it will have had nothing to attach to
  /// This will not run if user jumps to Daily tab from TabBar the first time
  void scrollAfterFirstBuild() {
    _logDailyForecastPage(
      'scroll after first build selectedIndex: $_selectedDayIndex',
    );
    _scrollToIndex(_getSelectedDayIndex());
  }

  @override
  void initState() {
    super.initState();
    _dailyCubit = context.read<DailyForecastCubit>();
    final dailyModelList = _dailyCubit.state.dailyForecastModelList;
    final showAds = context.read<AdBloc>().state.status.isShowAds;
    _dateIndexRecordList = List.generate(
      _dailyCubit.state.navButtonModelList.length,
      (index) => (index, _dailyCubit.state.navButtonModelList[index].date),
    );

    _initScrollPositionListener();
    _initDailyWidgetList(dailyModelList, showAds);
  }

  bool _hasBuiltOnce = false;

  int _getSelectedDayIndex() {
    final selectedDay = _dailyCubit.state.navButtonModelList.firstWhere(
      (element) => element.isSelected,
      orElse: () => _dailyCubit.state.navButtonModelList.first,
    );
    final indexRecord = _dateIndexRecordList.firstWhere(
      (record) => record.$2 == selectedDay.date,
      orElse: () => _dateIndexRecordList.first,
    );

    return indexRecord.$1;
  }

  @override
  Widget build(BuildContext context) {
    /// runs only once to ensure scrollToIndex happens after the very first
    /// build
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final fromHomeTab = navigateToDailyTabFromHome;
        if (!_hasBuiltOnce && fromHomeTab) {
          scrollAfterFirstBuild();
          _hasBuiltOnce = true;
        }
      },
    );
    super.build(context);
    return BlocListener<DailyForecastCubit, DailyForecastState>(
      listenWhen: (previous, current) =>
          previous.navButtonModelList != current.navButtonModelList,
      listener: (context, state) {
        final selectedDay = _dailyCubit.state.navButtonModelList.firstWhere(
          (element) => element.isSelected,
          orElse: () => _dailyCubit.state.navButtonModelList.first,
        );

        if (selectedDay.autoScroll) {
          _scrollToIndex(_getSelectedDayIndex());
        }
      },
      child: PullToRefreshPage(
        onRefresh: () async =>
            context.read<LocationBloc>().add(LocationUpdatePreviousRequest()),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: getIt<AdaptiveLayout>().appBarPadding,
                ),
                const RemoteLocationLabel(),
                const WeeklyForecastRow(isDailyPage: true),
                sizedBox5High,
                BlocBuilder<AdBloc, AdState>(
                  builder: (context, state) {
                    final showAds = state.status.isShowAds;
                    return BlocBuilder<DailyForecastCubit, DailyForecastState>(
                      builder: (context, state) {
                        _initDailyWidgetList(
                          state.dailyForecastModelList,
                          showAds,
                        );
                        return ScrollablePositionedList.builder(
                          itemScrollController: _itemScrollController,
                          itemPositionsListener: _itemPositionsListener,
                          padding: EdgeInsets.zero,
                          itemCount: _dailyWidgetList.length,
                          itemBuilder: (_, index) => _dailyWidgetList[index],
                        ).expanded();
                      },
                    );
                  },
                ),
              ],
            ).paddingSymmetric(horizontal: 2.5),
            const LoadingIndicator(),
          ],
        ),
      ),
    );
  }
}

class _BackToTopButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorCubit, ColorState>(
      builder: (context, state) {
        return DefaultButton(
          label: 'Back to top',
          height: 65,
          fontSize: 14,
          fontWeight: FontWeight.w300,
          buttonColor: state.theme.soloCardColor,
          onPressed: () {
            final dailyCubit = context.read<DailyForecastCubit>();

            dailyCubit.updatedSelectedDay(
              dailyCubit.state.navButtonModelList.first.date,
              autoScroll: true,
            );
          },
        );
      },
    ).paddingOnly(left: 5, right: 5, bottom: 10);
  }
}

class DailyNavButton extends StatelessWidget {
  const DailyNavButton({
    required this.model,
    required this.onTap,
    super.key,
  });

  final void Function() onTap;

  final DailyNavButtonModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyForecastCubit, DailyForecastState>(
      buildWhen: (previous, current) {
        final previouslySelected = previous.navButtonModelList.firstWhere(
          (element) => element.isSelected,
          orElse: () => previous.navButtonModelList.first,
        );
        final currentSelected = current.navButtonModelList.firstWhere(
          (element) => element.isSelected,
          orElse: () => current.navButtonModelList.first,
        );

        return model == previouslySelected || model == currentSelected;
      },
      builder: (context, state) {
        return RoundedContainer(
          borderColor: model.isSelected ? Colors.blue[100] : Colors.transparent,
          radius: 12,
          width: 60,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onTap,
            child: Column(
              children: [
                sizedBox5High,
                Text(
                  model.day,
                  style: TextStyle(
                    color: Colors.blueAccent[100],
                    fontSize: 15,
                  ),
                ),
                Text(
                  model.month,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Colors.yellow[100],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                Text(
                  model.date.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                sizedBox5High,
              ],
            ),
          ),
        );
      },
    );
  }
}
