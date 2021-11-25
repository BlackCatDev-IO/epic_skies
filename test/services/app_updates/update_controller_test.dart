import 'package:epic_skies/core/database/storage_controller.dart';
import 'package:epic_skies/services/app_updates/update_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../mocks/mock_api_responses/mock_weather_responses.dart';
import '../../test_utils.dart';

void main() {
  setUp(() async {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    WidgetsFlutterBinding.ensureInitialized();

    Get.put(StorageController());
    Get.put(UpdateController());
    await StorageController.to.initAllStorage();

    PackageInfo.setMockInitialValues(
      appName: 'epic_skies',
      packageName: 'test_package',
      version: '0.1',
      buildNumber: '1',
      buildSignature: 'com.blackcatdev',
    );

    /// storing mock data to simulate an app that has been opened at least
    /// once before
    StorageController.to
        .storeWeatherData(map: MockWeatherResponse.bronxWeather);
  });

  group('Update Controller Tests', () {
    test(
      'current app version gets stored into local storage when storeCurrentAppVersion is called',
      () {
        UpdateController.to.storeCurrentAppVersion();
        final storedAppVersion = StorageController.to.lastInstalledAppVersion();
        expect(storedAppVersion, '0.1');
      },
    );

    test(
        'currentAppVersion in UpdateController gets updated to app version when checkForFirstInstallOfUpdatedAppVersion is called',
        () async {
      UpdateController.to.storeCurrentAppVersion();

      await UpdateController.to.checkForFirstInstallOfUpdatedAppVersion();

      expect(UpdateController.to.currentAppVersion, '0.1');
    });

    /// using testWidget to create BuildContext for Get.dialog in
    /// checkForFirstInstallOfUpdatedAppVersion function

    testWidgets(
        'UpdateController.to.currentAppVersion gets updated and app version gets stored when user runs updated version for the first time',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialWidgetTestAncestorWidget(
          child: Container(),
        ),
      );

      String storedAppVersion = StorageController.to.lastInstalledAppVersion()!;
      expect(storedAppVersion, '0.1');

      PackageInfo.setMockInitialValues(
        appName: 'epic_skies',
        packageName: 'test_package',
        version: '0.2',
        buildNumber: '1',
        buildSignature: 'com.blackcatdev',
      );

      await UpdateController.to.checkForFirstInstallOfUpdatedAppVersion();

      storedAppVersion = StorageController.to.lastInstalledAppVersion()!;
      expect(storedAppVersion, '0.2');
      expect(UpdateController.to.currentAppVersion, '0.2');
    });

    testWidgets(
        'Dialog is shown when user runs updated version for the first time',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialWidgetTestAncestorWidget(
          child: Container(),
        ),
      );

      PackageInfo.setMockInitialValues(
        appName: 'epic_skies',
        packageName: 'test_package',
        version: '0.2',
        buildNumber: '1',
        buildSignature: 'com.blackcatdev',
      );

      await UpdateController.to.checkForFirstInstallOfUpdatedAppVersion();

      expect(Get.isDialogOpen, true);
    });
  });
}
