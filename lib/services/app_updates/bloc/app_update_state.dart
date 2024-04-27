import 'package:dart_mappable/dart_mappable.dart';

part 'app_update_state.mapper.dart';

@MappableEnum()
enum AppUpdateStatus {
  firstInstall,
  notUpdated,
  updatedNoDialog,
  updatedShowUpdateDialog;

  bool get isFirstInstall => this == AppUpdateStatus.firstInstall;
  bool get isNotUpdated => this == AppUpdateStatus.notUpdated;
  bool get isUpdatedNoDialog => this == AppUpdateStatus.updatedNoDialog;
  bool get isUpdatedShowUpdateDialog =>
      this == AppUpdateStatus.updatedShowUpdateDialog;
}

@MappableClass()
class AppUpdateState with AppUpdateStateMappable {
  const AppUpdateState({
    required this.currentAppVersion,
    required this.changeLog,
    required this.updatedChanges,
    required this.status,
  });

  const AppUpdateState.firstInstall()
      : currentAppVersion = '',
        changeLog = '',
        updatedChanges = const [],
        status = AppUpdateStatus.firstInstall;

  final String currentAppVersion;
  final String changeLog;
  final List<String> updatedChanges;
  final AppUpdateStatus status;

  static const fromMap = AppUpdateStateMapper.fromMap;

  @override
  String toString() {
    return '''
AppUpdateState: $status - $currentAppVersion - $changeLog - $updatedChanges''';
  }
}
