import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_update_state.freezed.dart';
part 'app_update_state.g.dart';

enum AppUpdateStatus { updated, notUpdated }

extension AppUpdateStatusX on AppUpdateStatus {
  bool get isUpdated => this == AppUpdateStatus.updated;
  bool get isNotUpdated => this == AppUpdateStatus.notUpdated;
}

@freezed
class AppUpdateState with _$AppUpdateState {
  const factory AppUpdateState({
    @Default('') String currentAppVersion,
    @Default('') String changeLog,
    @Default('') String updatedChanges,
    @Default(AppUpdateStatus.notUpdated) AppUpdateStatus status,
  }) = _AppUpdateState;

  factory AppUpdateState.fromJson(Map<String, dynamic> json) =>
      _$AppUpdateStateFromJson(json);
}
