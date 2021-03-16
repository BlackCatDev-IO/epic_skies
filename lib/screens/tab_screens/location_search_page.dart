import 'package:epic_skies/services/network/api_caller.dart';
import 'package:epic_skies/services/utils/search_controller.dart';
import 'package:epic_skies/widgets/general/search_list_tile.dart';
import 'package:epic_skies/widgets/general/search_local_weather_button.dart';
import 'package:epic_skies/widgets/weather_info_display/weather_image_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class LocationSearchPage extends SearchDelegate<SearchSuggestion> {
  LocationSearchPage(this.sessionToken);

  final apiCaller = ApiCaller();

  final String sessionToken;

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
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return WeatherImageContainer(
      child: FutureBuilder(
        future: query == ""
            ? null
            : apiCaller.fetchSuggestions(
                input: query,
                lang: Localizations.localeOf(context).languageCode),
        builder: (context, snapshot) => Scaffold(
          body: Column(
            children: [
              const SearchLocalWeatherWidget(),
              const Divider(
                thickness: 2,
                color: Colors.black,
              ),
              const MyTextWidget(text: 'Recent searches')
                  .center()
                  .paddingOnly(bottom: 10),
              if (query == '')
                searchHistory()
              else
                snapshot.hasData
                    ? ListView.builder(
                        itemBuilder: (context, index) => SearchListTile(
                          text: (snapshot.data[index] as SearchSuggestion)
                              .description,
                          onTap: () {
                            Get.find<SearchController>().searchSelectedLocation(
                                // placeId: placeId,
                                suggestion:
                                    snapshot.data[index] as SearchSuggestion);
                            close(context,
                                snapshot.data[index] as SearchSuggestion);
                          },
                        ),
                        itemCount: snapshot.data.length as int,
                        shrinkWrap: true,
                      )
                    : Container(
                        child: const MyTextWidget(text: 'Loading...').center(),
                      ),
            ],
          ).paddingSymmetric(horizontal: 10),
        ),
      ),
    );
  }

  Widget searchHistory() {
    return GetX<SearchController>(
      builder: (controller) {
        controller.searchHistory.removeWhere((value) => value == null);
        return ListView.builder(
          shrinkWrap: true,
          itemCount: controller.searchHistory.length,
          itemBuilder: (context, index) {
            return RoundedContainer(
              color: Colors.black54,
              radius: 7,
              child: ListTile(
                title: MyTextWidget(
                  text: (controller.searchHistory[index] as SearchSuggestion)
                      .description,
                ),
              ),
            );
          },
        );
      },
    ).paddingSymmetric(vertical: 2, horizontal: 5);
  }
}
