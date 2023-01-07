import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get weatherApiKey => dotenv.env['VISUAL_CROSSING_API_KEY']!;
  static String get baseWeatherUrl => dotenv.env['VISUAL_CROSSING_BASE_URL']!;
  static String get mixPanelToken => dotenv.env['MIX_PANEL_TOKEN']!;
}
