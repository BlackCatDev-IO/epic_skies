import 'dart:developer' as dev;

class AppDebug {
  static void log(String message, {String? name}) {
    dev.log(message, name: name ?? '');
  }
}
