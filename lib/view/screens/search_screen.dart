import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:epic_skies/view/dialogs/search_dialogs.dart';
import 'package:epic_skies/view/widgets/buttons/delete_search_history_button.dart';
import 'package:epic_skies/view/widgets/buttons/search_local_weather_button.dart';
import 'package:epic_skies/view/widgets/general/loading_indicator.dart';
import 'package:epic_skies/view/widgets/general/search_list_tile.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:epic_skies/view/widgets/labels/recent_search_label.dart';
import 'package:epic_skies/view/widgets/labels/rounded_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';

import '../../features/location/search/bloc/search_bloc.dart';
import '../../features/main_weather/bloc/weather_bloc.dart';
import '../../repositories/location_repository.dart';
import '../../services/ticker_controllers/tab_navigation_controller.dart';
import '../widgets/general/text_scale_factor_clamper.dart';
import 'tab_screens/saved_locations_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen();

  static const id = '/search_screen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchBloc(locationRepository: context.read<LocationRepository>()),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatelessWidget {
  const _SearchView();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              GetIt.instance<TabNavigationController>().navigateToHome(context);
            }
          },
        ),
        BlocListener<SearchBloc, SearchState>(
          listener: (context, state) {},
        ),
      ],
      child: TextScaleFactorClamper(
        child: SafeArea(
          child: Scaffold(
            body: WeatherImageContainer(
              child: Stack(
                children: [
                  Column(
                    children: [
                      _SearchField(),
                      const SearchLocalWeatherButton(
                        isSearchPage: true,
                      ),
                      const RecentSearchesLabel(isSearchPage: true),
                      Column(
                        children: [
                          BlocBuilder<SearchBloc, SearchState>(
                            builder: (context, state) {
                              return state.query == ''
                                  ? const SearchHistoryListView()
                                  : const _SuggestionList();
                            },
                          ),
                          const DeleteSavedLocationsButton(),
                        ],
                      ).paddingSymmetric(horizontal: 5).expanded(),
                    ],
                  ),
                  const LoadingIndicator()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.searchSuggestions.isEmpty || state.noResults
            ? RoundedLabel(label: state.status)
                .center()
                .paddingSymmetric(vertical: 3.sp)
            : ListView.builder(
                itemCount: state.searchSuggestions.length,
                itemBuilder: (context, index) => SearchListTile(
                  searching: true,
                  suggestion: state.searchSuggestions[index],
                ),
              ).expanded();
      },
    );
  }
}

class _SearchField extends StatelessWidget {
  _SearchField();

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.read<SearchBloc>();
    return ColoredBox(
      color: Colors.black87,
      child: Row(
        children: [
          IconButton(
            tooltip: 'Back',
            color: Colors.white70,
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          DefaultTextField(
            controller: textController,
            hintText: 'Search',
            textColor: Colors.white60,
            borderRadius: 0,
            borderColor: Colors.transparent,
            hintSize: 14.sp,
            autoFocus: true,
            onFieldSubmitted: (_) =>
                SearchDialogs.selectSearchFromListDialog(context),
            onChanged: (value) {
              AppDebug.log('Search Updated: $value', name: 'SEARCH SCREEN');
              searchBloc.add(SearchEntryUpdated(text: value));
            },
          ).expanded(),
          IconButton(
            tooltip: 'Clear',
            icon: const Icon(Icons.clear, color: Colors.white70),
            onPressed: () => searchBloc.add(
              SearchEntryUpdated(text: ''),
            ),
          ),
        ],
      ),
    );
  }
}
