import 'package:get/get.dart';

import '../controllers/presensi_today_controller.dart';

class PresensiTodayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PresensiTodayController>(
      () => PresensiTodayController(),
    );
  }
}
