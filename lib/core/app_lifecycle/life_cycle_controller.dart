import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class LifeCycleController extends SuperController {
  @override
  void onDetached() {
    debugPrint('on detached');
  }

  @override
  void onInactive() {
    debugPrint('on inactive');
  }

  @override
  void onPaused() {
    debugPrint('on pause');
  }

  @override
  void onResumed() {
    debugPrint('on resume');
  }
}
