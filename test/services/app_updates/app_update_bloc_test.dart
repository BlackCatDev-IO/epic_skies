import 'package:bloc_test/bloc_test.dart';
import 'package:epic_skies/services/app_updates/bloc/app_update_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/init_hydrated_storage.dart';
import '../../mocks/mock_classes.dart';

void main() async {
  late MockSystemInfoRepo mockSystemInfo;

  late String appVersion;
  late String updatedAppVersion;
  late String mostRecentChanges;
  late String changeLog;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    appVersion = '1.0.0';
    updatedAppVersion = '1.1.0';
    mostRecentChanges = 'most_recent_changes';
    changeLog = 'change_log';

    mockSystemInfo = MockSystemInfoRepo();

    initHydratedStorage();

    when(() => mockSystemInfo.initDeviceInfo())
        .thenAnswer((invocation) => Future.value());

    when(() => mockSystemInfo.currentAppVersion).thenReturn(appVersion);
    when(() => mockSystemInfo.mostRecentChanges).thenReturn(mostRecentChanges);
    when(() => mockSystemInfo.changeLog).thenReturn(changeLog);
  });

  group('AppUpdateBloc:', () {
    blocTest<AppUpdateBloc, AppUpdateState>(
      '''
emits `notUpdated` on first install with system info''',
      setUp: () {},
      build: () => AppUpdateBloc(systemInfo: mockSystemInfo),
      act: (AppUpdateBloc bloc) => bloc.add(AppInitInfoOnAppStart()),
      expect: () => <AppUpdateState>[
        AppUpdateState(
          currentAppVersion: appVersion,
          status: AppUpdateStatus.notUpdated,
          changeLog: mockSystemInfo.changeLog,
          updatedChanges: mostRecentChanges,
        ),
      ],
    );

    blocTest<AppUpdateBloc, AppUpdateState>(
      '''
emits `notUpdated` after first install when previous app version from storage equals current app version
''',
      build: () => AppUpdateBloc(systemInfo: mockSystemInfo),
      seed: () => AppUpdateState(
        currentAppVersion: appVersion,
        changeLog: mockSystemInfo.changeLog,
        updatedChanges: mostRecentChanges,
        status: AppUpdateStatus.notUpdated,
      ),
      act: (AppUpdateBloc bloc) => bloc.add(AppInitInfoOnAppStart()),
      expect: () => <AppUpdateState>[], // no changes to seeded state expected
    );

    blocTest<AppUpdateBloc, AppUpdateState>(
      '''
emits `updated` after first install when system info returns different new version
''',
      setUp: () {
        when(() => mockSystemInfo.currentAppVersion)
            .thenReturn(updatedAppVersion);
      },
      build: () => AppUpdateBloc(systemInfo: mockSystemInfo),
      seed: () => AppUpdateState(
        currentAppVersion: appVersion,
        changeLog: mockSystemInfo.changeLog,
        updatedChanges: mostRecentChanges,
        status: AppUpdateStatus.notUpdated,
      ),
      act: (AppUpdateBloc bloc) => bloc.add(AppInitInfoOnAppStart()),
      expect: () => <AppUpdateState>[
        AppUpdateState(
          currentAppVersion: updatedAppVersion,
          changeLog: mockSystemInfo.changeLog,
          updatedChanges: mostRecentChanges,
          status: AppUpdateStatus.updated,
        ),
      ],
    );
  });
}
