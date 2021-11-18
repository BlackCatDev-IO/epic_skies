import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/view/widgets/general/search_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'remote_location_controller.dart';

class SearchController extends GetxController {
  static SearchController get to => Get.find();

  final textController = TextEditingController();

  String description = '';

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
    RemoteLocationController.to.currentSearchList.clear();

    final url = ApiCaller.to.buildSearchSuggestionUrl(
      query: query.value,
      lang: Localizations.localeOf(Get.context!).languageCode,
    );

    final result = await ApiCaller.to.fetchSuggestions(url: url);

    final prediction = result!['predictions'] as List;

    for (int i = 0; i < prediction.length; i++) {
      final map = prediction[i];

      description = map['description'] as String;

      _checkForOddFormatting();

      final placeId = map['place_id'] as String?;
      final suggestion =
          SearchSuggestion(description: description, placeId: placeId!);
      final tile = SearchListTile(suggestion: suggestion, searching: true);

      RemoteLocationController.to.currentSearchList.add(tile);
    }
  }

  /// Sometimes the search suggestions can have imperfect formatting
  /// Anything I notice I add to this function
  void _checkForOddFormatting() {
    switch (description.toLowerCase()) {
      case 'bogotá, bogota, colombia':
        description = 'Bogotá, Colombia';
        break;
      case 'sydney nsw, australia':
        description = 'Sydney, NSW, Australia';
        break;
      default:
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
  final String placeId;
  final String description;

  SearchSuggestion({required this.placeId, required this.description});

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}
