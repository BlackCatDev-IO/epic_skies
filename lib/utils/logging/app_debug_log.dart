import 'dart:developer' as dev;

import 'package:flutter_bloc/flutter_bloc.dart';

class AppDebug {
  static void log(String message, {String? name}) {
    dev.log(message, name: name ?? '');
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
