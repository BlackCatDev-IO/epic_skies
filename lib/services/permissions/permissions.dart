import 'package:location_permissions/location_permissions.dart';

class Permissions {
  static Future<bool> locationPermissionEnabled() async {
    PermissionStatus permission =
        await LocationPermissions().checkPermissionStatus();

    if (permission == PermissionStatus.granted) {
      return true;
    } else {
      permission = await LocationPermissions().requestPermissions();
      if (permission == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
