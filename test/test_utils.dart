import 'dart:developer';

import 'package:epic_skies/global/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// provides necessary Material ancestors and intializes Sizer device screen
/// sizes for widget tests
class MaterialWidgetTestAncestorWidget extends StatelessWidget {
  const MaterialWidgetTestAncestorWidget({
    super.key,
    required this.child,
    this.navigatorObserver,
  });

  final Widget child;
  final NavigatorObserver? navigatorObserver;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: child),
      routes: AppRoutes.routes,
      navigatorObservers: navigatorObserver == null
          ? <NavigatorObserver>[]
          : [navigatorObserver!],
    );
  }
}

/// disables irrelevant overflow errors

// ignore: prefer_function_declarations_over_variables
// ignore: inference_failure_on_function_return_type
Function(FlutterErrorDetails) ignoreOverflowErrors = (
  FlutterErrorDetails details, {
  bool forceReport = false,
}) {
  var ifIsOverflowError = false;

  // Detect overflow error.
  final exception = details.exception;
  if (exception is FlutterError) {
    ifIsOverflowError = !exception.diagnostics.any(
      (e) => e.value.toString().startsWith(
            'A RenderFlex overflowed by',
          ),
    );
  }

  // Ignore if is overflow error.
  if (ifIsOverflowError) {
    log('Overflow error.');
  }

  // Throw others errors.
  else {
    FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
  }
};

/// path_provider now uses a PlatformInterface, meaning that not all platforms
/// share the a single PlatformChannel-based implementation. With that change,
/// tests should be updated to mock PathProviderPlatform rather than
///  PlatformChannel.
class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async {
    return kTemporaryPath;
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return kApplicationSupportPath;
  }

  @override
  Future<String?> getLibraryPath() async {
    return kLibraryPath;
  }

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return kApplicationDocumentsPath;
  }

  @override
  Future<String?> getExternalStoragePath() async {
    return kExternalStoragePath;
  }

  @override
  Future<List<String>?> getExternalCachePaths() async {
    return <String>[kExternalCachePath];
  }

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async {
    return <String>[kExternalStoragePath];
  }

  @override
  Future<String?> getDownloadsPath() async {
    return kDownloadsPath;
  }
}

const String kTemporaryPath = 'temporaryPath';
const String kApplicationSupportPath = 'applicationSupportPath';
const String kDownloadsPath = 'downloadsPath';
const String kLibraryPath = 'libraryPath';
const String kApplicationDocumentsPath = 'applicationDocumentsPath';
const String kExternalCachePath = 'externalCachePath';
const String kExternalStoragePath = 'externalStoragePath';
