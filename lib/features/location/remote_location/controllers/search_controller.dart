import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/features/location/remote_location/models/search_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'remote_location_controller.dart';

class SearchController extends GetxController {
  SearchController({
    required this.remoteLocationController,
    required this.apiCaller,
  });

  static SearchController get to => Get.find();

  final ApiCaller apiCaller;

  final RemoteLocationController remoteLocationController;

  final textController = TextEditingController();

  String description = '';

  RxString query = ''.obs;

  late Worker worker;

  RxString status = 'Loading...'.obs;

  RxBool noResults = false.obs;

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
    remoteLocationController.clearCurrentSearchList();

    final result = await apiCaller.fetchSuggestions(
      query: query.value,
      lang: Localizations.localeOf(Get.context!).languageCode,
    );

    _updateSearchStatus(result!);

    final predictionList = result['predictions'] as List;

    for (final prediction in predictionList) {
      final suggestion = SearchSuggestion.fromMap(
        map: prediction as Map<String, dynamic>,
        query: query.value,
      );

      if (_containsAllCharactersFromQuery(
        suggestion: suggestion.description.toLowerCase(),
        query: query.value.trim().toLowerCase(),
      )) {
        remoteLocationController.addToSearchList(suggestion);
      }
    }
  }

  bool _containsAllCharactersFromQuery({
    required String query,
    required String suggestion,
  }) {
    bool hasCharacters = true;
    for (int i = 0; i < query.trim().length; i++) {
      if (!suggestion.toLowerCase().contains(query[i])) {
        hasCharacters = false;
      }
    }
    return hasCharacters;
  }

  void _updateSearchStatus(Map result) {
    if ((result['status'] as String).toLowerCase() == 'zero_results') {
      noResults(true);
      status('No results');
    } else {
      noResults(false);
      status('Loading...');
    }
  }
}

class SearchControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      SearchController(
        apiCaller: ApiCaller.to,
        remoteLocationController: RemoteLocationController.to,
      ),
    );
  }
}
