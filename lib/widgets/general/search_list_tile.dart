import 'package:epic_skies/global/alert_dialogs.dart';
import 'package:epic_skies/core/network/weather_repository.dart';
import 'package:epic_skies/services/utils/location/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:black_cat_lib/black_cat_lib.dart';

class SearchListTile extends StatelessWidget {
  final SearchSuggestion suggestion;

  const SearchListTile({required this.suggestion});
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: Colors.black54,
      radius: 7,
      child: ListTile(
        title: MyTextWidget(text: suggestion.description!, fontSize: 18),
        onTap: () async {
          WeatherRepository.to.fetchRemoteWeatherData(suggestion: suggestion);
        },
        trailing: IconButton(
          onPressed: () =>
              confirmDeleteSearch(context: context, suggestion: suggestion),
          icon: const Icon(Icons.delete, color: Colors.white38),
        ),
      ),
    ).paddingSymmetric(vertical: 5);
  }
}
