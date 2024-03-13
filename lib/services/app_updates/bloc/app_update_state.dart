import 'package:dart_mappable/dart_mappable.dart';

part 'app_update_state.mapper.dart';

@MappableEnum()
enum AppUpdateStatus {
  firstInstall,
  notUpdated,
  updated;

  bool get isFirstInstall => this == AppUpdateStatus.firstInstall;
  bool get isNotUpdated => this == AppUpdateStatus.notUpdated;
  bool get isUpdated => this == AppUpdateStatus.updated;
}

@MappableClass()
class AppUpdateState with AppUpdateStateMappable {
  const AppUpdateState({
    this.currentAppVersion = '',
    this.changeLog = '',
    this.updatedChanges = '',
    this.status = AppUpdateStatus.firstInstall,
  });

  final String currentAppVersion;
  final String changeLog;
  final String updatedChanges;
  final AppUpdateStatus status;

  static const fromMap = AppUpdateStateMapper.fromMap;

  @override
  String toString() {
    return 'AppUpdateState: $status';
  }
}
