// ignore_for_file: strict_raw_type

import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppDebug {
  static void log(String message, {String? name, Object? error}) {
    dev.log(message, name: name ?? '', error: error ?? '');
  }

  static void logBlocTransition(Transition transition, String name) {
    final log = '''
Event: ${transition.event} 
Current State: 
      ${transition.currentState} 
Next State: 
      ${transition.nextState} \n
''';

    dev.log(log, name: name);
  }

  static void logSentryError(
    String message, {
    required String name,
    StackTrace? stack,
    Hint? hint,
  }) {
    dev.log(message, error: message, name: 'Error');
    if (kReleaseMode) {
      Sentry.captureException(message, stackTrace: stack, hint: hint);
    }
  }
}
