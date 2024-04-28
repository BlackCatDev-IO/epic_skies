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

  late String updateOnePoint5Message;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    appVersion = '1.0.0';
    updatedAppVersion = '1.1.0';
    mostRecentChanges = 'most_recent_changes';
    changeLog = 'change_log';

    updateOnePoint5Message = '''
Thanks for updating to 1.5.0! This update includes:
 - Much improved weather accuracy with Apples WeatherKit (formerly Dark Sky) weather API
 - Severe weather alerts and precipitation warnings on the home screen
 - Fix for "EuropeKiev" timezone
 ''';

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
      seed: AppUpdateState.firstInstall,
      act: (AppUpdateBloc bloc) => bloc.add(
        AppInitInfoOnAppStart(
          minorVersionLowThreshold: 1,
          minorVersionHighThreshold: 5,
        ),
      ),
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
      act: (AppUpdateBloc bloc) => bloc.add(
        AppInitInfoOnAppStart(
          minorVersionLowThreshold: 1,
          minorVersionHighThreshold: 5,
        ),
      ),
      expect: () => <AppUpdateState>[], // no changes to seeded state expected
    );

    blocTest<AppUpdateBloc, AppUpdateState>(
      '''
emits new app version number but still a `notUpdated` status when updated version
doesn't meet threshold to show a dialog to the user
''',
      setUp: () {
        when(() => mockSystemInfo.currentAppVersion)
            .thenReturn(updatedAppVersion);
        when(() => mockSystemInfo.mostRecentChanges)
            .thenReturn(mostRecentChanges);
      },
      build: () => AppUpdateBloc(systemInfo: mockSystemInfo),
      seed: () => AppUpdateState(
        currentAppVersion: appVersion,
        changeLog: mockSystemInfo.changeLog,
        updatedChanges: mostRecentChanges,
        status: AppUpdateStatus.notUpdated,
      ),
      act: (AppUpdateBloc bloc) => bloc.add(
        AppInitInfoOnAppStart(
          minorVersionLowThreshold: 5,
          minorVersionHighThreshold: 5,
        ),
      ),
      expect: () => <AppUpdateState>[
        AppUpdateState(
          currentAppVersion: updatedAppVersion,
          changeLog: mockSystemInfo.changeLog,
          updatedChanges: mostRecentChanges,
          status: AppUpdateStatus.notUpdated,
        ),
      ],
    );

    blocTest<AppUpdateBloc, AppUpdateState>(
      '''
emits `AppUpdateStatus.updated` && `update115Mesasage` when updating from 
< 1.5.X to >= 1.5''',
      setUp: () {
        when(() => mockSystemInfo.currentAppVersion).thenReturn('1.5.0');
        when(() => mockSystemInfo.mostRecentChanges)
            .thenReturn(updateOnePoint5Message);
      },
      build: () => AppUpdateBloc(systemInfo: mockSystemInfo),
      seed: () => AppUpdateState(
        currentAppVersion: '1.1.2',
        changeLog: mockSystemInfo.changeLog,
        updatedChanges: mostRecentChanges,
        status: AppUpdateStatus.notUpdated,
      ),
      act: (AppUpdateBloc bloc) => bloc.add(
        AppInitInfoOnAppStart(
          minorVersionLowThreshold: 1,
          minorVersionHighThreshold: 5,
        ),
      ),
      expect: () => <AppUpdateState>[
        AppUpdateState(
          currentAppVersion: '1.5.0',
          changeLog: mockSystemInfo.changeLog,
          updatedChanges: updateOnePoint5Message,
          status: AppUpdateStatus.updatedShowUpdateDialog,
        ),
      ],
    );

    blocTest<AppUpdateBloc, AppUpdateState>(
      '''
emits `AppUpdateStatus.notUpdated` when `minorVersionHighThreshold` condition 
isn't met''',
      setUp: () {
        when(() => mockSystemInfo.currentAppVersion).thenReturn('1.4.2');
        when(() => mockSystemInfo.mostRecentChanges)
            .thenReturn(mostRecentChanges);
      },
      build: () => AppUpdateBloc(systemInfo: mockSystemInfo),
      seed: () => AppUpdateState(
        currentAppVersion: '1.1.2',
        changeLog: mockSystemInfo.changeLog,
        updatedChanges: mostRecentChanges,
        status: AppUpdateStatus.notUpdated,
      ),
      act: (AppUpdateBloc bloc) => bloc.add(
        AppInitInfoOnAppStart(
          minorVersionLowThreshold: 2,
          minorVersionHighThreshold: 5,
        ),
      ),
      expect: () => <AppUpdateState>[
        AppUpdateState(
          currentAppVersion: '1.4.2',
          changeLog: mockSystemInfo.changeLog,
          updatedChanges: mostRecentChanges,
          status: AppUpdateStatus.notUpdated,
        ),
      ],
    );
  });
}
