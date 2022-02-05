import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/features/location/remote_location/models/remote_location_model.dart';
import 'package:epic_skies/features/location/remote_location/models/search_suggestion.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../../../mocks/mock_api_responses/mock_remote_location_response.dart';
import '../../../../test_utils.dart';

Future<void> main() async {
  late SearchSuggestion suggestion;
  late RemoteLocationModel modelFromResponse;
  setUpAll(() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    Get.put(StorageController());
    await StorageController.to
        .initAllStorage(path: 'remote_location_model_test');

    suggestion = const SearchSuggestion(
      placeId: 'ChIJzUSqzuyVLg4Rizt0nHlnn3k',
      description: 'Ouagadougou, Burkina Faso',
    );

    modelFromResponse = RemoteLocationModel.fromMap(
      map: MockRemoteLocationResponse.ouagadougo,
      suggestion: suggestion,
    );

    StorageController.to
        .storeRemoteLocationData(map: modelFromResponse.toMap());
  });

  tearDownAll(() async {
    await StorageController.to.clearAllStorage();
  });

  group('remote location model test: ', () {
    test('RemoteLocationModel.fromMap initializes as expected', () {
      const regularModel = RemoteLocationModel(
        remoteLat: 12.3714277,
        remoteLong: -1.5196603,
        city: 'Ouagadougou',
        state: '',
        country: 'Burkina Faso',
        longNameList: null,
      );

      expect(regularModel, modelFromResponse);
    });

    test('RemoteLocationModel.fromStorage initializes as expected', () {
      final modelFromStorage = RemoteLocationModel.fromStorage(
        StorageController.to.restoreRemoteLocationData(),
      );

      print('stop');

      expect(modelFromStorage, modelFromResponse);
    });

    test('long multi word city name populates longNameList', () {
      const suggestion = SearchSuggestion(
        placeId: 'ChIJbTmTWJzr3IARlqst5hfsH7A',
        description: 'Rancho Santa Margarita, CA, USA',
      );

      final modelFromResponse = RemoteLocationModel.fromMap(
        map: MockRemoteLocationResponse.newcastle,
        suggestion: suggestion,
      );

      final list = ['Rancho', 'Santa', 'Margarita'];

      expect(modelFromResponse.longNameList, list);
    });

    test('state gets populated when search is in US', () {
      const suggestion = SearchSuggestion(
        placeId: 'ChIJZYIRslSkIIYRtNMiXuhbBts',
        description: 'New Orleans, LA, USA',
      );
      final modelFromResponse = RemoteLocationModel.fromMap(
        map: MockRemoteLocationResponse.newOrleans,
        suggestion: suggestion,
      );
      expect(modelFromResponse.state, 'LA');
    });

    test('Unwanted formatting of city name gets corrected', () {
      const suggestion = SearchSuggestion(
        placeId: 'ChIJzWRvDH6FfUgRkWGncrBS4gs',
        description: 'Newcastle upon Tyne, UK',
      );

      final modelFromResponse = RemoteLocationModel.fromMap(
        map: MockRemoteLocationResponse.newOrleans,
        suggestion: suggestion,
      );
      expect(modelFromResponse.city, 'Newcastle');
    });

    /// Search suggestions lists "Calcutta" but the findDetailsFromPlaceId
    /// shows "Kolkata" this checks that app displays what is shown
    /// on the search suggestion
    test('mismatched suggestion and search names get matched', () {
      const suggestion = SearchSuggestion(
        placeId: 'ChIJZ_YISduC-DkRvCxsj-Yw40M',
        description: 'Calcutta, West Bengal, India',
      );
      final modelFromResponse = RemoteLocationModel.fromMap(
        map: MockRemoteLocationResponse.calcutta,
        suggestion: suggestion,
      );
      expect(modelFromResponse.city, 'Calcutta');
    });
  });
}
