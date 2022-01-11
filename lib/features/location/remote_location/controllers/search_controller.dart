import 'package:black_cat_lib/extensions/string_extensions.dart';
import 'package:epic_skies/core/network/api_caller.dart';
import 'package:epic_skies/features/location/remote_location/models/search_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'remote_location_controller.dart';

class SearchController extends GetxController {
  static SearchController get to => Get.find();

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
    RemoteLocationController.to.currentSearchList.clear();

    final result = await ApiCaller.fetchSuggestions(
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

      _populateSearchList(suggestion);
    }
  }

  void _populateSearchList(SearchSuggestion suggestion) {
    final queryHasLettersAndNumbers = query.value.hasNumber;

    if (queryHasLettersAndNumbers) {
      RemoteLocationController.to.addToSearchList(suggestion);
    } else {
      RemoteLocationController.to.addToSearchList(suggestion);
    }
  }

  void _updateSearchStatus(Map result) {
    if (result['status'].toLowerCase() == 'zero_results') {
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
    Get.put(SearchController());
  }
}
