import UIKit
import Flutter
import Firebase
import google_mobile_ads

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    let listTileFactory = ListTileNativeAdFactory()
    FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
        self, factoryId: "listTile", nativeAdFactory: listTileFactory)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
