import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AppDebug {
  static final logger = TalkerFlutter.init();

  static void log(String message, {String? name, Object? error}) {
    logger.info('$name $message', error);
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

    logger.info('$name $log');
  }

  static void logSentryError(
    dynamic throwable, {
    required String name,
    StackTrace? stack,
    Hint? hint,
  }) {
    dev.log('$throwable', error: throwable, name: name);
    logger.error(
      '$name $throwable',
      throwable,
      stack,
    );

    if (kReleaseMode) {
      Sentry.captureException(throwable, stackTrace: stack, hint: hint);
    }
  }
}
