import 'package:get/get.dart';

import '../controllers/perizinan_chosen_controller.dart';

class PerizinanChosenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerizinanChosenController>(
      () => PerizinanChosenController(),
    );
  }
}
