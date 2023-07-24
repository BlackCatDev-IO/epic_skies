import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_update_state.freezed.dart';
part 'app_update_state.g.dart';

enum AppUpdateStatus { firstInstall, notUpdated, updated }

extension AppUpdateStatusX on AppUpdateStatus {
  bool get isFirstInstall => this == AppUpdateStatus.firstInstall;
  bool get isNotUpdated => this == AppUpdateStatus.notUpdated;
  bool get isUpdated => this == AppUpdateStatus.updated;
}

@freezed
class AppUpdateState with _$AppUpdateState {
  const factory AppUpdateState({
    @Default('') String currentAppVersion,
    @Default('') String changeLog,
    @Default('') String updatedChanges,
    @Default(AppUpdateStatus.firstInstall) AppUpdateStatus status,
  }) = _AppUpdateState;

  const AppUpdateState._();

  factory AppUpdateState.fromJson(Map<String, dynamic> json) =>
      _$AppUpdateStateFromJson(json);

  @override
  String toString() {
    return 'AppUpdateState: $status';
  }
}
