import 'package:epic_skies/utils/logging/app_debug_log.dart';
import 'package:flutter/material.dart';

class LifeCycleManager extends StatefulWidget {
  const LifeCycleManager({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<LifeCycleManager> createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
    }
    _logLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _logLifecycleState(AppLifecycleState state) {
    AppDebug.log('AppLifecycleState: $state', name: 'LifeCycleManager');
  }
}
