import 'dart:async';

import 'package:epic_skies/repositories/system_info_repository.dart';
import 'package:epic_skies/services/app_updates/bloc/app_update_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

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
        changeLog: _updatedChangeLog(),
        currentAppVersion: _currentAppVersion,
        previousAppVersion: _systemInfo.previousAppVersion,
      ),
    );

    if (_systemInfo.previousAppVersion != _systemInfo.currentAppVersion) {
      _updateChanges = 'Improved address display formating';
      emit(
        state.copyWith(
          status: AppUpdateStatus.updated,
          previousAppVersion: _systemInfo.previousAppVersion,
          currentAppVersion: _systemInfo.currentAppVersion,
          changeLog: _updatedChangeLog(),
          updatedChanges: _updateChanges,
        ),
      );
      _systemInfo.storeAppVersion();
    }
  }

  String _updatedChangeLog() {
    return '''
App Version: $_currentAppVersion

Changelog: 

${_systemInfo.mostRecentChanges}
    ''';
  }

  @override
  AppUpdateState? fromJson(Map<String, dynamic> json) {
    return AppUpdateState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AppUpdateState state) {
    return state.toJson();
  }
}
