import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

/// All local device storage is managed through this class. Most storage is
/// handled via HydradedBloc/Cubit classes with the exception of a few util
/// storage items
class StorageController {
/* ------------------------------ Storage Keys ------------------------------ */

  /// Inits storage directory in main.dart before `runApp`
  Future<void> initStorageDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    HydratedBloc.storage =
        await HydratedStorage.build(storageDirectory: directory);
  }
}
