import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static Future<void> launchInBrowser({required String url}) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
