import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/services/utils/location/search_controller.dart';
import 'package:epic_skies/widgets/general/search_list_tile.dart';
import 'package:epic_skies/widgets/general/search_local_weather_button.dart';
import 'package:epic_skies/widgets/weather_info_display/weather_image_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';
import 'package:hexcolor/hexcolor.dart';

class LocationSearchPage extends SearchDelegate<SearchSuggestion?> {
  LocationSearchPage(this.sessionToken);

  final apiCaller = ApiCaller();

  final String sessionToken;

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: HexColor('#181818'),
      ),
      textTheme: const TextTheme(
        headline6: TextStyle(
            color: Colors.white70, fontSize: 20.0, fontWeight: FontWeight.w200),
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.grey[600]),
            border: InputBorder.none,
          ),
    );
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query != '') {
      apiCaller.fetchSuggestions(
          input: query, lang: Localizations.localeOf(context).languageCode);
    }
    return _suggestionBuilder();
  }

  Widget _suggestionBuilder() {
    return Scaffold(
      body: WeatherImageContainer(
        child: Column(
          children: [
            const SearchLocalWeatherWidget(),
            const Divider(
              thickness: 1.5,
              color: Colors.black87,
            ),
            if (query == '') _searchHistory() else _suggestionList(),
          ],
        ).paddingSymmetric(horizontal: 10),
      ),
    );
  }

  Widget _suggestionList() {
    return GetX<SearchController>(
      builder: (controller) {
        if (controller.currentSearchList.isEmpty) {
          return Container(
              child: const MyTextWidget(text: 'Loading...').center());
        } else {
          return ListView.builder(
              itemCount: controller.currentSearchList.length,
              itemBuilder: (context, index) =>
                  controller.currentSearchList[index] as Widget).expanded();
        }
      },
    );
  }

  Widget _searchHistory() {
    return ListView(
      children: [
        const MyTextWidget(text: 'Recent searches')
            .center()
            .paddingOnly(bottom: 10),
        GetX<SearchController>(
          builder: (controller) {
            controller.searchHistory.removeWhere((value) => value == null);
            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.searchHistory.length,
              itemBuilder: (context, index) {
                return SearchListTile(
                    suggestion:
                        controller.searchHistory[index] as SearchSuggestion);
              },
            );
          },
        ).paddingSymmetric(vertical: 2, horizontal: 5),
      ],
    ).expanded();
  }
}
