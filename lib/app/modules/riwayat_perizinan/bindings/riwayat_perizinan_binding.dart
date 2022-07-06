import 'package:get/get.dart';

import '../controllers/riwayat_perizinan_controller.dart';

class RiwayatPerizinanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiwayatPerizinanController>(
      () => RiwayatPerizinanController(),
    );
  }
}
