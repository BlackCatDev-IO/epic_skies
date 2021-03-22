import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class LifeCycleController extends SuperController {
  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    debugPrint('on in inactive');
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    debugPrint('on pause');
  }

  @override
  void onResumed() {
    debugPrint('on resume');
    // TODO: implement onResumed
  }
}
