import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppDebug {
  static void log(String message, {String? name, Object? error}) {
    dev.log(message, name: name ?? '', error: error ?? '');
  }

  static void logBlocTransition(
    Transition<dynamic, dynamic> transition,
    String name,
  ) {
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
    dynamic throwable, {
    required String name,
    StackTrace? stack,
    Hint? hint,
  }) {
    dev.log('$throwable', error: throwable, name: name);

    if (kReleaseMode) {
      Sentry.captureException(throwable, stackTrace: stack, hint: hint);
    }
  }
}
