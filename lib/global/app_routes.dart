import 'package:epic_skies/misc/test_page.dart';
import 'package:epic_skies/services/asset_controllers/image_gallery_controller.dart';
import 'package:epic_skies/services/image_credits/image_credit_controller.dart';
import 'package:epic_skies/services/loading_status_controller/loading_status_controller.dart';
import 'package:epic_skies/view/screens/search_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/about_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/bg_settings_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/drawer_animator.dart';
import 'package:epic_skies/view/screens/settings_screens/gallery_image_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/image_credit_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/units_screen.dart';
import 'package:epic_skies/view/screens/welcome_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: WelcomeScreen.id,
      page: () => const WelcomeScreen(),
      binding: WelcomeScreenBindings(),
    ),
    GetPage(name: DrawerAnimator.id, page: () => const DrawerAnimator()),
    GetPage(name: UnitsScreen.id, page: () => UnitsScreen()),
    GetPage(
      name: BgImageSettingsScreen.id,
      page: () => BgImageSettingsScreen(),
    ),
    GetPage(
      name: WeatherImageGallery.id,
      page: () => WeatherImageGallery(),
      binding: ImageGalleryBindings(),
    ),
    GetPage(
      name: SearchScreen.id,
      page: () => const SearchScreen(),
    ),
    GetPage(name: AboutPage.id, page: () => const AboutPage()),
    GetPage(
      name: ImageCreditScreen.id,
      page: () => const ImageCreditScreen(),
      binding: ImageCreditBindings(),
    ),
    GetPage(name: TestPage.id, page: () => TestPage()),
  ];
}
