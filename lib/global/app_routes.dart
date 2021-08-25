import 'package:epic_skies/misc/test_page.dart';
import 'package:epic_skies/services/utils/asset_image_controllers/image_gallery_controller.dart';
import 'package:epic_skies/services/utils/image_credit_controller/image_credit_controller.dart';
import 'package:epic_skies/view/screens/custom_search_delegate.dart';
import 'package:epic_skies/view/screens/settings_screens/about_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/bg_settings_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/drawer_animator.dart';
import 'package:epic_skies/view/screens/settings_screens/gallery_image_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/image_credit_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/units_screen.dart';
import 'package:epic_skies/view/screens/tab_screens/home_tab_view.dart';
import 'package:epic_skies/view/screens/welcome_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: WelcomeScreen.id, page: () => const WelcomeScreen()),
    GetPage(name: DrawerAnimator.id, page: () => const DrawerAnimator()),
    GetPage(name: HomeTabView.id, page: () => HomeTabView()),
    GetPage(name: UnitsScreen.id, page: () => UnitsScreen()),
    GetPage(
        name: BgImageSettingsScreen.id, page: () => BgImageSettingsScreen()),
    GetPage(
        name: WeatherImageGallery.id,
        page: () => WeatherImageGallery(),
        bindings: [ImageGalleryBindings()]),
    GetPage(
      name: CustomSearchDelegate.id,
      page: () => const CustomSearchDelegate(),
    ),
    GetPage(name: AboutPage.id, page: () => const AboutPage()),
    GetPage(
        name: ImageCreditScreen.id,
        page: () => const ImageCreditScreen(),
        bindings: [ImageCreditBindings()]),
    GetPage(name: TestPage.id, page: () => TestPage()),
  ];
}
