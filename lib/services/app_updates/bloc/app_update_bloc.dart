import 'dart:async';

import 'package:epic_skies/repositories/system_info_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'app_update_state.dart';

export 'app_update_state.dart';
part 'app_update_event.dart';

class AppUpdateBloc extends HydratedBloc<AppUpdateEvent, AppUpdateState> {
  AppUpdateBloc({required SystemInfoRepository systemInfo})
      : _systemInfo = systemInfo,
        super(const AppUpdateState()) {
    on<AppInitInfoOnAppStart>(_onAppInitInfoOnAppStart);
  }

  String _currentAppVersion = '';
  String _updateChanges = '';

  final SystemInfoRepository _systemInfo;

  Future<void> _onAppInitInfoOnAppStart(
    AppInitInfoOnAppStart event,
    Emitter<AppUpdateState> emit,
  ) async {
    _updateChanges = 'Improved address display formating';

    _currentAppVersion = _systemInfo.currentAppVersion;
    emit(
      state.copyWith(
        status: AppUpdateStatus.notUpdated,
        updatedChanges: _updateChanges,
        changeLog: _aboutScreenDisplay,
      ),
    );

    if (_systemInfo.previousAppVersion != _systemInfo.currentAppVersion) {
      _updateChanges = 'Improved address display formating';
      emit(
        state.copyWith(
          status: AppUpdateStatus.updated,
          previousAppVersion: _systemInfo.previousAppVersion,
          currentAppVersion: _systemInfo.currentAppVersion,
          changeLog: _aboutScreenDisplay,
          updatedChanges: _updateChanges,
        ),
      );
      _systemInfo.storeAppVersion();
    }
  }

  String get _aboutScreenDisplay => '''
App Version: $_currentAppVersion

Changelog: 

$_updateChanges

0.2.8

- Replace WeatherData provider

- Internal bug fixes

0.2.4

- Fixed bug where data shows up blank based on a variation of the weather API response

0.2.3

- Implemented search by postal code  

- Search history is now re-orderable

- Fixed text overflow issues on hourly page

- Fixed mismatching data between hourly forecast on home page and hourly page

0.2.2

- Search Local Weather button now shows current weather info, and is visible on Locations tab (thanks Inti!)

- Selecting user bg image from device now navigates to home screen after selection

- Fixed bug where user selected bg image photo from device wasn't persisted after restart

- Fixed bug that showed Fahrenheit temps on "feels like" hourly tab when celsius was selected

0.2.1 

- Fixed undesirable address formatting 

0.2.0

- (Hopefully) finally fixed endless loading issue on certain phones on first install

0.1.9

- First time loading screen shows indicator of acquiring location

- Back button on Android navigates to home tab instead of out of the app

- Show Dialog on first time running updated app version

- Fix formatting for long multi word city names

- Fix address formatting for UK addresses

- General bug fixes

0.1.8

- Added sunset and sunrise time indicator widgets to hourly forecasts 

- Fixed improper formatting on navigation buttons on Daily page

- Added remote location label for hourly and daily pages

- Added total precipitation to widgets on daily page

- Added icon credit to Vcloud on this page

0.1.7 

- replaced location and permissions package

0.1.6

- (Hopefully) fixed location issues on certain android devices where phone gets stuck on loading screen the first time Epic Skies runs on a new device

- Tapping on any day of the Home Screen daily forecast widget now jumps to corresponding day on Daily Tab (Thanks Michelle!)

- Hourly icons now reflect daytime or night time

- App defaults to local search if last search before closing was a remote location
''';

  @override
  AppUpdateState? fromJson(Map<String, dynamic> json) {
    return AppUpdateState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AppUpdateState state) {
    return state.toJson();
  }
}
