import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/location/bloc/location_bloc.dart';
import 'package:epic_skies/features/location/search/bloc/search_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/global/app_theme.dart';
import 'package:epic_skies/repositories/location_repository.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/services/view_controllers/adaptive_layout.dart';
import 'package:epic_skies/view/widgets/buttons/delete_search_history_button.dart';
import 'package:epic_skies/view/widgets/buttons/local_weather_button.dart';
import 'package:epic_skies/view/widgets/general/loading_indicator.dart';
import 'package:epic_skies/view/widgets/general/search_list_tile.dart';
import 'package:epic_skies/view/widgets/labels/recent_search_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedLocationScreen extends StatelessWidget {
  const SavedLocationScreen({super.key});

  static const id = 'saved_location_screen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) =>
          SearchBloc(locationRepository: context.read<LocationRepository>()),
      child: BlocListener<WeatherBloc, WeatherState>(
        listenWhen: (previous, current) {
          return getIt<TabNavigationController>().tabController.index == 3;
        },
        listener: (context, state) async {
          if (state.status.isSuccess) {
            await getIt<TabNavigationController>().jumpToTab(index: 0);
          }
        },
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: getIt<AdaptiveLayout>().appBarPadding,
                ),
                const LocalWeatherButton(
                  isSearchPage: false,
                ),
                const RecentSearchesLabel(isSearchPage: false),
                const SearchHistoryListView(),
                const DeleteSavedLocationsButton(),
                if (getIt<AdaptiveLayout>().hasNotchOrDynamicIsland)
                  const SizedBox(height: 30)
                else
                  sizedBox10High,
              ],
            ),
            const LoadingIndicator(),
          ],
        ),
      ),
    );
  }
}

class SearchHistoryListView extends StatelessWidget {
  const SearchHistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    /// Theme gets rid of ugly white border when dragging
    return Theme(
      data: epicSkiesTheme.copyWith(
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
