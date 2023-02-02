import 'package:epic_skies/view/screens/search_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/about_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/bg_settings_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/gallery_image_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/image_credit_screen.dart';
import 'package:epic_skies/view/screens/settings_screens/settings_main_page.dart';
import 'package:epic_skies/view/screens/settings_screens/units_screen.dart';
import 'package:epic_skies/view/screens/tab_screens/home_tab_view.dart';
import 'package:epic_skies/view/screens/welcome_screen.dart';

class AppRoutes {
  static final routes = {
    WelcomeScreen.id: (context) => const WelcomeScreen(),
    HomeTabView.id: (context) => HomeTabView(),
    UnitsScreen.id: (context) => UnitsScreen(),
    BgImageSettingsScreen.id: (context) => BgImageSettingsScreen(),
    WeatherImageGallery.id: (context) => WeatherImageGallery(),
    SearchScreen.id: (context) => const SearchScreen(),
    AboutPage.id: (context) => const AboutPage(),
    ImageCreditScreen.id: (context) => const ImageCreditScreen(),
    SettingsMainPage.id: (context) => SettingsMainPage(),
  };
}
