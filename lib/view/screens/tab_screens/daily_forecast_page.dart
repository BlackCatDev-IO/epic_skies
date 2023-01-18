import 'dart:async';

import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/view/widgets/labels/remote_location_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizer/sizer.dart';

import '../../../features/banner_ads/bloc/ad_bloc.dart';
import '../../../features/daily_forecast/daily_forecast_cubit/daily_forecast_cubit.dart';
import '../../../features/daily_forecast/daily_forecast_cubit/daily_forecast_state.dart';
import '../../../features/daily_forecast/models/daily_forecast_model.dart';
import '../../../features/location/bloc/location_bloc.dart';
import '../../../models/widget_models/daily_nav_button_model.dart';
import '../../../services/view_controllers/adaptive_layout.dart';
import '../../../services/view_controllers/color_cubit/color_cubit.dart';
import '../../../utils/logging/app_debug_log.dart';
import '../../widgets/ad_widgets/native_ad_list_tile.dart';
import '../../widgets/general/loading_indicator.dart';
import '../../widgets/weather_info_display/daily_widgets/daily_forecast_widget.dart';

class DailyForecastPage extends StatefulWidget {
  static const id = 'daily_forecast_page';

  @override
  _DailyForecastPage createState() => _DailyForecastPage();
}

class _DailyForecastPage extends State<DailyForecastPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  late final DailyForecastCubit _dailyController;

  List<Widget> _dailyWidgetList = [];

  List<int> _adRemovedWidgetIndexList = [];

  final int _selectedDayIndex = 0;

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
    const desiredWidgetListLengthWithAds = 24;

    _adRemovedWidgetIndexList =
        List.generate(desiredWidgetListLengthWithAds, (index) => index);

    for (int i = 0; i < desiredWidgetListLengthWithAds; i++) {
      if (i.isEven && i != 0) {
        _dailyWidgetList.insert(i, NativeAdListTile());
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

      /// Prevents this from getting called hundreds of times
      /// as user scrolls
      if (itemLeadingEdge != 0.0 && listenerIndex != _selectedDayIndex) {
        final newIndex = _adRemovedWidgetIndexList.indexOf(listenerIndex);
        _logDailyForecastPage('newIndex: $newIndex');

        /// -1 means no matching index found in `indexOf` which results in
        /// the highlight disappearing
        // if (_hasBuiltOnce) {
        if (newIndex != -1) {
          _dailyController.updateSelectedDayStatus(index: newIndex);
        }
        // }

        if (itemLeadingEdge == 0.0 && listenerIndex == 0) {
          _dailyController.updateSelectedDayStatus(index: 0);
        }

        if (itemLeadingEdge < -0.7 && listenerIndex == 23) {
          _dailyController.updateSelectedDayStatus(index: 13);
        }
      }
      _logDailyForecastPage(
        'itemLeadingEdge: $itemLeadingEdge listenerIndex: $listenerIndex',
      );
    });
  }

  Future<void> _scrollToIndex(int index) async {
    _dailyController.updateSelectedDayStatus(index: index);

    _logDailyForecastPage('initial index: $index');

    int updatedIndex = 0;

    if (index < _dailyController.state.dailyForecastModelList.length - 1) {
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
    _scrollToIndex(_dailyController.state.selectedDayIndex);
  }

  @override
  void initState() {
    super.initState();
    _dailyController = context.read<DailyForecastCubit>();
    final dailyModelList = _dailyController.state.dailyForecastModelList;
    final showAds = context.read<AdBloc>().state is ShowAds;
    _initScrollPositionListener();
    _initDailyWidgetList(dailyModelList, showAds);
  }

  bool _hasBuiltOnce = false;

  @override
  Widget build(BuildContext context) {
    /// runs only once to ensure scrollToIndex happens after the very first build
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
          previous.selectedDayIndex != current.selectedDayIndex,
      listener: (context, state) {
        _scrollToIndex(state.selectedDayIndex);
      },
      child: PullToRefreshPage(
        onRefresh: () async =>
            context.read<LocationBloc>().add(LocationUpdatePreviousRequest()),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: GetIt.instance<AdaptiveLayout>().appBarPadding.h,
                ),
                const RemoteLocationLabel(),
                _DailyNavWidget(),
                sizedBox5High,
                BlocBuilder<AdBloc, AdState>(
                  builder: (context, state) {
                    final showAds = state is ShowAds;
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
                          itemBuilder: (context, index) {
                            return _dailyWidgetList[index];
                          },
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

class _DailyNavWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dailyCubit = context.read<DailyForecastCubit>();
    return BlocBuilder<ColorCubit, ColorState>(
      builder: (context, state) {
        return RoundedContainer(
          color: state.theme.soloCardColor,
          child: Column(
            children: [
              Row(
                children: dailyCubit.state.week1NavButtonList
                    .map(
                      (model) => _DailyNavButton(
                        model: model,
                        onTap: () =>
                            dailyCubit.updatedSelectedDayIndex(model.index),
                      ),
                    )
                    .toList(),
              ),
              Row(
                children: dailyCubit.state.week2NavButtonList
                    .map(
                      (model) => _DailyNavButton(
                        model: model,
                        onTap: () =>
                            dailyCubit.updatedSelectedDayIndex(model.index),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    ).paddingSymmetric(horizontal: 3);
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
          fontSize: 14.sp,
          fontWeight: FontWeight.w300,
          buttonColor: state.theme.soloCardColor,
          onPressed: () {
            context.read<DailyForecastCubit>().updatedSelectedDayIndex(0);
          },
        );
      },
    ).paddingOnly(left: 5, right: 5, bottom: 10);
  }
}

class _DailyNavButton extends StatelessWidget {
  const _DailyNavButton({required this.model, required this.onTap});

  final Function() onTap;

  final DailyNavButtonModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyForecastCubit, DailyForecastState>(
      builder: (context, state) {
        return RoundedContainer(
          borderColor: state.selectedDayList[model.index]
              ? Colors.blue[100]
              : Colors.transparent,
          radius: 12,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => onTap(),
            child: Column(
              children: [
                sizedBox5High,
                MyTextWidget(
                  text: model.day,
                  color: Colors.blueAccent[100],
                  fontSize: 11.sp,
                ),
                MyTextWidget(
                  text: model.month,
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.yellow[100],
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                MyTextWidget(
                  text: model.date,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                ),
                sizedBox5High,
              ],
            ),
          ),
        ).expanded();
      },
    );
  }
}
