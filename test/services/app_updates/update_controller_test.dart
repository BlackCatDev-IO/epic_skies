import 'package:epic_skies/services/app_updates/update_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../mocks/mock_classes.dart';
import '../../test_utils.dart';

const path = 'update_controller_test';

Future<void> resetAppVersion() async {
  PackageInfo.setMockInitialValues(
    appName: 'epic_skies',
    packageName: 'test_package',
    version: '0.1',
    buildNumber: '1',
    buildSignature: 'com.blackcatdev',
  );
}

void main() {
  late UpdateController updateController;
  late MockStorageController mockStorage;

  setUp(() async {
    mockStorage = MockStorageController();
    PathProviderPlatform.instance = FakePathProviderPlatform();
    WidgetsFlutterBinding.ensureInitialized();

    resetAppVersion();

    when(() => mockStorage.firstTimeUse()).thenReturn(false);

    when(() => mockStorage.storeAppVersion(appVersion: '0.1'))
        .thenAnswer((_) {});

    when(() => mockStorage.lastInstalledAppVersion()).thenReturn('0.1');

    updateController = UpdateController(mockStorage);
    Get.put(updateController);
  });

  tearDown(() {
    resetAppVersion();
    updateController.storeCurrentAppVersion();
  });

  group('Update Controller Tests', () {
    test(
      'current app version gets stored into local storage when storeCurrentAppVersion is called',
      () async {
        await updateController.storeCurrentAppVersion();
        final storedAppVersion = mockStorage.lastInstalledAppVersion();
        expect(storedAppVersion, updateController.currentAppVersion);
      },
    );

    test(
        'currentAppVersion in UpdateController gets updated to app version when checkForFirstInstallOfUpdatedAppVersion is called',
        () async {
      updateController.storeCurrentAppVersion();

      await updateController.checkForFirstInstallOfUpdatedAppVersion();

      expect(updateController.currentAppVersion, '0.1');
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

      String storedAppVersion = mockStorage.lastInstalledAppVersion()!;
      expect(storedAppVersion, '0.1');

      PackageInfo.setMockInitialValues(
        appName: 'epic_skies',
        packageName: 'test_package',
        version: '0.2',
        buildNumber: '1',
        buildSignature: 'com.blackcatdev',
      );

      when(() => mockStorage.lastInstalledAppVersion()).thenReturn('0.2');

      await updateController.checkForFirstInstallOfUpdatedAppVersion();

      storedAppVersion = mockStorage.lastInstalledAppVersion()!;
      expect(storedAppVersion, '0.2');
      expect(updateController.currentAppVersion, '0.2');
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

      await updateController.checkForFirstInstallOfUpdatedAppVersion();

      expect(Get.isDialogOpen, true);
    });
  });
}
