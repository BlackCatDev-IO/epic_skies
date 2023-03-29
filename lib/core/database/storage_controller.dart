import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

/// All local device storage is managed through this class. Most storage is
/// handled via HydradedBloc/Cubit classes with the exception of a few util
/// storage items
class StorageController {
/* ------------------------------ Storage Keys ------------------------------ */

  static const _localPath = 'local_path';
  static const _firstTime = 'first_time';

  /// Inits storage directory in main.dart before `runApp`
  Future<void> initStorageDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    HydratedBloc.storage =
        await HydratedStorage.build(storageDirectory: directory);

    await HydratedBloc.storage.write(_localPath, directory.path);
  }

/* ------------------------------ Util Storage ------------------------------ */

  /// Used on app start to determine whether to show opening splash screen or
  /// navigate to `HomeTabView`
  bool isNewInstall() {
    if (HydratedBloc.storage.read(_firstTime) == null) {
      HydratedBloc.storage.write(_firstTime, false);

      return true;
    }

    return false;
  }

  void _logStorageController(String message) {
    AppDebug.log(message, name: 'StorageController');
  }
}
