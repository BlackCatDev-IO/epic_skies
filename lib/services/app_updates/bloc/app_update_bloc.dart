import 'dart:async';

import 'package:epic_skies/repositories/system_info_repository.dart';
import 'package:epic_skies/services/app_updates/bloc/app_update_state.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

export 'app_update_state.dart';

part 'app_update_event.dart';

/// Responsible for notifying the user of new features via a dialog when they
/// update the app
class AppUpdateBloc extends HydratedBloc<AppUpdateEvent, AppUpdateState> {
  /// All AppUpdateBloc data comes from the SystemInfoRepository
  AppUpdateBloc({SystemInfoRepository? systemInfo})
      : _systemInfo = systemInfo ?? GetIt.I<SystemInfoRepository>(),
        super(const AppUpdateState()) {
    on<AppInitInfoOnAppStart>(_onAppInitInfoOnAppStart);
  }

  final SystemInfoRepository _systemInfo;

  Future<void> _onAppInitInfoOnAppStart(
    AppInitInfoOnAppStart event,
    Emitter<AppUpdateState> emit,
  ) async {
    if (state.status.isFirstInstall) {
      emit(
        state.copyWith(
          status: AppUpdateStatus.notUpdated,
          currentAppVersion: _systemInfo.currentAppVersion,
          changeLog: _systemInfo.changeLog,
          updatedChanges: _systemInfo.mostRecentChanges,
        ),
      );
      return;
    }

    if (state.currentAppVersion != _systemInfo.currentAppVersion) {
      emit(
        state.copyWith(
          status: AppUpdateStatus.updated,
          currentAppVersion: _systemInfo.currentAppVersion,
          changeLog: _systemInfo.changeLog,
          updatedChanges: _systemInfo.mostRecentChanges,
        ),
      );
    } else {
      emit(state.copyWith(status: AppUpdateStatus.notUpdated));
    }
  }

  @override
  AppUpdateState? fromJson(Map<String, dynamic> json) {
    return AppUpdateState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AppUpdateState state) {
    return state.toMap();
  }
}
