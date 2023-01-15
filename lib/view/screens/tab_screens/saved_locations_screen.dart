import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/view/widgets/buttons/delete_search_history_button.dart';
import 'package:epic_skies/view/widgets/buttons/search_local_weather_button.dart';
import 'package:epic_skies/view/widgets/general/loading_indicator.dart';
import 'package:epic_skies/view/widgets/general/search_list_tile.dart';
import 'package:epic_skies/view/widgets/labels/recent_search_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:iphone_has_notch/iphone_has_notch.dart';
import 'package:sizer/sizer.dart';

import '../../../features/location/remote_location/bloc/location_bloc.dart';
import '../../../features/location/search/bloc/search_bloc.dart';
import '../../../features/main_weather/bloc/weather_bloc.dart';
import '../../../repositories/location_repository.dart';
import '../../../services/ticker_controllers/tab_navigation_controller.dart';
import '../../../services/view_controllers/adaptive_layout_controller.dart';

class SavedLocationScreen extends StatelessWidget {
  static const id = 'saved_location_screen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) =>
          SearchBloc(locationRepository: context.read<LocationRepository>()),
      child: BlocListener<WeatherBloc, WeatherState>(
        listenWhen: (previous, current) =>
            TabNavigationController.to.tabController.index == 3,
        listener: (context, state) async {
          if (state.status.isSuccess) {
            TabNavigationController.to.navigateToHome();
          }
        },
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: GetIt.instance<AdaptiveLayout>().appBarPadding.h,
                ),
                const SearchLocalWeatherButton(
                  isSearchPage: false,
                ),
                const RecentSearchesLabel(isSearchPage: false),
                const SearchHistoryListView(),
                const DeleteSavedLocationsButton(),
                if (IphoneHasNotch.hasNotch)
                  const SizedBox(height: 30)
                else
                  sizedBox10High,
              ],
            ),
            const LoadingIndicator()
          ],
        ),
      ),
    );
  }
}

class SearchHistoryListView extends StatelessWidget {
  const SearchHistoryListView();

  @override
  Widget build(BuildContext context) {
    /// Theme gets rid of ugly white border when dragging
    return Theme(
      data: ThemeData(
        canvasColor: Colors.transparent,
      ),
      child: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          return ReorderableListView(
            onReorder: (oldIndex, newIndex) => context.read<LocationBloc>().add(
                  LocationReorderSearchList(
                    oldIndex: oldIndex,
                    newIndex: newIndex,
                  ),
                ),
            padding: EdgeInsets.zero,
            children: [
              for (int index = 0; index < state.searchHistory.length; index++)
                SearchListTile(
                  key: Key('$index'),
                  suggestion: state.searchHistory[index],
                  searching: false,
                ),
            ],
          ).paddingSymmetric(vertical: 2, horizontal: 5).expanded();
        },
      ),
    );
  }
}
