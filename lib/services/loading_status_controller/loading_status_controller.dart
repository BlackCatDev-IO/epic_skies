import 'package:get/get.dart';

class LoadingStatusController extends GetxController {
  static LoadingStatusController get to => Get.find();
  String statusString =
      'Fetching your current location. This may take a bit longer on the first install';

  void updateLocationStatus() {
    statusString = 'Fetching your local weather data!';
    update();
  }
}

class WelcomeScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(LoadingStatusController());
  }
}
