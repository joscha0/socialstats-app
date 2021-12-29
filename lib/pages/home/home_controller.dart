import 'package:get/get.dart';
import 'package:igstats/pages/profile/profile_controller.dart';

class HomeController extends GetxController {
  RxInt tabIndex = 0.obs;

  switchTab(int value) {
    tabIndex.value = value;
    // if (value != 1) {
    //   Get.find<ProfileController>().closeVideoControllers();
    // }
  }
}
