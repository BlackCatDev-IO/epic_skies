import 'dart:async';

import 'package:epic_skies/repositories/system_info_repository.dart';
import 'package:epic_skies/services/app_updates/bloc/app_update_state.dart';
import 'package:epic_skies/services/register_services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

export 'app_update_state.dart';

part 'app_update_event.dart';

/// Responsible for notifying the user of new features via a dialog when they
/// update the app
class AppUpdateBloc extends HydratedBloc<AppUpdateEvent, AppUpdateState> {
  /// All AppUpdateBloc data comes from the SystemInfoRepository
  AppUpdateBloc({SystemInfoRepository? systemInfo})
      : _systemInfo = systemInfo ?? getIt<SystemInfoRepository>(),
        super(const AppUpdateState.firstInstall()) {
    on<AppInitInfoOnAppStart>(_onAppInitInfoOnAppStart);
  }

  final SystemInfoRepository _systemInfo;

  Future<void> _onAppInitInfoOnAppStart(
    AppInitInfoOnAppStart event,
    Emitter<AppUpdateState> emit,
  ) async {
    if (state.status.isFirstInstall) {
      return emit(
        state.copyWith(
          status: AppUpdateStatus.notUpdated,
          currentAppVersion: _systemInfo.currentAppVersion,
          updatedChanges: _systemInfo.mostRecentChanges,
        ),
      );
    }

    if (state.currentAppVersion == _systemInfo.currentAppVersion) {
      return emit(
        state.copyWith(
          status: AppUpdateStatus.notUpdated,
          patchVersion: _systemInfo.patchNumber,
        ),
      );
    }

    final shouldShowDialog = _shouldShowAppUpdateDialog(
      minorVersionLowThreshold: event.minorVersionLowThreshold,
      minorVersionHighThreshold: event.minorVersionHighThreshold,
    );

    if (shouldShowDialog) {
      emit(
        state.copyWith(
          status: AppUpdateStatus.updatedShowUpdateDialog,
          currentAppVersion: _systemInfo.currentAppVersion,
          updatedChanges: _systemInfo.mostRecentChanges,
          patchVersion: _systemInfo.patchNumber,
        ),
      );
    } else {
      /// Forcing a state change so BgImageBloc can refetch the
      /// WeatherImageModels in case any new images were added
      emit(
        state.copyWith(
          status: AppUpdateStatus.notUpdated,
          currentAppVersion: _systemInfo.currentAppVersion,
          updatedChanges: _systemInfo.mostRecentChanges,
        ),
      );

      emit(
        state.copyWith(
          status: AppUpdateStatus.updatedNoDialog,
          currentAppVersion: _systemInfo.currentAppVersion,
          updatedChanges: _systemInfo.mostRecentChanges,
          patchVersion: _systemInfo.patchNumber,
        ),
      );
    }
  }

  /// This filters out showing dialogs for minor updates without major features
  /// or fixes so as not to annoy the user with a dialog every time they update
  bool _shouldShowAppUpdateDialog({
    required int minorVersionLowThreshold,
    required int minorVersionHighThreshold,
  }) {
    final versionComponents = state.currentAppVersion.split('.');
    final updatedVersionComponents = _systemInfo.currentAppVersion.split('.');

    final currentMajorVersion = int.parse(versionComponents[0]);
    final currentMinorVersion = int.parse(versionComponents[1]);

    final updatedMajorVersion = int.parse(updatedVersionComponents[0]);
    final updatedMinorVersion = int.parse(updatedVersionComponents[1]);

    if (currentMajorVersion < updatedMajorVersion) {
      return true;
    }

    return currentMinorVersion <= minorVersionLowThreshold &&
        updatedMinorVersion >= minorVersionHighThreshold;
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
