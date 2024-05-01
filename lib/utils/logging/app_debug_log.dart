import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

final _loggerColors = {
  TalkerLogType.info: AnsiPen()..yellow(),
};

class AppDebug {
  static final logger = TalkerFlutter.init(
    settings: TalkerSettings(
      colors: _loggerColors,
    ),
  );

  static void log(
    String message, {
    String? name,
    Object? error,
    StackTrace? stack,
    bool isError = false,
  }) {
    if (isError) {
      logger.error('$name $message', error, stack);
    } else {
      logger.info('$name $message', error);
    }
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
