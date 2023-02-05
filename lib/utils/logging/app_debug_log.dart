// ignore_for_file: strict_raw_type

import 'dart:developer' as dev;

import 'package:flutter_bloc/flutter_bloc.dart';

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
}
