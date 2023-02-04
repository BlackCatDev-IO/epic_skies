import 'dart:async';

import 'package:epic_skies/repositories/system_info_repository.dart';
import 'package:epic_skies/services/app_updates/bloc/app_update_state.dart';
import 'package:epic_skies/services/app_updates/utils/change_log_string.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

export 'app_update_state.dart';

part 'app_update_event.dart';

/// Responsible for notifying the user of new features via a dialog when they
/// update the app
class AppUpdateBloc extends HydratedBloc<AppUpdateEvent, AppUpdateState> {
  /// All AppUpdateBloc data comes from the SystemInfoRepository
  AppUpdateBloc({required SystemInfoRepository systemInfo})
      : _systemInfo = systemInfo,
        super(const AppUpdateState()) {
    on<AppInitInfoOnAppStart>(_onAppInitInfoOnAppStart);
  }

  final SystemInfoRepository _systemInfo;

  Future<void> _onAppInitInfoOnAppStart(
    AppInitInfoOnAppStart event,
    Emitter<AppUpdateState> emit,
  ) async {
    if (event.isNewInstall) {
      emit(
        state.copyWith(
          status: AppUpdateStatus.notUpdated,
          currentAppVersion: _systemInfo.currentAppVersion,
          changeLog: ChangeLog.log(
            currentVersion: _systemInfo.currentAppVersion,
            newChanges: _systemInfo.mostRecentChanges,
          ),
          updatedChanges: _systemInfo.mostRecentChanges,
        ),
      );
      return;
    }

    if (_systemInfo.previousAppVersion != _systemInfo.currentAppVersion) {
      emit(
        state.copyWith(
          status: AppUpdateStatus.updated,
          currentAppVersion: _systemInfo.currentAppVersion,
          changeLog: ChangeLog.log(
            currentVersion: _systemInfo.currentAppVersion,
            newChanges: _systemInfo.mostRecentChanges,
          ),
          updatedChanges: _systemInfo.mostRecentChanges,
        ),
      );
    }
    _systemInfo.storeAppVersion();
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
