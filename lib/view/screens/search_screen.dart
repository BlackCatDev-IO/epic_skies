import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:epic_skies/extensions/widget_extensions.dart';
import 'package:epic_skies/features/location/search/bloc/search_bloc.dart';
import 'package:epic_skies/features/main_weather/bloc/weather_bloc.dart';
import 'package:epic_skies/repositories/location_repository.dart';
import 'package:epic_skies/services/ticker_controllers/tab_navigation_controller.dart';
import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:epic_skies/view/dialogs/search_dialogs.dart';
import 'package:epic_skies/view/screens/tab_screens/saved_locations_screen.dart';
import 'package:epic_skies/view/widgets/buttons/delete_search_history_button.dart';
import 'package:epic_skies/view/widgets/buttons/local_weather_button.dart';
import 'package:epic_skies/view/widgets/general/loading_indicator.dart';
import 'package:epic_skies/view/widgets/general/search_list_tile.dart';
import 'package:epic_skies/view/widgets/general/text_scale_factor_clamper.dart';
import 'package:epic_skies/view/widgets/image_widget_containers/weather_image_container.dart';
import 'package:epic_skies/view/widgets/labels/recent_search_label.dart';
import 'package:epic_skies/view/widgets/labels/rounded_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          GetIt.instance<TabNavigationController>().navigateToHome(context);
        }
      },
      child: TextScaleFactorClamper(
        child: SafeArea(
          child: Scaffold(
            body: WeatherImageContainer(
              child: Stack(
                children: [
                  Column(
                    children: [
                      _SearchField(),
                      const LocalWeatherButton(
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
            ? RoundedLabel(
                label: state.status,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ).center().paddingSymmetric(vertical: 10)
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
            iconSize: 25,
          ),
          DefaultTextField(
            controller: textController,
            hintText: 'Search',
            textColor: Colors.white60,
            borderRadius: 0,
            borderColor: Colors.transparent,
            hintSize: 25,
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
            iconSize: 25,
          ),
        ],
      ),
    );
  }
}
