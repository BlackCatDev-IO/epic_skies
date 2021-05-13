import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/view/widgets/general/search_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'location_controller.dart';

class SearchController extends GetxController {
  static SearchController get to => Get.find();

  final textController = TextEditingController();
  RxString query = ''.obs;

  late Worker worker;

  @override
  void onInit() {
    super.onInit();
    textController.addListener(() {
      query.value = textController.text;
    });
    worker = ever(query, (value) {
      if (value != '') {
        _buildSuggestionList();
      }
    });
  }

  @override
  void onClose() {
    worker.dispose();
  }

  Future<void> _buildSuggestionList() async {
    LocationController.to.currentSearchList.clear();

    final url = ApiCaller.to.buildSearchSuggestionUrl(
        query: query.value,
        lang: Localizations.localeOf(Get.context!).languageCode);

    final result = await ApiCaller.to.fetchSuggestions(url: url);

    final prediction = result!['predictions'] as List;

    for (int i = 0; i < prediction.length; i++) {
      final map = prediction[i];

      final description = map['description'] as String?;
      final placeId = map['place_id'] as String?;
      final suggestion =
          SearchSuggestion(description: description, placeId: placeId);
      final tile = SearchListTile(suggestion: suggestion);

      LocationController.to.currentSearchList.add(tile);
    }
  }
}

class SearchControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchController());
  }
}

class SearchSuggestion {
  final String? placeId;
  final String? description;

  SearchSuggestion({this.placeId, this.description});

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}
